using UnityEngine;

[AddComponentMenu("触发器结果/关卡事件/发送战斗结束消息", 0)]
public class Task_MsgBattleFinish : TaskCellBase
{
	protected override void OnExecute()
	{
		AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		EndAction();
	}
}
