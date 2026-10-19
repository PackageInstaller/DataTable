using System;

namespace ACT.Battle.Configs;

[Serializable]
public struct VelocityRange
{
	public float maxAcceleration;

	public float maxBrakingDeceleration;

	public float maxSpeed;

	public float friction;
}
