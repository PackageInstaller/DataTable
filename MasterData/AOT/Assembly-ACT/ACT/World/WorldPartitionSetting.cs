using Bamboo.AssetField;

namespace ACT.World;

public static class WorldPartitionSetting
{
	private static WorldPartitionSettingData _data;

	private const string ConfigWorldPartitionSettingDataAddress = "ConfigWorldPartitionSettingData";

	public static WorldPartitionSettingData Data => GetDataInstanceRuntime();

	private static WorldPartitionSettingData GetDataInstanceRuntime()
	{
		AssetLoadHandle assetLoadHandle = AssetStationManager.SceneStation.Load<WorldPartitionSettingData>("ConfigWorldPartitionSettingData");
		if (!assetLoadHandle.IsValid || !assetLoadHandle.IsDone)
		{
			return null;
		}
		return assetLoadHandle.Result as WorldPartitionSettingData;
	}
}
