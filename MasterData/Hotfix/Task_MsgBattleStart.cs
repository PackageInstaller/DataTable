using UnityEngine;

[AddComponentMenu("触发器结果/关卡事件/发送战斗开始消息", 0)]
public class Task_MsgBattleStart : TaskCellBase
{
	protected override void OnExecute()
	{
		AdventureMsgBattleStartEvent aEvent = AdventureMsgBattleStartEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		EndAction();
	}
}
