using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public class MonsterGroupCtrl : MonoBehaviour, IInit, IStart
{
	public LevelArea levelArea;

	public List<MonsterGroup> monsterGroupList = new List<MonsterGroup>();

	public void OnInit(object data = null)
	{
		monsterGroupList.Clear();
		MonsterGroup[] componentsInChildren = base.gameObject.GetComponentsInChildren<MonsterGroup>();
		foreach (MonsterGroup monsterGroup in componentsInChildren)
		{
			monsterGroupList.Add(monsterGroup);
			monsterGroup.OnInit(data);
		}
	}

	public void OnStart(object data = null)
	{
		foreach (MonsterGroup monsterGroup in monsterGroupList)
		{
			monsterGroup.OnStart();
		}
	}

	public void ReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		for (int i = 0; i < monsterGroupList.Count; i++)
		{
			monsterGroupList[i].ReceiveMapDataEvent(eventType, otherEntity);
		}
	}

	public void OnDispose()
	{
		foreach (MonsterGroup monsterGroup in monsterGroupList)
		{
			monsterGroup.OnDispose();
		}
		monsterGroupList.Clear();
	}

	public void GetMonsterGroupEntity(List<int> entityIds)
	{
		foreach (MonsterGroup monsterGroup in monsterGroupList)
		{
			monsterGroup.GetAllLoadedEntity(entityIds);
		}
	}
}
