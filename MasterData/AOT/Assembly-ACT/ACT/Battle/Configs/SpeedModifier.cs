using System;
using UnityEngine;

namespace ACT.Battle.Configs;

public class SpeedModifier : VelocityModifier
{
	[Tooltip("如果填写负值只会减速到0，不会反向加速")]
	public float acc;

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
		velocity -= vector;
		vector = vector.normalized * Mathf.Max(0f, vector.magnitude + acc * dt);
		velocity += vector;
		return velocity;
	}
}
