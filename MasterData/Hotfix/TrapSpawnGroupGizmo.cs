using System.Collections.Generic;

public class TrapSpawnGroupGizmo : BaseSpawnPointGizmo
{
	public bool isTriggerActived;

	public int GroupId;

	protected override void OnActive()
	{
		base.OnActive();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
	}

	public override void Initialize(int x, int y)
	{
		base.Initialize(x, y);
		childrenGizmos = new List<BaseSpawnPointGizmo>();
		TrapSpawnPointGizmo[] componentsInChildren = GetComponentsInChildren<TrapSpawnPointGizmo>();
		foreach (TrapSpawnPointGizmo trapSpawnPointGizmo in componentsInChildren)
		{
			trapSpawnPointGizmo.GroupId = GroupId;
			trapSpawnPointGizmo.IsActive = isTriggerActived;
			if (trapSpawnPointGizmo.isActiveAndEnabled)
			{
				childrenGizmos.Add(trapSpawnPointGizmo);
			}
		}
		childrenGizmos.Sort();
		for (int j = 0; j < childrenGizmos.Count; j++)
		{
			childrenGizmos.get_Item(j).Initialize(x, y);
		}
	}

	public void SetTrapActive(bool active)
	{
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			((TrapSpawnPointGizmo)childrenGizmos.get_Item(i)).IsActive = active;
		}
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
			if (childrenGizmos.get_Item(i) is TrapSpawnPointGizmo { spawnTrapUniqueID: var spawnTrapUniqueID } && spawnTrapUniqueID != 0L)
			{
				list.Add(spawnTrapUniqueID);
			}
		}
		return list;
	}
}
