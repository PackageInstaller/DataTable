namespace Ase;

public static class ActivityEquipBgIdMapper
{
	public static int GetBgTypeId(int activityTypeId)
	{
		return activityTypeId switch
		{
			27 => 25, 
			28 => 26, 
			_ => activityTypeId, 
		};
	}

	public static string GetBgAssetPath(int activityTypeId)
	{
		int bgTypeId = GetBgTypeId(activityTypeId);
		return AssetUtility.GetUIItemAsset($"Activity/Equip/Equip{bgTypeId}Bg");
	}
}
