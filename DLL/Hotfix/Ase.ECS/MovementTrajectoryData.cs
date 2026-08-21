using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public abstract class MovementTrajectoryData : IReference
{
	public abstract MovementTrajectoryTypeEnum TrajectoryTypeEnum { get; }

	public abstract Vector3 LastFramePosition { get; }

	public abstract Vector3 TargetPoint { get; }

	public abstract float MoveTime { get; }

	public abstract Vector3 Tangent { get; }

	public abstract MovementTrajectoryData CopySelf();

	public virtual Vector3 GetNextPoint(Vector3 lastPos, float deltaTime)
	{
		return Vector3.zero;
	}

	public virtual Vector3 GetNextPoint(float moveTime)
	{
		return Vector3.zero;
	}

	public virtual Quaternion GetNextQuaternion(Quaternion quaternion, float deltaTime)
	{
		return Quaternion.identity;
	}

	public abstract void Dispose();

	public virtual void Clear()
	{
	}
}
