using UnityEngine;

[AddComponentMenu("触发器结果/Roguelike关卡事件/关卡计时开始", 0)]
public class Task_LevelTimeing : TaskCellBase
{
	protected override void OnExecute()
	{
		AdventureLevelStartTimingEvent adventureLevelStartTimingEvent = AdventureLevelStartTimingEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelStartTimingEvent);
		MonoSingleton<LuaManager>.Instance?.FireEvent(adventureLevelStartTimingEvent.type);
		MonoSingleton<LuaManager>.Instance?.FireEvent("OnEvent_ShowRtChallengeTime");
		EndAction();
		ModuleController<AdventureModuleController>.Instance?.PlayBossBgm();
	}
}
