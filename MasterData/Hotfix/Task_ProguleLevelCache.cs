using UnityEngine;

[AddComponentMenu("触发器结果/暂时废弃/序章关卡缓冲器(宝箱ID)", 0)]
public class Task_ProguleLevelCache : TaskCellBase
{
	public int boxID;

	protected override void OnExecute()
	{
		base.OnExecute();
		ModuleController<AdventureModuleController>.Instance.levelInstance.boxID = boxID;
	}
}
