using System;
using UnityEngine;

[Serializable]
public sealed class SummerRaceWheelDefConfig
{
	public string name = "Wheel";

	public Vector2 localPosition = new Vector2(0f, -0.3f);

	public float radius = 0.24f;

	public float width;

	public float moduleMass;

	public int moduleCost;

	public float grip;

	public float suspensionLength;

	public float springStrength;

	public float damping;

	public float maxMotorTorque;

	public float maxAngularVelocity;

	public float rollingResistance;

	public bool powered = true;

	public bool steerable;

	public string wheelSpritePath = string.Empty;

	public string innerWheelSpritePath = string.Empty;

	public float wheelVisualScale = 1f;
}
