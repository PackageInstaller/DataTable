using UnityEngine;

namespace ACT.Battle.Configs;

public class GravityModifier : VelocityModifier
{
	[Tooltip("以下为正方向")]
	public float acc;

	public override Vector3 Modify(Vector3 velocity, float dt, float lifeTime)
	{
		return velocity + Vector3.down * acc * dt;
	}
}
