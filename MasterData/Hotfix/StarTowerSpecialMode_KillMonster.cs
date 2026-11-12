using System;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class StarTowerSpecialMode_KillMonster : StarTowerSpecialMode
{
	private StarTowerFloor fixedRoguelikeFloor;

	private int totalTime;

	private FP timeing = 0;

	private bool isPause;

	private int delayTime;

	private FP delayTimeing;

	private bool isDelayEnd;

	private List<long> spawnedMonster;

	public override void EntryRoom(Action<HotfixEnum.levelState> callback)
	{
		base.EntryRoom(callback);
		if (roomData == null)
		{
			Debug.LogError("房间数据为空!");
			return;
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
	}

	public override void Complete(HotfixEnum.levelState state)
	{
		base.Complete(state);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		spawnedMonster?.Clear();
		spawnedMonster = null;
	}

	public override void ActiveEvent()
	{
		if (isComplete)
		{
			return;
		}
		base.ActiveEvent();
		string value = eventData.Params;
		int num = 0;
		if (!string.IsNullOrEmpty(value))
		{
			num = CommonHelper.ParseStringParamToInt(value);
		}
		if (num == 0)
		{
			isComplete = true;
			Debug.LogError($"事件{eventData.Id}的setid为0!");
			return;
		}
		List<StarTowerEnemySet> starTowerEnemySetData = Singleton<HotfixDataController>.Instance.StarTowerEnemySetData;
		StarTowerEnemySet starTowerEnemySet = null;
		for (int i = 0; i < starTowerEnemySetData.Count; i++)
		{
			StarTowerEnemySet starTowerEnemySet2 = starTowerEnemySetData.get_Item(i);
			if (starTowerEnemySet2.SetId == num)
			{
				starTowerEnemySet = starTowerEnemySet2;
				break;
			}
		}
		if (starTowerEnemySet == null)
		{
			Debug.LogError($"找不到合适的怪物Set数据,SetId = {num}");
			isComplete = true;
			return;
		}
		StarTowerLevelController starTowerLevelController = ModuleController<AdventureModuleController>.Instance.levelInstance as StarTowerLevelController;
		if (null == starTowerLevelController)
		{
			Debug.LogError("肉鸽控制器为空!");
			return;
		}
		StarTowerLevelController.MonsterSpawnData spawnData = starTowerLevelController.ParseMonsterGroupSet(starTowerEnemySet);
		starTowerLevelController.ExecuteExtrlSpawnLogic(spawnData, 1);
	}

	private void MonsterDied(IEvent evt)
	{
		AdventureMonsterDiedEvent adventureMonsterDiedEvent = (AdventureMonsterDiedEvent)evt;
		if (adventureMonsterDiedEvent.callSpawnSrc != 1 || spawnedMonster == null)
		{
			return;
		}
		if (spawnedMonster.Contains(adventureMonsterDiedEvent.id))
		{
			spawnedMonster.Remove(adventureMonsterDiedEvent.id);
		}
		if (spawnedMonster.Count != 0)
		{
			return;
		}
		if (activeTime == HotfixEnum.combatActivePointType.EveryWaveRefresh || activeTime == HotfixEnum.combatActivePointType.EveryWaveClear)
		{
			if (finalWaveActived || finalWaveCleared)
			{
				isComplete = true;
			}
		}
		else
		{
			isComplete = true;
		}
	}

	private void MonsterSpawn(IEvent evt)
	{
		AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = (AdventureMonsterSpawnedEvent)evt;
		if (adventureMonsterSpawnedEvent.callSpawnSrc == 1)
		{
			if (spawnedMonster == null)
			{
				spawnedMonster = new List<long>();
			}
			spawnedMonster.Add(adventureMonsterSpawnedEvent.id);
		}
	}

	public override void Pause()
	{
		isPause = true;
	}

	public override void Resume()
	{
		isPause = false;
	}

	public override void LeaveRoom()
	{
		fixedRoguelikeFloor = null;
		timeing = 0;
	}
}
