using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace Ase;

public class PathfindingManager
{
	private Dictionary<int, int> cacheAgents = new Dictionary<int, int>();

	private GameObject navMeshRoot;

	public void Init()
	{
	}

	public void SetNavMeshRoot(GameObject root)
	{
		navMeshRoot = root;
	}

	public bool HasNavMesh(int navMeshId)
	{
		return cacheAgents.ContainsKey(navMeshId);
	}

	public NavMeshPath CalculatePath(int levelId, Vector3 sourcePosition, Vector3 targetPosition)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Expected O, but got Unknown
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		int navMesh = GetNavMesh(levelId);
		NavMeshPath val = new NavMeshPath();
		val.ClearCorners();
		if (navMesh == 0)
		{
			return val;
		}
		NavMeshQueryFilter val2 = default(NavMeshQueryFilter);
		((NavMeshQueryFilter)(ref val2)).agentTypeID = navMesh;
		((NavMeshQueryFilter)(ref val2)).areaMask = -1;
		NavMeshQueryFilter val3 = val2;
		NavMesh.CalculatePath(sourcePosition, targetPosition, val3, val);
		return val;
	}

	public void Clear()
	{
		NavMesh.RemoveAllNavMeshData();
		for (int num = navMeshRoot.transform.childCount - 1; num >= 0; num--)
		{
			Object.Destroy(navMeshRoot.transform.GetChild(num).gameObject);
		}
		cacheAgents.Clear();
	}

	private int GetNavMesh(int navMeshId)
	{
		if (!HasNavMesh(navMeshId))
		{
			return 0;
		}
		return cacheAgents[navMeshId];
	}
}
