using Ase.ECS;
using UnityEngine;

namespace Ase;

public class BulletRayData : BulletMoveDataBase
{
	public BaseEntity reflexRoot;

	public Vector3 inPoint;

	public int reflexCount;

	public override BulletMoveDataBase Clone()
	{
		return new BulletRayData
		{
			reflexRoot = reflexRoot,
			inPoint = inPoint,
			reflexCount = reflexCount
		};
	}
}
