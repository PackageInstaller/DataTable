using UnityEngine;

[AddComponentMenu("触发器结果/物件事件/激活默认关闭的交互物件", 0)]
public class Task_ActiveInterObj : TaskCellBase
{
	public string id;

	public string groupTag;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(id) && string.IsNullOrEmpty(groupTag))
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else if (!string.IsNullOrEmpty(groupTag) || !string.IsNullOrEmpty(id))
		{
			Singleton<InteractiveManager>.Instance.ForceActiveInterObj(groupTag, id);
			EndAction();
		}
	}
}
