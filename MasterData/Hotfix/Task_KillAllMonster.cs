using UnityEngine;

[AddComponentMenu("触发器结果/怪物与陷阱/杀死场上已有怪物", 3)]
public class Task_KillAllMonster : TaskCellBase
{
	protected override void OnExecute()
	{
		ModuleController<AdventureModuleController>.Instance.KillAllMonsters(clearOrDestroy: false, ignoreAll: false, ignoreSpawnState: false);
		EndAction();
	}
}
