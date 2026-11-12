using UnityEngine;

[AddComponentMenu("触发器结果/触发器内部事件/发送交互行为ID", 0)]
public class Task_TriggerOpID : TaskCellBase
{
	public string _triggerOpIDN;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(_triggerOpIDN))
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			Singleton<InteractiveManager>.Instance.triggerOpListener(_triggerOpIDN);
			EndAction();
		}
	}
}
