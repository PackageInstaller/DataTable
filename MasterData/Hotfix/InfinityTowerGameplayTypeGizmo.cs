using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using UnityEngine;

public class InfinityTowerGameplayTypeGizmo : BaseSpawnPointGizmo
{
	[Space]
	public HotfixEnum.infinityTowerGameplayType waveModel;

	protected readonly Dictionary<int, InfinityTowerMonsterSpawnWaveGizmo> dicSpawnWave = new Dictionary<int, InfinityTowerMonsterSpawnWaveGizmo>();

	protected readonly Dictionary<int, List<InfinityTowerEnemySet>> dicEnemySets = new Dictionary<int, List<InfinityTowerEnemySet>>();

	protected Dictionary<int, bool> dicWaveEnable = new Dictionary<int, bool>();

	protected int totalWaveCount;

	protected int runWaveCount;

	protected int clearWaveCount;

	protected Action actionSuccess;

	protected Action actionRefreshMonsterCount;

	public void InitTypeMonsterDatas(List<InfinityTowerEnemySet> enemySets, Action successCB, Action refreshMonsterCB)
	{
		for (int i = 0; i < enemySets.Count; i++)
		{
			InfinityTowerEnemySet infinityTowerEnemySet = enemySets.get_Item(i);
			if (dicEnemySets.TryGetValue(infinityTowerEnemySet.WaveNum, out var value))
			{
				value.Add(infinityTowerEnemySet);
				continue;
			}
			List<InfinityTowerEnemySet> value2 = new List<InfinityTowerEnemySet> { infinityTowerEnemySet };
			dicEnemySets.Add(infinityTowerEnemySet.WaveNum, value2);
		}
		actionSuccess = successCB;
		actionRefreshMonsterCount = refreshMonsterCB;
		totalWaveCount = dicEnemySets.Count;
		clearWaveCount = 0;
		runWaveCount = 0;
	}

	public override void EnableSpawnLogic()
	{
		if (!ActiveSelf || isSpawnEnabled)
		{
			return;
		}
		isSpawnEnabled = true;
		List<InfinityTowerMonsterSpawnWaveGizmo> list = gameObject.GetComponentsInChildren<InfinityTowerMonsterSpawnWaveGizmo>().ToList();
		for (int i = 0; i < list.Count; i++)
		{
			if (!dicSpawnWave.ContainsKey(list.get_Item(i).waveIndex))
			{
				dicSpawnWave.set_Item(list.get_Item(i).waveIndex, list.get_Item(i));
				if (list.get_Item(i).waveIndex <= totalWaveCount)
				{
					list.get_Item(i).InitMonitorOtherWave(CallNextWave);
				}
			}
			else
			{
				_logger.LogError($"无尽塔出生类型 {gameObject.name}  {waveModel} 出生点波次Index = {list.get_Item(i).waveIndex} 重复");
			}
		}
		runWaveCount = 1;
		if (runWaveCount <= totalWaveCount)
		{
			dicWaveEnable.set_Item(1, true);
			dicSpawnWave.get_Item(runWaveCount).InitSpawnMonsterDatas(dicEnemySets.get_Item(runWaveCount), CurrentWaveClearAll, actionRefreshMonsterCount);
			dicSpawnWave.get_Item(runWaveCount).EnableSpawnLogic();
		}
	}

	public void CurrentWaveClearAll()
	{
		clearWaveCount++;
		if (clearWaveCount == totalWaveCount)
		{
			isSpawnEnabled = false;
			if (actionSuccess != null)
			{
				actionSuccess();
				actionSuccess = null;
			}
		}
	}

	public void CallNextWave(int waveCount)
	{
		if (!dicWaveEnable.ContainsKey(waveCount))
		{
			dicWaveEnable.set_Item(waveCount, true);
			runWaveCount++;
			if (runWaveCount <= totalWaveCount)
			{
				RunNextWave(waveCount);
			}
		}
	}

	protected void RunNextWave(int waveCount)
	{
		if (dicSpawnWave.ContainsKey(waveCount))
		{
			dicSpawnWave.get_Item(waveCount).InitSpawnMonsterDatas(dicEnemySets.get_Item(waveCount), CurrentWaveClearAll, actionRefreshMonsterCount);
			dicSpawnWave.get_Item(waveCount).EnableSpawnLogic();
			return;
		}
		_logger.LogError($"无尽塔出生类型 {gameObject.name}  {waveModel} 出生点波次Index = {waveCount} 不存在，使用已有波次作为出生点");
		int key = waveCount % dicSpawnWave.Count;
		if (dicSpawnWave.ContainsKey(key))
		{
			dicSpawnWave.get_Item(key).InitSpawnMonsterDatas(dicEnemySets.get_Item(waveCount), CurrentWaveClearAll, actionRefreshMonsterCount);
			dicSpawnWave.get_Item(key).EnableSpawnLogic();
		}
		else
		{
			dicSpawnWave.get_Item(1).InitSpawnMonsterDatas(dicEnemySets.get_Item(waveCount), CurrentWaveClearAll, actionRefreshMonsterCount);
			dicSpawnWave.get_Item(key).EnableSpawnLogic();
		}
	}

	protected override void OnDeactive()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (!(null == instance))
		{
			dicSpawnWave.Clear();
			dicEnemySets.Clear();
			dicWaveEnable.Clear();
		}
	}
}
