using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/开关自定义摄像机", 0)]
public class Task_OCCustomCamera : TaskCellBase
{
	public enum activeType
	{
		[InspectorName("激活")]
		active,
		[InspectorName("关闭")]
		deactive
	}

	public string triggerName;

	public activeType _activeType;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(triggerName))
		{
			LogWarning("未配置");
			EndAction(success: false);
			return;
		}
		if (_activeType == activeType.active)
		{
			ModuleController<AdventureModuleController>.Instance.ActivePlayerCameraTrigger(triggerName);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.DeactivePlayerCameraTrigger(triggerName);
		}
		EndAction();
	}
}
