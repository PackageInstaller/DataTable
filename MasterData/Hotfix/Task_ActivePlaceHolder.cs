using UnityEngine;

[AddComponentMenu("触发器结果/物件事件/激活路点", 0)]
public class Task_ActivePlaceHolder : TaskCellBase
{
	public string holderName;

	public bool isActive;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(holderName))
		{
			LogWarning("路点未配置");
			EndAction(success: false);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance?.ActivePlaceHolder(holderName, isActive);
			EndAction();
		}
	}
}
