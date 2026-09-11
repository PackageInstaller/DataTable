public static class StatUtil
{
	public static int[] GetAndClearCombatOperations()
	{
		WorldStateManager worldSatetManager = ((BattleScene)NScene.GetCurrentScene()).GetWorldSatetManager();
		int[] result = worldSatetManager.ClickStaticsData.ToArray();
		worldSatetManager.ClickStaticsData.Clear();
		return result;
	}
}
