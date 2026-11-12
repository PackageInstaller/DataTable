using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using UnityEngine;

public class InfinityTowerMonsterSpawnWaveGizmo : BaseSpawnPointGizmo
{
	public enum monitorOtherWaveCondition
	{
		[InspectorName("数量小于")]
		Count_Less = 1,
		[InspectorName("时间大于")]
		Time_Greater
	}

	[Space]
	public int waveIndex;

	[Space]
	public int monitorIndex;

	[Space]
	public monitorOtherWaveCondition owCondition = monitorOtherWaveCondition.Count_Less;

	public int LessCount;

	public float GreaterTime;

	protected Action WaveClearAll;

	protected Action actionRefreshMonsterCount;

	protected Action<int> CallNextWave;

	protected readonly Dictionary<int, InfinityTowerEnemySet> dicSet = new Dictionary<int, InfinityTowerEnemySet>();

	protected readonly Dictionary<long, int> dicMonsterGroupIndex = new Dictionary<long, int>();

	protected readonly Dictionary<int, InfinityTowerMonsterSpawnGroupGizmo> dicSpawnGroupGizmo = new Dictionary<int, InfinityTowerMonsterSpawnGroupGizmo>();

	protected int currentGroupMonsterCount;

	protected Coroutine corWaitTimeEA;

	public void InitMonitorOtherWave(Action<int> callNextWave)
	{
		if (monitorIndex == 0)
		{
			monitorIndex = waveIndex - 1;
		}
		if (waveIndex != 1)
		{
			CallNextWave = callNextWave;
			AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
			if (null != instance)
			{
				instance.AddEventListener("INFINITY_WAVE_ENABLELOGIC", OtherWaveEnable);
				instance.AddEventListener("INFINITY_WAVE_MONSTERMSG", OtherWaveMonsterLaveCount);
			}
		}
	}

	public void InitSpawnMonsterDatas(List<InfinityTowerEnemySet> enemySets, Action waveClearAll, Action refreshMonsterCB)
	{
		for (int i = 0; i < enemySets.Count; i++)
		{
			dicSet.set_Item(enemySets.get_Item(i).GroupNum, enemySets.get_Item(i));
		}
		WaveClearAll = waveClearAll;
		actionRefreshMonsterCount = refreshMonsterCB;
	}

