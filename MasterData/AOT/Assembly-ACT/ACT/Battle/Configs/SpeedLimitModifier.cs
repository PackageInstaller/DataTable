using System;
using UnityEngine;

namespace ACT.Battle.Configs;

public class SpeedLimitModifier : VelocityModifier
{
	public float max;

	public DimensionMode dimensionMode = DimensionMode.XYZ;

	public override Vector3 Modify(Vector3 velocity, float dt, float lifeTime)
	{
		Vector3 vector = dimensionMode switch
		{
			DimensionMode.XZ => new Vector3(velocity.x, 0f, velocity.z), 
			DimensionMode.XYZ => velocity, 
			DimensionMode.Z => new Vector3(0f, 0f, velocity.z), 
			DimensionMode.X => new Vector3(velocity.x, 0f, 0f), 
			DimensionMode.Y => new Vector3(0f, velocity.y, 0f), 
			_ => throw new NotImplementedException(), 
		};
		if (vector.magnitude > max)
		{
			velocity -= vector;
			vector = vector.normalized * max;
			velocity += vector;
		}
		return velocity;
	}
}
