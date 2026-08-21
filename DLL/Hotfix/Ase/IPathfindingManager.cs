using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.AI;

namespace Ase;

public interface IPathfindingManager
{
	void Init();

	void SetNavMeshRoot(GameObject root);

	bool HasNavMesh(int navMeshId);

	Task<int> GenerateNavMesh(int navMeshId);

	NavMeshPath CalculatePath(int navMeshId, Vector3 sourcePosition, Vector3 targetPosition);

	void Clear();
}
