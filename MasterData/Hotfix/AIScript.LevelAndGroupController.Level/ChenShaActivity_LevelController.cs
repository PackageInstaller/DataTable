using System.Collections.Generic;
using AIScript.LevelAndGroupController.Group;
using UnityEngine;

namespace AIScript.LevelAndGroupController.Level;

public class ChenShaActivity_LevelController : LevelControllerBase
{
	private int monster_fazheng = 3170008;

	private string wave_1 = "Wave_99";

	private string wave_2_1 = "Wave_99_2.1";

	private string wave_2_2 = "Wave_99_2.2";

	private string wave_3_1 = "Wave_99_3.1";

	private string wave_3_2 = "Wave_99_3.2";

	private string wave_3_3 = "Wave_99_3.3";

	private string interactiveID_1 = "Wave_99";

	private string interactiveID_2 = "Wave_99_2.1";

	private string interactiveID_3 = "Wave_99_2.2";

	private int _fazhengDeadCount;

	private string interactiveID_Dead = "FaZhengDie";

	private bool isActiveWave2_1;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		isActiveWave2_1 = false;
		_fazhengDeadCount = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ROOM_WAVE_MONSTER_ACTIVED", OnWaveActived);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", OnWaveCleared);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		InitActivity();
	}

	protected override void OnControllerStop()
	{
		base.OnControllerStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_ROOM_WAVE_MONSTER_ACTIVED", OnWaveActived);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", OnWaveCleared);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	private void InitActivity()
	{
		ChenShaGroupController_Activity groupController = new ChenShaGroupController_Activity();
		AddGroupController(groupController);
	}

	protected override void OnReceiveInterActiveMessage(string message)
	{
		if (message.Equals(interactiveID_1))
		{
			isActiveWave2_1 = _fazhengDeadCount != 0;
			ActivateWave((_fazhengDeadCount != 0) ? wave_2_1 : wave_2_2);
		}
		else if (message.Equals(interactiveID_2))
		{
			if (isActiveWave2_1)
			{
				ActivateWave((_fazhengDeadCount != 0) ? wave_3_1 : wave_3_2);
			}
		}
		else if (message.Equals(interactiveID_3))
		{
			if (!isActiveWave2_1)
			{
				ActivateWave((_fazhengDeadCount != 0) ? wave_3_1 : wave_3_3);
			}
		}
		else if (message.Equals(interactiveID_Dead))
		{
			_fazhengDeadCount++;
		}
	}

	private void OnWaveActived(IEvent iEvt)
	{
		if (iEvt is AdventureLevelRoomWaveMonsterActivedEvent adventureLevelRoomWaveMonsterActivedEvent && IsTrackedWave(adventureLevelRoomWaveMonsterActivedEvent.wave))
		{
			_fazhengDeadCount = 0;
		}
	}

	private void OnWaveCleared(IEvent iEvt)
	{
		_ = iEvt is AdventureLevelRoomWaveMonsterClearedEvent;
	}

	private bool IsTrackedWave(string waveName)
	{
		if (!(waveName == wave_1) && !(waveName == wave_2_1) && !(waveName == wave_2_2) && !(waveName == wave_3_1) && !(waveName == wave_3_2))
		{
			return waveName == wave_3_3;
		}
		return true;
	}

	private void ActivateWave(string waveName)
	{
		List<BaseSpawnPointGizmo> waves = ModuleController<AdventureModuleController>.Instance.GetWaves(waveName);
		if (waves == null || waves.Count == 0)
		{
			return;
		}
		for (int i = 0; i < waves.Count; i++)
		{
			if (waves.get_Item(i) is MonsterSpawnWaveGizmo { isTriggerActived: not false } monsterSpawnWaveGizmo && !monsterSpawnWaveGizmo.IsAllActived())
			{
				Debug.Log("==>ActivateWave->EnableSpawnLogic:" + monsterSpawnWaveGizmo.name);
				if (monsterSpawnWaveGizmo is RandomMonsterSpawnWaveGizmo)
				{
					monsterSpawnWaveGizmo.ExecuteSpawnLogic();
				}
				else
				{
					monsterSpawnWaveGizmo.EnableSpawnLogic();
				}
			}
		}
	}

	private void OnActorDied(IEvent iEvt)
	{
	}
}
