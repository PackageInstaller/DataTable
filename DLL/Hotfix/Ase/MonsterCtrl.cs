using System.Collections.Generic;
using Ase.ECS;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

public class MonsterCtrl : SerializedMonoBehaviour, IInit, IDispose
{
	public List<MonsterActivePoint> MonsterActivePoints;

	public int ID;

	public bool IsActive;

	[HideInInspector]
	public bool DeadIncreaseCount;

	private IDeadCount MapDataDeadCount;

	public void OnInit(object data = null)
	{
		foreach (MonsterActivePoint monsterActivePoint in MonsterActivePoints)
		{
			monsterActivePoint.OnInit(data);
		}
	}

	public void DeadCountInit(IDeadCount deadCount)
	{
		MapDataDeadCount = deadCount;
	}

	public void OnDispose()
	{
	}

	public void SetActive()
	{
		IsActive = true;
		foreach (MonsterActivePoint monsterActivePoint in MonsterActivePoints)
		{
			monsterActivePoint.LoadMonster();
		}
	}

	public void KillMonster()
	{
		foreach (MonsterActivePoint monsterActivePoint in MonsterActivePoints)
		{
			monsterActivePoint.KillMonster();
		}
	}

	public void OnEntityDead(MonsterActivePoint point)
	{
		if (DeadIncreaseCount)
		{
			MapDataDeadCount.CountIncrease();
		}
	}

	public void OnEntityCreated()
	{
	}

	public int GetMonsterCount()
	{
		int num = 0;
		foreach (MonsterActivePoint monsterActivePoint in MonsterActivePoints)
		{
			if ((Object)(object)monsterActivePoint != null && monsterActivePoint.isSurvival)
			{
				num++;
			}
		}
		return num;
	}

	public void CountIncrease()
	{
	}
}
