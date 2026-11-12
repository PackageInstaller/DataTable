using System;
using System.Collections.Generic;
using UnityEngine;

public class MonsterSpawnWaveGizmo : BaseSpawnPointGizmo
{
	public enum WaveType
	{
		Default,
		Goblin,
		Trap,
		QuitSettlement
	}

	public bool isTriggerActived;

	public WaveType waveType;

	private BaseSpawnPointGizmo enabledGizmo;

	private Action childMonsterDiedCallback;

	public bool elitFlag { get; set; }

	public override void EnableSpawnLogic()
	{
		if (!isSpawnEnabled)
		{
			isSpawnEnabled = true;
			if (childrenGizmos != null && childrenGizmos.Count != 0)
			{
				int num = MonoSingleton<GameController>.Instance.Random_Roguelike(0, childrenGizmos.Count);
				enabledGizmo = childrenGizmos.get_Item(num);
				string msg = $"Wave_EnableSpawnLogic:rdmIndex={num},instable={enabledGizmo.name}";
				MonoSingleton<GameController>.Instance.SaveMsg(msg);
				Debug.Log("激活新Rog波次:" + enabledGizmo.name);
				enabledGizmo.MarkQuitSettlementMonster(waveType == WaveType.QuitSettlement);
				enabledGizmo.EnableSpawnLogic();
				AdventureLevelRoomWaveSpawnLogicEnabledEvent adventureLevelRoomWaveSpawnLogicEnabledEvent = AdventureLevelRoomWaveSpawnLogicEnabledEvent.Generate();
				adventureLevelRoomWaveSpawnLogicEnabledEvent.wave = name;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelRoomWaveSpawnLogicEnabledEvent);
			}
		}
	}

	public override bool IsAllActivedAndDied()
	{
		if (waveType != WaveType.Default)
		{
			return true;
		}
		return base.IsAllActivedAndDied();
	}

	public override bool IsAllActivedAndDied_NoSummons()
	{
		if (waveType != WaveType.Default)
		{
			return true;
		}
		return base.IsAllActivedAndDied_NoSummons();
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
			List<long> spawnedEntities = childrenGizmos.get_Item(i).GetSpawnedEntities();
			if (spawnedEntities != null && spawnedEntities.Count > 0)
			{
				list.AddRange(spawnedEntities);
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
		if (null == enabledGizmo)
		{
			return 0;
		}
		return enabledGizmo.DiedMonsterCount();
	}

	public override int RemindMonsterCount()
	{
		if (!isSpawnEnabled)
		{
			return 0;
		}
		if (null == enabledGizmo)
		{
			return 0;
		}
		return enabledGizmo.RemindMonsterCount();
	}
}
