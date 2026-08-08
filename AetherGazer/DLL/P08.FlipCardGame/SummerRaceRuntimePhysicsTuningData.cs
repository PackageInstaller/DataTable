using UnityEngine;

public sealed class SummerRaceRuntimePhysicsTuningData
{
	public bool useContactProbe;

	public float suspensionProbeExtra;

	public int maxContactPerWheel;

	public bool exaggerateBuildDifference;

	public float massDistributionAmplify;

	public float recoilAmplify;

	public Vector2 centerOfMassOffsetAmplify;

	public float wheelAsymmetryYawAmplify;

	public float comBiasYawAmplify;

	public float recoilMassReference;

	public float driveForceAmplify;

	public float tractionAmplify;

	public float driveLoadTransferStrength;

	public float dynamicSupportDriveScale;

	public float dynamicSupportRollingDragScale;

	public float dynamicSupportSpringScale;

	public float steerTorque;

	public float speedClampMultiplier;

	public float slipToForceGain;

	public float maxAngularSpeedDegPerSec;

	public float uprightAssistDamping;

	public float minUprightAssist;

	public float maxUprightAssist;

	public float collisionForceScale;

	public float flipRescueForwardForcePerMass;

	public float flipRescueForceLiftOffset;

	public float wallStuckRescueDelay;

	public float wallStuckRescueMinNormalX;

	public float wallStuckRescueMaxSpeed;

	public float wallStuckRescueMinEscapeSpeed;

	public float wallStuckRescueCooldown;

	public float wallStuckRescueTorque;

	public float wallStuckRescueForcePerMass;

	public float wallStuckRescueForceDuration;

	public float vehicleStuckRescueMinThrottle;

	public float vehicleStuckRescueMinContactDot;

	public float vehicleStuckRescueContactHold;
}
