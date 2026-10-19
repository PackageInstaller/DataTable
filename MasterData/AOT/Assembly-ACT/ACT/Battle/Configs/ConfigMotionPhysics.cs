using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigMotionPhysics : ScriptableObject
{
	public OverrideParameter<float> rotateSpeed;

	public OverrideParameter<VelocityRange> fly;

	[Space(30f)]
	public OverrideParameter<float> gravity;

	public OverrideParameter<float> fallVertMaxSpeed;

	public OverrideParameter<float> maxFallSpeed;

	public OverrideParameter<float> fallingFriction;

	public OverrideParameter<float> fallMaxAcceleration;

	public OverrideParameter<float> fallMaxBrakingDeceleration;

	[Space(30f)]
	public OverrideParameter<float> walkMaxSpeed;

	public OverrideParameter<float> walkMaxAcceleration;

	public OverrideParameter<float> walkBrakingDeceleration;

	public OverrideParameter<float> walkFriction;
}
