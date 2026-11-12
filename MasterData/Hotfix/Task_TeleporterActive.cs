using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("触发器结果/其他元素事件/激活传送点", 0)]
public class Task_TeleporterActive : TaskCellBase
{
	public string targetName;

	protected override void OnExecute()
	{
		List<AdventureLevelTeleporter> teleporters = ModuleController<AdventureModuleController>.Instance.GetTeleporters(targetName, -1, -1);
		for (int i = 0; i < teleporters.Count; i++)
		{
			teleporters.get_Item(i).OrderOpen();
		}
		EndAction();
	}
}
