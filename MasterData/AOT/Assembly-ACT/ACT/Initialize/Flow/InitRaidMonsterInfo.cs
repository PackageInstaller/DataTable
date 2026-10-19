using ACT.Config;
using Bamboo.AssetField;

namespace ACT.Initialize.Flow;

public class InitRaidMonsterInfo : RuntimeLoadFlow
{
	public InitRaidMonsterInfo()
		: base("InitRaidMonsterInfo")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		AssetStationManager.Root.LoadAsync<RaidMonsterInfo>("Configs/RaidMonsterPointInfo", (AssetLoadHandle l) =>
		{
			GameLoader.monsterInfo = l.As<RaidMonsterInfo>();
			WaitInitializer.CompleteOne();
		});
	}
}
