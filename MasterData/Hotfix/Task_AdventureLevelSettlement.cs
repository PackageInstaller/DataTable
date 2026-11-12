using UnityEngine;

[AddComponentMenu("触发器结果/关卡事件/关卡结算", 0)]
public class Task_AdventureLevelSettlement : TaskCellBase
{
	public bool isVictory;

	public float fadeTime = 1f;

	public string videoName;

	protected override void OnExecute()
	{
		AdventureLevelTeleporter.NextLevelData nextLevelData = new AdventureLevelTeleporter.NextLevelData
		{
			enterSettlementState = true,
			levelSuccess = isVictory,
			fadeTime = fadeTime,
			videoName = videoName
		};
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		instance.banPlayerSpawn = false;
		instance.banMonsterSpawn = false;
		instance.banBattleUIShow = false;
		instance.DispatchEventWithData("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", this, nextLevelData);
		EndAction();
	}
}
