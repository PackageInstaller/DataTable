using UnityEngine;

namespace ACT.Battle.Configs;

public class FrictionModifier : VelocityModifier
{
	public AnimationCurve frictionCurve;

	public override Vector3 Modify(Vector3 velocity, float dt, float lifeTime)
	{
		velocity.Scale((1f - frictionCurve.Evaluate(velocity.magnitude)) * Vector3.one);
		return velocity;
	}
}
