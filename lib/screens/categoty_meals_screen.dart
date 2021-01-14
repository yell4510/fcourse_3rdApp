import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routName = '/category-meals';

  final List<Meal> availaleMeals;
  CategoryMealsScreen(this.availaleMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displaedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displaedMeals = widget.availaleMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displaedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displaedMeals[index].id,
            title: displaedMeals[index].title,
            imageUrl: displaedMeals[index].imageUrl,
            duration: displaedMeals[index].duration,
            affordability: displaedMeals[index].affordability,
            complexity: displaedMeals[index].complexity,
          );
        },
        itemCount: displaedMeals.length,
      ),
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
    );
  }
}
