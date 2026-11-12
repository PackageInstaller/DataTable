using UnityEngine;

[AddComponentMenu("触发器结果/关卡事件/发送战斗整备消息", 0)]
public class Task_BattleReadyMsg : TaskCellBase
{
	protected override void OnExecute()
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(AdventureBattleReadyEvent.Generate());
		EndAction();
	}
}
