using ACT.Config;
using Bamboo.AssetField;

namespace ACT.Initialize.Flow;

public class ConnectNodeModelLoadFlow : RuntimeLoadFlow
{
	public ConnectNodeModelLoadFlow()
		: base("ConnectNodeModelLoad")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		AssetStationManager.Root.LoadAsync<ConnectNodeModelConfig>("Configs/ConnectNodeModelConfig", (AssetLoadHandle l) =>
		{
			GameLoader.connectNodeModelConfig = l.As<ConnectNodeModelConfig>();
			WaitInitializer.CompleteOne();
		});
	}
}
