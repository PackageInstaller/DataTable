using UnityEngine;

[AddComponentMenu("触发器结果/关卡事件/发送显示BOSS血条消息", 0)]
public class Task_MsgShowBossHpBar : TaskCellBase
{
	protected override void OnExecute()
	{
		AdventureMsgShowBossHpBarEvent aEvent = AdventureMsgShowBossHpBarEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		EndAction();
	}
}
