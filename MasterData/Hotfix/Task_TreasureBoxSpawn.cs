using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("触发器结果/其他元素事件/激活宝箱出生点", 1)]
public class Task_TreasureBoxSpawn : TaskCellBase
{
	public string targetName;

	protected override void OnExecute()
	{
		List<BaseSpawnPointGizmo> treasureBoxs = ModuleController<AdventureModuleController>.Instance.GetTreasureBoxs(targetName, x, y);
		if (treasureBoxs.Count == 0)
		{
			EndAction(success: false);
			return;
		}
		for (int i = 0; i < treasureBoxs.Count; i++)
		{
			TreasureBoxSpawnPoint treasureBoxSpawnPoint = treasureBoxs.get_Item(i) as TreasureBoxSpawnPoint;
			if (treasureBoxSpawnPoint.isActiveAndEnabled && !treasureBoxSpawnPoint.IsAllActived() && treasureBoxSpawnPoint.isTriggerActived)
			{
				treasureBoxSpawnPoint.EnableSpawnLogic();
			}
		}
		EndAction();
	}
}
