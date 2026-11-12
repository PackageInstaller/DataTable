using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class RegionBossSummonMonsterGroupGizmo : BaseSpawnPointGizmo
{
	protected List<RegionBossSummonMonsterPointGizmo> regionBossSummonMonsterPointGizmos = new List<RegionBossSummonMonsterPointGizmo>();

	protected readonly List<RegionBossSummonMonsterPointGizmo> disConfromPoint = new List<RegionBossSummonMonsterPointGizmo>();

	protected readonly List<RegionBossSummonMonsterPointGizmo> randomPoint = new List<RegionBossSummonMonsterPointGizmo>();

	public override void EnableSpawnLogic()
	{
		regionBossSummonMonsterPointGizmos = gameObject.GetComponentsInChildren<RegionBossSummonMonsterPointGizmo>().ToList();
	}

	protected override void OnDeactive()
	{
	}

	public void SetSummonMonsterMsg()
	{
		for (int i = 0; i < randomPoint.Count; i++)
		{
			randomPoint.get_Item(i).ExecuteSpawnLogic();
		}
	}

	public List<Vector3> GetRandomPoint(long bossEntityId, float innerRadius, float outsideRadius, int summonMonsterID, int summonCount)
	{
		disConfromPoint.Clear();
		randomPoint.Clear();
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(bossEntityId);
		if (logicEntity != null)
		{
			Vector3 position = logicEntity.transform.position;
			for (int i = 0; i < regionBossSummonMonsterPointGizmos.Count; i++)
			{
				float num = Vector3.Distance(position, regionBossSummonMonsterPointGizmos.get_Item(i).transform.position);
				if (innerRadius <= num && num <= outsideRadius)
				{
					disConfromPoint.Add(regionBossSummonMonsterPointGizmos.get_Item(i));
				}
			}
		}
		if (disConfromPoint.Count < summonCount)
		{
			summonCount = disConfromPoint.Count;
		}
		List<Vector3> list = new List<Vector3>();
		for (int j = 0; j < summonCount; j++)
		{
			int index = MonoSingleton<GameController>.Instance.Random_Roguelike(0, disConfromPoint.Count);
			RegionBossSummonMonsterPointGizmo regionBossSummonMonsterPointGizmo = disConfromPoint.get_Item(index);
			regionBossSummonMonsterPointGizmo.monsterID = summonMonsterID;
			randomPoint.Add(regionBossSummonMonsterPointGizmo);
			list.Add(regionBossSummonMonsterPointGizmo.transform.position);
			disConfromPoint.RemoveAt(index);
		}
		return list;
	}
}
