using ACT.Battle;
using ACT.Event;
using ACT.MissionSystem;
using ACT.Model;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT;

internal class AfterLoadStep : WorldLoadStepOperation
{
	internal override async void OnStart()
	{
		Model<GuideModel>.Interface?.Begin();
		Singleton<MissionManager>.instance.Begin();
		MonoECS.instance.ResetInput();
		MonoECS.instance.CoSynchronizationTime().Forget();
		Singleton<GameManager>.instance.audioManager.SetListener(MonoECS.instance.mainEntity.GetModel(), 0);
		Singleton<GameManager>.instance.audioManager.SetGameState(enabled: true);
		MonoECS.instance.SetStartWorldState(state: true);
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Game_Start, null);
		await UniTask.WaitUntil(() => !Singleton<LoadManager>.instance.InLoading);
		Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Playing);
	}

	internal override void OnUpdate()
	{
	}
}
