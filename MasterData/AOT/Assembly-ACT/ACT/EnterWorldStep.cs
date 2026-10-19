using ACT.Battle;
using Fundamental;

namespace ACT;

internal class EnterWorldStep : WorldLoadStepOperation
{
	internal override async void OnStart()
	{
		WorldData worldData = new WorldData();
		worldData.IsReconnect = true;
		await Singleton<GameManager>.instance.worldManager.EnterWorld(MonoECS.instance.sceneStatus, worldData);
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
