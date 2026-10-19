using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class AnimationClipMovementPattern : TrajectoryMovementPattern
{
	public AnimationClip clip;

	public Vector3 aimRotation;

	public float radius;

	public float lifeTime;

	public float perDis;

	public int maxCount;

	public float speed = 1f;

	internal Quaternion quaternion;

	public AnimationCurve xCurve;

	public AnimationCurve yCurve;

	public AnimationCurve zCurve;

	private const string m_PosX = "m_LocalPosition.x";

	private const string m_PosY = "m_LocalPosition.y";

	private const string m_PosZ = "m_LocalPosition.z";

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		AnimationClipMovementRunner animationClipMovementRunner = new AnimationClipMovementRunner();
		quaternion = Quaternion.Euler(aimRotation);
		animationClipMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return animationClipMovementRunner;
	}
}
