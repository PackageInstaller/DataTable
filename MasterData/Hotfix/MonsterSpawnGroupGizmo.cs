using System.Collections.Generic;
using TrueSync;

public class MonsterSpawnGroupGizmo : BaseSpawnPointGizmo
{
	public bool enableDelayActiveCondition;

	public FP delaySpawnDuration = 0f;

	public bool enableMaxMonsterCount;

	public int maxMonsterCount;

	public int minMonsterCount;

	public FP delayActiveMonsterDuration = 0f;

	public FP intervalTime = 0f;

	protected bool enableDelayActiveMonster;

	public bool isSyncActive;

	protected FP _timerToActiveLogic = FP.Zero;

	protected bool logicActived;

	private int curSpawnIndex;

	private int delayActiveCount;

	[ReadOnly]
	public int monsterLevel;

	private FP lastTime;

	public override void EnableSpawnLogic()
	{
		if (!isSpawnEnabled)
		{
			if (enableDelayActiveCondition && delaySpawnDuration <= FP.Zero)
			{
				enableDelayActiveCondition = false;
			}
			if (enableMaxMonsterCount && maxMonsterCount <= 0)
			{
				enableMaxMonsterCount = false;
				_logger.LogError("同时激活数量为0");
			}
			if (enableMaxMonsterCount)
			{
				enableDelayActiveMonster = delayActiveMonsterDuration > FP.Zero;
			}
			isSpawnEnabled = true;
		}
	}

	public override void ResetSpawnState()
	{
		base.ResetSpawnState();
		_timerToActiveLogic = FP.Zero;
		logicActived = false;
		curSpawnIndex = 0;
		delayActiveCount = 0;
		lastTime = 0;
		isSpawnEnabled = false;
		isSpawnActived = false;
	}

	protected void ActiveSpawnLogic()
	{
		if (!enableMaxMonsterCount || maxMonsterCount >= childrenGizmos.Count)
		{
			maxMonsterCount = childrenGizmos.Count;
		}
		for (int i = curSpawnIndex; i < maxMonsterCount; i++)
		{
			BaseSpawnPointGizmo baseSpawnPointGizmo = childrenGizmos.get_Item(i);
			if (jumpOverBornPerformance)
			{
				baseSpawnPointGizmo.JumpOverBornPerformance();
			}
			baseSpawnPointGizmo.EnableSpawnLogic();
		}
		jumpOverBornPerformance = false;
		curSpawnIndex = maxMonsterCount - 1;
	}

	public override void UpdateSpawnLogic()
	{
		if (!isSpawnEnabled)
		{
			return;
		}
		base.UpdateSpawnLogic();
		if (isSpawnActived)
		{
			return;
		}
		if (enableDelayActiveCondition)
		{
			_timerToActiveLogic += LockStepManager.deltaTime;
		}
		if (!logicActived && CheckActiveConditions())
		{
			ActiveSpawnLogic();
			logicActived = true;
		}
		if (IsAllActived())
		{
			isSpawnActived = true;
		}
		if (!logicActived)
		{
			return;
		}
		FP deltaTime = LockStepManager.deltaTime;
		lastTime += deltaTime;
		if (maxMonsterCount - delayActiveCount < minMonsterCount)
		{
			for (int i = 0; i < delayActiveCount; i++)
			{
				curSpawnIndex++;
				if (curSpawnIndex > childrenGizmos.Count - 1)
				{
					break;
				}
				if (childrenGizmos.get_Item(curSpawnIndex) is MonsterSpawnPointGizmo monsterSpawnPointGizmo)
				{
					monsterSpawnPointGizmo.EnterActionWhenSpawn();
					monsterSpawnPointGizmo.EnableSpawnLogic();
				}
			}
			delayActiveCount = 0;
		}
		if (!(lastTime > intervalTime))
		{
			return;
		}
		if (maxMonsterCount - delayActiveCount < maxMonsterCount)
		{
			for (int j = 0; j < delayActiveCount; j++)
			{
				curSpawnIndex++;
				if (curSpawnIndex > childrenGizmos.Count - 1)
				{
					break;
				}
				if (childrenGizmos.get_Item(curSpawnIndex) is MonsterSpawnPointGizmo monsterSpawnPointGizmo2)
				{
					monsterSpawnPointGizmo2.EnterActionWhenSpawn();
					if (enableDelayActiveMonster)
					{
						monsterSpawnPointGizmo2.DelayEnableSpawnLogic(delayActiveMonsterDuration);
					}
					else
					{
						monsterSpawnPointGizmo2.EnableSpawnLogic();
					}
				}
			}
			delayActiveCount = 0;
		}
		lastTime = 0;
	}

