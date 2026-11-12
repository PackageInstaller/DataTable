using UnityEngine;

[AddComponentMenu("触发器结果/物件事件/切换机关档位", 2)]
public class Task_SwicthInterObjNextState : TaskCellBase
{
	public string id;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(id))
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			Singleton<InteractiveManager>.Instance.triggerInteractiveObjState(id);
			EndAction();
		}
	}
}
