using UnityEngine;

[AddComponentMenu("触发器结果/触发器内部事件/改变触发器状态", 2)]
public class Task_TriggerOperate : TaskCellBase
{
	public string _groupTitle;

	public TriggerManager.triggerState _state;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(_groupTitle))
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			Singleton<TriggerManager>.Instance.SetTriggerSateByGroup(_groupTitle, _state);
			EndAction();
		}
	}
}