	public override void EnableSpawnLogic()
	{
		if (!ActiveSelf || isSpawnEnabled)
		{
			return;
		}
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null == instance)
		{
			return;
		}
		AdventureLevelInfinityWaveEnableLogicEvent adventureLevelInfinityWaveEnableLogicEvent = AdventureLevelInfinityWaveEnableLogicEvent.Generate();
		adventureLevelInfinityWaveEnableLogicEvent.waveIndex = waveIndex;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelInfinityWaveEnableLogicEvent);
		instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		if (waveIndex != 1)
		{
			instance.RemoveEventListener("INFINITY_WAVE_ENABLELOGIC", OtherWaveEnable);
			instance.RemoveEventListener("INFINITY_WAVE_MONSTERMSG", OtherWaveMonsterLaveCount);
		}
		isSpawnEnabled = true;
		List<InfinityTowerMonsterSpawnGroupGizmo> list = gameObject.GetComponentsInChildren<InfinityTowerMonsterSpawnGroupGizmo>().ToList();
		for (int i = 0; i < list.Count; i++)
		{
			if (!dicSpawnGroupGizmo.ContainsKey(list.get_Item(i).groupIndex))
			{
				dicSpawnGroupGizmo.set_Item(list.get_Item(i).groupIndex, list.get_Item(i));
			}
			else
			{
				_logger.LogError($"无尽塔出生Group {gameObject.name}  {waveIndex} 出生点Group ID = {list.get_Item(i).groupIndex} 重复");
			}
		}
		foreach (KeyValuePair<int, InfinityTowerEnemySet> item in dicSet)
		{
			if (dicSpawnGroupGizmo.ContainsKey(item.Key))
			{
				currentGroupMonsterCount += item.Value.MaxNumPerWave;
				dicSpawnGroupGizmo.get_Item(item.Key).InitSpawnMonsterDatas(item.Value, MonsterSpwanInfo);
				dicSpawnGroupGizmo.get_Item(item.Key).EnableSpawnLogic();
			}
			else
			{
				_logger.LogError($"无尽塔出生Group {gameObject.name}  {waveIndex} 出生点Group ID = {item.Key} 不存在");
			}
		}
	}

	protected void MonsterSpwanInfo(long uid, int groupIndex)
	{
		if (isSpawnEnabled)
		{
			dicMonsterGroupIndex.set_Item(uid, groupIndex);
		}
	}

	protected void MonsterDeclareDeath(IEvent ievent)
	{
		if (!isSpawnEnabled || ievent == null)
		{
			return;
		}
		AdventureMonsterDeclareDiedEvent adventureMonsterDeclareDiedEvent = (AdventureMonsterDeclareDiedEvent)ievent;
		_ = adventureMonsterDeclareDiedEvent.monsterID;
		long key = adventureMonsterDeclareDiedEvent.id;
		if (dicMonsterGroupIndex.TryGetValue(key, out var value))
		{
			actionRefreshMonsterCount?.Invoke();
			currentGroupMonsterCount--;
			AdventureLevelInfinityWaveMonsterMsgEvent adventureLevelInfinityWaveMonsterMsgEvent = AdventureLevelInfinityWaveMonsterMsgEvent.Generate();
			adventureLevelInfinityWaveMonsterMsgEvent.waveIndex = waveIndex;
			adventureLevelInfinityWaveMonsterMsgEvent.laveCount = currentGroupMonsterCount;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelInfinityWaveMonsterMsgEvent);
			if (currentGroupMonsterCount == 0)
			{
				WaveClearAll?.Invoke();
				isSpawnEnabled = false;
			}
			else
			{
				dicSpawnGroupGizmo.get_Item(value).ReplenishSpawnMonster();
			}
		}
	}

	protected void OtherWaveEnable(IEvent ievent)
	{
		if (((AdventureLevelInfinityWaveEnableLogicEvent)ievent).waveIndex == monitorIndex && owCondition == monitorOtherWaveCondition.Time_Greater)
		{
			corWaitTimeEA = StartCoroutine(CorWaitTimeEA(GreaterTime));
		}
	}

	private IEnumerator CorWaitTimeEA(float delayTime)
	{
		yield return new WaitForSeconds(delayTime);
		CallNextWave?.Invoke(waveIndex);
		corWaitTimeEA = null;
	}

	protected void OtherWaveMonsterLaveCount(IEvent ievent)
	{
		AdventureLevelInfinityWaveMonsterMsgEvent adventureLevelInfinityWaveMonsterMsgEvent = (AdventureLevelInfinityWaveMonsterMsgEvent)ievent;
		if (adventureLevelInfinityWaveMonsterMsgEvent.waveIndex != monitorIndex)
		{
			return;
		}
		int laveCount = adventureLevelInfinityWaveMonsterMsgEvent.laveCount;
		if (owCondition == monitorOtherWaveCondition.Count_Less)
		{
			if (laveCount == LessCount)
			{
				CallNextWave?.Invoke(waveIndex);
			}
		}
		else if (laveCount == 0 && corWaitTimeEA != null)
		{
			CallNextWave?.Invoke(waveIndex);
			StopCoroutine(corWaitTimeEA);
			corWaitTimeEA = null;
		}
	}

	protected override void OnDeactive()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (!(null == instance))
		{
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
			dicMonsterGroupIndex.Clear();
			dicSet.Clear();
			dicSpawnGroupGizmo.Clear();
			WaveClearAll = null;
			CallNextWave = null;
		}
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
	}
}
