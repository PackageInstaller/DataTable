using UnityEngine;

namespace ACT.Battle.Configs;

public class AccLifeTimeModifier : VelocityModifier
{
	[Tooltip("加速度随时间变化的曲线")]
	public AnimationCurve lifeTimeAccCurve;

	public override Vector3 Modify(Vector3 velocity, float dt, float lifeTime)
	{
		velocity += velocity.normalized * (lifeTimeAccCurve.Evaluate(lifeTime) * dt);
		return velocity;
	}
}
