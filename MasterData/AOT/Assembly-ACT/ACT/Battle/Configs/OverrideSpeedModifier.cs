using UnityEngine;

namespace ACT.Battle.Configs;

public class OverrideSpeedModifier : VelocityModifier
{
	public Vector3 speed = Vector3.zero;

	public DimensionMode dimensionMode = DimensionMode.XYZ;

	public override Vector3 Modify(Vector3 velocity, float dt, float lifeTime)
	{
		return dimensionMode switch
		{
			DimensionMode.XZ => new Vector3(speed.x, velocity.y, speed.z), 
			DimensionMode.XYZ => speed, 
			DimensionMode.Z => new Vector3(velocity.x, velocity.y, speed.z), 
			DimensionMode.X => new Vector3(speed.x, velocity.y, velocity.z), 
			DimensionMode.Y => new Vector3(velocity.x, speed.y, velocity.z), 
			_ => velocity, 
		};
	}
}
