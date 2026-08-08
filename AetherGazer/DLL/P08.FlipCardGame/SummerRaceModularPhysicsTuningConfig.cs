using System;
using UnityEngine;

[Serializable]
public sealed class SummerRaceModularPhysicsTuningConfig
{
	public bool useContactProbe = true;

	public float suspensionProbeExtra;

	public int maxContactPerWheel = 24;

	public bool exaggerateBuildDifference = true;

	public float massDistributionAmplify;

	public float recoilAmplify;

	public Vector2 centerOfMassOffsetAmplify;

	public float wheelAsymmetryYawAmplify;

	public float comBiasYawAmplify;

	public float recoilMassReference;

	public float driveForceAmplify;

	public float tractionAmplify;

	public float driveLoadTransferStrength = 0.18f;

	public float dynamicSupportDriveScale = 0.58f;

	public float dynamicSupportRollingDragScale = 0.4f;

	public float dynamicSupportSpringScale = 0.72f;

	public float steerTorque;

	public float speedClampMultiplier;

	public float slipToForceGain;

	public float maxAngularSpeedDegPerSec;

	public float uprightAssistDamping;

	public float minUprightAssist;

	public float maxUprightAssist;

	public float collisionForceScale = 0.072f;

	public float flipRescueForwardForcePerMass = 7.5f;

	public float flipRescueForceLiftOffset = 0.45f;

	public float wallStuckRescueDelay = 0.75f;

	public float wallStuckRescueMinNormalX = 0.6f;

	public float wallStuckRescueMaxSpeed = 0.4f;

	public float wallStuckRescueMinEscapeSpeed = 1.1f;

	public float wallStuckRescueCooldown = 1.1f;

	public float wallStuckRescueTorque = 95f;

	public float wallStuckRescueForcePerMass = 2.4f;

	public float wallStuckRescueForceDuration = 0.45f;

	public float vehicleStuckRescueMinThrottle = 0.55f;

	public float vehicleStuckRescueMinContactDot = 0.35f;

	public float vehicleStuckRescueContactHold = 0.28f;
}
