namespace ACT.UI;

public static class TaskViewV3Utility
{
	public static bool TryGetCategory(int missionType, out TaskCategoryV3 category)
	{
		switch (missionType)
		{
		case 1:
		case 2:
			category = TaskCategoryV3.Main;
			return true;
		case 3:
		case 4:
			category = TaskCategoryV3.Side;
			return true;
		case 5:
		case 6:
			category = TaskCategoryV3.Daily;
			return true;
		case 7:
			category = TaskCategoryV3.Legend;
			return true;
		default:
			category = TaskCategoryV3.All;
			return false;
		}
	}
}