	public override bool CheckActiveConditions()
	{
		if (enableDelayActiveCondition)
		{
			return _timerToActiveLogic >= delaySpawnDuration;
		}
		return true;
	}

	public override bool IsAllActived()
	{
		if (!isSpawnEnabled)
		{
			return false;
		}
		if (!logicActived)
		{
			return false;
		}
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return true;
		}
		if (curSpawnIndex < childrenGizmos.Count - 1)
		{
			return false;
		}
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			if (!childrenGizmos.get_Item(i).IsAllActived())
			{
				return false;
			}
		}
		return true;
	}

	public List<MonsterSpawnPointGizmo> GetInstableMonsters()
	{
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return null;
		}
		List<MonsterSpawnPointGizmo> list = new List<MonsterSpawnPointGizmo>();
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			if (childrenGizmos.get_Item(i) is MonsterSpawnPointGizmo { isInstable: not false, isSelected: false } monsterSpawnPointGizmo)
			{
				list.Add(monsterSpawnPointGizmo);
			}
		}
		return list;
	}

	public void ChildMonsterDied()
	{
		delayActiveCount++;
		AdventureSpawnPointMsg adventureSpawnPointMsg = AdventureSpawnPointMsg.Generate();
		adventureSpawnPointMsg.spawnGroupName = name;
		adventureSpawnPointMsg.groupDiedNum = DiedMonsterCount();
		adventureSpawnPointMsg.groupRemindNum = RemindMonsterCount();
		if (null != parentGizmo)
		{
			BaseSpawnPointGizmo baseSpawnPointGizmo = parentGizmo.parentGizmo;
			if (null != baseSpawnPointGizmo && baseSpawnPointGizmo is MonsterSpawnWaveGizmo)
			{
				adventureSpawnPointMsg.spawnWaveName = baseSpawnPointGizmo.name;
				adventureSpawnPointMsg.waveDiedNum = baseSpawnPointGizmo.DiedMonsterCount();
				adventureSpawnPointMsg.waveRemindNum = baseSpawnPointGizmo.RemindMonsterCount();
			}
		}
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureSpawnPointMsg);
	}

	public override void JumpOverBornPerformance(bool jumpOver = false)
	{
		jumpOverBornPerformance = jumpOver;
	}

	public override List<long> GetSpawnedEntities()
	{
		if (childrenGizmos == null)
		{
			return null;
		}
		List<long> list = new List<long>();
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			if (childrenGizmos.get_Item(i) is MonsterSpawnPointGizmo { spawnMonsterUniqueID: var spawnMonsterUniqueID } && spawnMonsterUniqueID != 0L)
			{
				list.Add(spawnMonsterUniqueID);
			}
		}
		return list;
	}

	public override int DiedMonsterCount()
	{
		if (!isSpawnEnabled)
		{
			return 0;
		}
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			BaseSpawnPointGizmo baseSpawnPointGizmo = childrenGizmos.get_Item(i);
			if (!(null == baseSpawnPointGizmo))
			{
				num += baseSpawnPointGizmo.DiedMonsterCount();
			}
		}
		return num;
	}

	public override int RemindMonsterCount()
	{
		if (!isSpawnEnabled)
		{
			return 0;
		}
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			BaseSpawnPointGizmo baseSpawnPointGizmo = childrenGizmos.get_Item(i);
			if (!(null == baseSpawnPointGizmo))
			{
				num += baseSpawnPointGizmo.RemindMonsterCount();
			}
		}
		return num;
	}
}
