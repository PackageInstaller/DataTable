using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class InfinityTowerMonsterSpawnGroupGizmo : BaseSpawnPointGizmo
{
	public bool enableDelayActiveCondition;

	public FP delaySpawnDuration = 0f;

	public int groupIndex;

	[Space]
	public bool useSpecialForm;

	[Space]
	public int killCount;

	[Space]
	public int addCount;

	protected readonly Dictionary<int, InfinityTowerMonsterSpawnPointGizmo> dicPointGizmos = new Dictionary<int, InfinityTowerMonsterSpawnPointGizmo>();

	protected InfinityTowerEnemySet enemySet;

	protected Action<long, int> monsterSpwnInfo;

	protected int totalGroupMonsterCount;

	protected int spawnMonsterCount;

	protected int useSpawnPointCount;

	protected Coroutine corSpawnLogic;

	protected int tmpKillCount;

	protected bool isSpecialAdd;

	public void InitSpawnMonsterDatas(InfinityTowerEnemySet set, Action<long, int> monsterSpwn)
	{
		enemySet = set;
		monsterSpwnInfo = monsterSpwn;
		totalGroupMonsterCount = enemySet.MaxNumPerWave;
	}

	public override void EnableSpawnLogic()
	{
		if (isSpawnEnabled)
		{
			return;
		}
		isSpawnEnabled = true;
		isSpecialAdd = false;
		spawnMonsterCount = 0;
		tmpKillCount = 0;
		if (enableDelayActiveCondition && delaySpawnDuration <= FP.Zero)
		{
			enableDelayActiveCondition = false;
		}
		int monsterPosition = Singleton<HotfixDataController>.Instance.GetMonster(enemySet.MonsterId).MonsterPosition;
		List<InfinityTowerMonsterSpawnPointGizmo> list = new List<InfinityTowerMonsterSpawnPointGizmo>();
		list = ((monsterPosition != 1) ? transform.Find("Remote").GetComponentsInChildren<InfinityTowerMonsterSpawnPointGizmo>().ToList() : transform.Find("Melee").GetComponentsInChildren<InfinityTowerMonsterSpawnPointGizmo>().ToList());
		if (list.Count > 0)
		{
			for (int i = 0; i < list.Count; i++)
			{
				InfinityTowerMonsterSpawnPointGizmo infinityTowerMonsterSpawnPointGizmo = list.get_Item(i);
				if (!dicPointGizmos.TryAdd(infinityTowerMonsterSpawnPointGizmo.pointIndex, infinityTowerMonsterSpawnPointGizmo))
				{
					_logger.LogError($"无尽塔出生Group {gameObject.name}  {groupIndex} {infinityTowerMonsterSpawnPointGizmo.gameObject.transform.parent.name} 出生点Point ID = {infinityTowerMonsterSpawnPointGizmo.pointIndex} 重复");
				}
			}
		}
		if (enableDelayActiveCondition)
		{
			corSpawnLogic = StartCoroutine(CorSpawnLogic((float)delaySpawnDuration));
		}
		else
		{
			SummonMonster(enemySet.MaxNum);
		}
	}

	private IEnumerator CorSpawnLogic(float delayTime)
	{
		yield return new WaitForSeconds(delayTime);
		SummonMonster(enemySet.MaxNum);
	}

	protected void SummonMonster(int count)
	{
		if (isSpawnEnabled)
		{
			for (int i = 0; i < count; i++)
			{
				FindMonsterSpawnPoint();
			}
		}
	}

	protected void FindMonsterSpawnPoint()
	{
		useSpawnPointCount++;
		if (dicPointGizmos.ContainsKey(useSpawnPointCount))
		{
			spawnMonsterCount++;
			dicPointGizmos.get_Item(useSpawnPointCount).SetSpawnCallback(SpawnCallback);
			dicPointGizmos.get_Item(useSpawnPointCount).monsterID = enemySet.MonsterId;
			dicPointGizmos.get_Item(useSpawnPointCount).levelChange = enemySet.LevelChange;
			dicPointGizmos.get_Item(useSpawnPointCount).ExecuteSpawnLogic();
		}
		else
		{
			StartCoroutine(WaitFindMonsterSpawnPoint(useSpawnPointCount));
		}
	}

	private IEnumerator WaitFindMonsterSpawnPoint(int useSpawnPointCount)
	{
		int tmpIndex = useSpawnPointCount % dicPointGizmos.Count;
		if (!dicPointGizmos.ContainsKey(tmpIndex))
		{
			tmpIndex = 1;
		}
		yield return new WaitForSecondsRealtime(0.1f);
		spawnMonsterCount++;
		dicPointGizmos.get_Item(tmpIndex).SetSpawnCallback(SpawnCallback);
		dicPointGizmos.get_Item(tmpIndex).monsterID = enemySet.MonsterId;
		dicPointGizmos.get_Item(tmpIndex).levelChange = enemySet.LevelChange;
		dicPointGizmos.get_Item(tmpIndex).ExecuteSpawnLogic();
		_logger.LogError($"无尽塔出生Group {gameObject.name}  {groupIndex} {dicPointGizmos.get_Item(1).gameObject.transform.parent.name} 出生点数量不足");
	}

	public void ReplenishSpawnMonster()
	{
		if (!isSpawnEnabled)
		{
			return;
		}
		if (!useSpecialForm)
		{
			if (spawnMonsterCount < totalGroupMonsterCount)
			{
				SummonMonster(1);
			}
			return;
		}
		tmpKillCount++;
		if (spawnMonsterCount >= totalGroupMonsterCount)
		{
			return;
		}
		if (tmpKillCount == killCount)
		{
			if (spawnMonsterCount < totalGroupMonsterCount)
			{
				if (totalGroupMonsterCount - spawnMonsterCount >= addCount)
				{
					SummonMonster(addCount);
				}
				else
				{
					SummonMonster(totalGroupMonsterCount - spawnMonsterCount);
				}
			}
			tmpKillCount = 0;
			isSpecialAdd = true;
		}
		else if (enemySet.MaxNum < killCount)
		{
			SummonMonster(1);
		}
		else if (isSpecialAdd && (addCount < killCount || totalGroupMonsterCount - spawnMonsterCount < killCount))
		{
			SummonMonster(1);
		}
	}

	public void SpawnCallback(long uid)
	{
		monsterSpwnInfo?.Invoke(uid, groupIndex);
		if (spawnMonsterCount == totalGroupMonsterCount)
		{
			isSpawnEnabled = false;
		}
	}

	protected override void OnActive()
	{
		base.OnActive();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		if (corSpawnLogic != null)
		{
			StopCoroutine(corSpawnLogic);
		}
		corSpawnLogic = null;
		monsterSpwnInfo = null;
		dicPointGizmos.Clear();
	}
}
