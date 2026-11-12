using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/表演用关卡特殊事件", 0)]
public class Task_LevelSpecialEvent : TaskCellBase
{
	public bool banPlayerSpawn = true;

	public bool banMonsterSpawn = true;

	public bool banBattleUIShow = true;

	protected override void OnExecute()
	{
		ModuleController<AdventureModuleController>.Instance.banPlayerSpawn = banPlayerSpawn;
		ModuleController<AdventureModuleController>.Instance.banMonsterSpawn = banMonsterSpawn;
		ModuleController<AdventureModuleController>.Instance.banBattleUIShow = banBattleUIShow;
		if (banBattleUIShow)
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		}
		EndAction();
	}
}
