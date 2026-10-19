using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigHitParameter : ScriptableObject
{
	public HitType hitType;

	public EndureType hitEndureType;

	public HitExpressive hitExpressive;

	[Range(0f, 255f)]
	public float horizontalVelocity;

	[Range(-255f, 255f)]
	public float verticalVelocity;

	[Space]
	[Range(0f, 222f)]
	public float length;

	[Space]
	[Range(-180f, 180f)]
	public float angle;

	[Space]
	public bool overrideSpeed = true;

	[Space]
	[Range(0f, 222f)]
	public float hitBrakingDeceleration;

	[Space]
	[Range(0f, 22f)]
	public float hitHorizontalFriction;

	[Space]
	[Range(-200f, 0f)]
	public float upwardGravity;

	[Space]
	[Range(0f, 200f)]
	public float upwardFriction;

	[Space]
	[Range(-200f, 0f)]
	public float downwardGravity;

	[Space]
	[Range(0f, 180f)]
	public float downwardMaxSpeed;

	[Space]
	[Range(0f, 200f)]
	public float downwardFriction;
}
