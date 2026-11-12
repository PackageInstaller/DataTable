using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/中央血条刷新", 0)]
public class Task_RefreshCenterHpBar : TaskCellBase
{
	protected override void OnExecute()
	{
		ModuleController<AdventureModuleController>.Instance?.RefreshCenterHpBar();
		EndAction();
	}
}
