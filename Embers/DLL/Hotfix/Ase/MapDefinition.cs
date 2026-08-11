namespace Ase;

public static class MapDefinition
{
	public static bool GetExploreItemConfigData(int mapId, int itemId, out int num, out int weight)
	{
		return GetExploreItemConfigData(GameEntry.DataTable.GetDataRow((DRMapExplore p) => p.MapId == mapId && p.ItemTypeId.Contains(itemId)), itemId, out num, out weight);
	}

	public static bool GetExploreItemConfigData(DRMapExplore config, int itemId, out int num, out int weight)
	{
		num = 0;
		weight = 0;
		if (config == null || !config.ItemTypeId.Contains(itemId))
		{
			return false;
		}
		int num2 = config.ItemTypeId.FindLastIndex((int p) => p == itemId);
		if (num2 < 0 || config.Num.Count <= num2 || config.Weight.Count <= num2)
		{
			return false;
		}
		num = config.Num[num2];
		weight = config.Weight[num2];
		return true;
	}
}
