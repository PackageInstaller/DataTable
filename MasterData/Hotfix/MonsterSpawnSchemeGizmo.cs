using System.Collections.Generic;
using UnityEngine;

public class MonsterSpawnSchemeGizmo : BaseSpawnPointGizmo
{
	[HideInInspector]
	public bool isElite;

	public bool enableRoguelikeFloorCondition;

	public int activeMinFloor;

	public int activeMaxFloor;

	public MonsterSpawnSchemeGizmo preRefreshScheme;

	public void OnValueChanged()
	{
		if (null != preRefreshScheme)
		{
			isElite = false;
		}
	}

	public override void EnableSpawnLogic()
	{
		base.EnableSpawnLogic();
		isSpawnActived = true;
	}

	public override void ResetSpawnState()
	{
		base.ResetSpawnState();
		isSpawnActived = false;
	}

	public override bool CheckActiveConditions()
	{
		return true;
	}

	public override bool IsAllActivedAndDied()
	{
		if (isSpawnActived)
		{
			return base.IsAllActivedAndDied();
		}
		return true;
	}

	public override bool IsAllActivedAndDied_NoSummons()
	{
		if (isSpawnActived)
		{
			return base.IsAllActivedAndDied_NoSummons();
		}
		return true;
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
}
