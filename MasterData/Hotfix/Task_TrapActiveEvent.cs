using UnityEngine;

[AddComponentMenu("触发器结果/怪物与陷阱/激活指定陷阱组", 2)]
public class Task_TrapActiveEvent : TaskCellBase
{
	public bool isActive;

	public int GroupId;

	protected override void OnExecute()
	{
		AdventureTrapActive adventureTrapActive = AdventureTrapActive.Generate();
		adventureTrapActive.isActive = isActive;
		adventureTrapActive.GroupId = GroupId;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureTrapActive);
		EndAction();
	}
}
