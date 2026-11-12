using UnityEngine;

[AddComponentMenu("触发器结果/关卡事件/关卡战斗结束", 1)]
public class Task_LevelEnd : TaskCellBase
{
	protected override void OnExecute()
	{
		AdventureChangeLevelStateEvent adventureChangeLevelStateEvent = AdventureChangeLevelStateEvent.Generate();
		adventureChangeLevelStateEvent.levelState = HotfixEnum.levelState.Success;
		adventureChangeLevelStateEvent.clearMonster = true;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureChangeLevelStateEvent);
		EndAction();
	}
}
