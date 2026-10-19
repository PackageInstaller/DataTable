using UnityEngine;

namespace ACT.Battle.Configs;

public class SpeedLifeTimeModifier : VelocityModifier
{
	[Tooltip("速度随时间变化的曲线")]
	public AnimationCurve lifeTimeSpeedCurve;

	public override Vector3 Modify(Vector3 velocity, float dt, float lifeTime)
	{
		return velocity.normalized * lifeTimeSpeedCurve.Evaluate(lifeTime);
	}
}
