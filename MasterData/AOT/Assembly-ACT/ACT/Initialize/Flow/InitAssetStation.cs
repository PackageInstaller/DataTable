using Bamboo.AssetField;
using Bamboo.ImageCenter;
using Fundamental;

namespace ACT.Initialize.Flow;

public class InitAssetStation : RuntimeLoadFlow
{
	public InitAssetStation()
		: base("InitGameUtility")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		Singleton<AssetStationManager>.instance.SpawnStation();
		ImageManager.SpawnImageManager(new YooAssetLoader());
		WaitInitializer.CompleteOne();
	}
}
