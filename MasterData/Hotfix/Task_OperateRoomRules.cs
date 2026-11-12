using UnityEngine;

[AddComponentMenu("触发器结果/AI与技能/开关房间规则", 0)]
public class Task_OperateRoomRules : TaskCellBase
{
	public bool isOpenOrClose = true;

	public int id;

	protected override void OnExecute()
	{
		AdventureLevelController levelInstance = ModuleController<AdventureModuleController>.Instance.levelInstance;
		if (levelInstance != null)
		{
			if (isOpenOrClose)
			{
				levelInstance.AddRoomRule(id, GetOwnerFakeActor());
			}
			else
			{
				levelInstance.RemoveRoomRule(id);
			}
		}
		EndAction();
	}
}
