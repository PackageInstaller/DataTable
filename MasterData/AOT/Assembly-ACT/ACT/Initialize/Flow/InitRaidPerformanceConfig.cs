using ACT.Config;
using Bamboo.AssetField;

namespace ACT.Initialize.Flow;

public class InitRaidPerformanceConfig : RuntimeLoadFlow
{
	public InitRaidPerformanceConfig()
		: base("InitRaidPerformanceConfig")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		AssetStationManager.Root.LoadAsync<RaidPerformanceConfig>("Configs/RaidPerformanceConfig", (AssetLoadHandle l) =>
		{
			GameLoader.raidPerformanceConfig = l.As<RaidPerformanceConfig>();
			WaitInitializer.CompleteOne();
		});
	}
}
