using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/Config/BodyDef", fileName = "SummerRaceBodyDef")]
public class SummerRaceBodyDefSO : ScriptableObject
{
	public SummerRaceBodyTypeConfig bodyType = SummerRaceBodyTypeConfig.Medium;

	public string displayName = "Medium Body";

	public int costCap = 10;

	public int weaponSlots = 2;

	public int equipSlots = 2;

	public float baseHp = 10f;

	public float moveSpeed = 4.7f;

	public float forwardAcceleration = 8.5f;

	public float mass = 36f;

	public float drag = 0.28f;

	public float angularDrag = 3.5f;

	public float gravityScale = 2.35f;

	public float tractionGain = 8.4f;

	public float collisionImpulseScale = 0.072f;

	public float laneSpring = 38f;

	public float laneDamping = 11f;

	public Vector2 centerOfMassOffset = new Vector2(0f, -0.07f);

	public float modularChassisClearance;

	public float modularStabilityAssist;

	public SummerRaceModularPhysicsTuningConfig modularPhysicsTuning = new SummerRaceModularPhysicsTuningConfig();

	public string normalBodySpineSkeletonDataPath = string.Empty;

	public string battleBodySkeletonDataPath = string.Empty;

	public float battleBodyVisualScale = 0.78f;

	public Color bodyColor = new Color(0.35f, 0.58f, 0.34f, 1f);

	public Vector3 bodyScale = new Vector3(1.26f, 0.75f, 1f);

	public List<Vector2> colliderPoints = new List<Vector2>
	{
		new Vector2(-0.62f, -0.35f),
		new Vector2(0.6f, -0.35f),
		new Vector2(0.63f, -0.1f),
		new Vector2(0.63f, 0.12f),
		new Vector2(0.4f, 0.29f),
		new Vector2(-0.3f, 0.31f),
		new Vector2(-0.6f, 0.12f)
	};

	public List<SummerRaceWheelDefConfig> wheels = new List<SummerRaceWheelDefConfig>
	{
		new SummerRaceWheelDefConfig
		{
			name = "Front",
			localPosition = new Vector2(0.4f, -0.34f),
			radius = 0.26f
		},
		new SummerRaceWheelDefConfig
		{
			name = "Back",
			localPosition = new Vector2(-0.4f, -0.34f),
			radius = 0.26f
		}
	};

	public List<SummerRaceMountPointDefConfig> mountPoints = new List<SummerRaceMountPointDefConfig>
	{
		new SummerRaceMountPointDefConfig
		{
			slotType = SummerRaceMountSlotTypeConfig.Weapon,
			slotIndex = 0,
			localPosition = new Vector2(0.45f, 0.15f),
			localAngle = 0f
		},
		new SummerRaceMountPointDefConfig
		{
			slotType = SummerRaceMountSlotTypeConfig.Weapon,
			slotIndex = 1,
			localPosition = new Vector2(0.15f, 0.18f),
			localAngle = 0f
		},
		new SummerRaceMountPointDefConfig
		{
			slotType = SummerRaceMountSlotTypeConfig.Equip,
			slotIndex = 0,
			localPosition = new Vector2(-0.2f, 0.18f),
			localAngle = 0f
		},
		new SummerRaceMountPointDefConfig
		{
			slotType = SummerRaceMountSlotTypeConfig.Equip,
			slotIndex = 1,
			localPosition = new Vector2(-0.45f, 0.13f),
			localAngle = 0f
		}
	};

	public GameObject chassisPrefab;

	public string chassisPrefabPath = string.Empty;

	public void ApplyPresetForBodyType()
	{
		switch (bodyType)
		{
		case SummerRaceBodyTypeConfig.Light:
			ApplyLightPreset();
			break;
		case SummerRaceBodyTypeConfig.Heavy:
			ApplyHeavyPreset();
			break;
		default:
			ApplyMediumPreset();
			break;
		}
		PopulateBodyModularTuningDefaults();
		PopulateWheelModularPhysicsFromBodyStats();
	}

	public void SyncMountsBySlotCount()
	{
		EnsureMountCount(SummerRaceMountSlotTypeConfig.Weapon, weaponSlots, 0.45f);
		EnsureMountCount(SummerRaceMountSlotTypeConfig.Equip, equipSlots, -0.2f);
	}

	public bool ValidateModularData(out string reason)
	{
		if (string.IsNullOrWhiteSpace(normalBodySpineSkeletonDataPath))
		{
			reason = "normalBodySpineSkeletonDataPath is empty";
			return false;
		}
		if (!SummerRaceConfigLoader.TryValidateSkeletonDataPath(normalBodySpineSkeletonDataPath, out var reason2))
		{
			reason = "normalBodySpineSkeletonDataPath is invalid: " + reason2;
			return false;
		}
		if (string.IsNullOrWhiteSpace(battleBodySkeletonDataPath))
		{
			reason = "battleBodySkeletonDataPath is empty";
			return false;
		}
		if (!SummerRaceConfigLoader.TryValidateSkeletonDataPath(battleBodySkeletonDataPath, out var reason3))
		{
			reason = "battleBodySkeletonDataPath is invalid: " + reason3;
			return false;
		}
		if (battleBodyVisualScale <= 0f)
		{
			reason = "battleBodyVisualScale must be > 0";
			return false;
		}
		if (modularChassisClearance <= 0f)
		{
			reason = "modularChassisClearance must be > 0";
			return false;
		}
		if (modularStabilityAssist <= 0f)
		{
			reason = "modularStabilityAssist must be > 0";
			return false;
		}
		if (wheels == null || wheels.Count <= 0)
		{
			reason = "wheels is empty";
			return false;
		}
		for (int i = 0; i < wheels.Count; i++)
		{
			SummerRaceWheelDefConfig summerRaceWheelDefConfig = wheels[i];
			if (summerRaceWheelDefConfig == null)
			{
				reason = "wheel[" + i + "] is null";
				return false;
			}
			if (string.IsNullOrWhiteSpace(summerRaceWheelDefConfig.name))
			{
				reason = "wheel[" + i + "].name is empty";
				return false;
			}
			if (string.IsNullOrWhiteSpace(summerRaceWheelDefConfig.wheelSpritePath))
			{
				reason = "wheel[" + i + "].wheelSpritePath is empty";
				return false;
			}
			if (string.IsNullOrWhiteSpace(summerRaceWheelDefConfig.innerWheelSpritePath))
			{
				reason = "wheel[" + i + "].innerWheelSpritePath is empty";
				return false;
			}
			if (summerRaceWheelDefConfig.wheelVisualScale <= 0f)
			{
				reason = "wheel[" + i + "].wheelVisualScale must be > 0";
				return false;
			}
			if (!SummerRaceConfigLoader.TryLoadSprite(summerRaceWheelDefConfig.wheelSpritePath, out var sprite))
			{
				reason = "wheel[" + i + "].wheelSpritePath cannot be loaded";
				return false;
			}
			if (!SummerRaceConfigLoader.TryLoadSprite(summerRaceWheelDefConfig.innerWheelSpritePath, out sprite))
			{
				reason = "wheel[" + i + "].innerWheelSpritePath cannot be loaded";
				return false;
			}
			if (summerRaceWheelDefConfig.radius <= 0f || summerRaceWheelDefConfig.width <= 0f || summerRaceWheelDefConfig.moduleMass <= 0f || summerRaceWheelDefConfig.moduleCost < 0 || summerRaceWheelDefConfig.grip <= 0f || summerRaceWheelDefConfig.suspensionLength <= 0f || summerRaceWheelDefConfig.springStrength <= 0f || summerRaceWheelDefConfig.damping <= 0f || summerRaceWheelDefConfig.maxMotorTorque <= 0f || summerRaceWheelDefConfig.maxAngularVelocity <= 0f || summerRaceWheelDefConfig.rollingResistance < 0f)
			{
				reason = "wheel[" + i + "] modular physics fields are invalid";
				return false;
			}
		}
		if (modularPhysicsTuning == null)
		{
			reason = "modularPhysicsTuning is null";
			return false;
		}
		if (modularPhysicsTuning.suspensionProbeExtra <= 0f || modularPhysicsTuning.maxContactPerWheel <= 0 || modularPhysicsTuning.massDistributionAmplify <= 0f || modularPhysicsTuning.recoilAmplify <= 0f || modularPhysicsTuning.centerOfMassOffsetAmplify.x <= 0f || modularPhysicsTuning.centerOfMassOffsetAmplify.y <= 0f || modularPhysicsTuning.recoilMassReference <= 0f || modularPhysicsTuning.driveForceAmplify <= 0f || modularPhysicsTuning.tractionAmplify <= 0f || modularPhysicsTuning.driveLoadTransferStrength < 0f || modularPhysicsTuning.dynamicSupportDriveScale < 0f || modularPhysicsTuning.dynamicSupportRollingDragScale < 0f || modularPhysicsTuning.dynamicSupportSpringScale <= 0f || modularPhysicsTuning.dynamicSupportSpringScale > 1f || modularPhysicsTuning.steerTorque <= 0f || modularPhysicsTuning.speedClampMultiplier <= 0f || modularPhysicsTuning.slipToForceGain <= 0f || modularPhysicsTuning.maxAngularSpeedDegPerSec <= 0f || modularPhysicsTuning.minUprightAssist < 0f || modularPhysicsTuning.maxUprightAssist < modularPhysicsTuning.minUprightAssist || modularPhysicsTuning.collisionForceScale < 0f || modularPhysicsTuning.flipRescueForwardForcePerMass <= 0f || modularPhysicsTuning.flipRescueForceLiftOffset < 0f || modularPhysicsTuning.wallStuckRescueDelay <= 0f || modularPhysicsTuning.wallStuckRescueMinNormalX <= 0f || modularPhysicsTuning.wallStuckRescueMinNormalX > 1f || modularPhysicsTuning.wallStuckRescueMaxSpeed < 0f || modularPhysicsTuning.wallStuckRescueMinEscapeSpeed < 0f || modularPhysicsTuning.wallStuckRescueCooldown <= 0f || modularPhysicsTuning.wallStuckRescueTorque < 0f || modularPhysicsTuning.wallStuckRescueForcePerMass < 0f || modularPhysicsTuning.wallStuckRescueForceDuration <= 0f || modularPhysicsTuning.vehicleStuckRescueMinThrottle < 0f || modularPhysicsTuning.vehicleStuckRescueMinThrottle > 1f || modularPhysicsTuning.vehicleStuckRescueMinContactDot < 0f || modularPhysicsTuning.vehicleStuckRescueMinContactDot > 1f || modularPhysicsTuning.vehicleStuckRescueContactHold <= 0f)
		{
			reason = "modularPhysicsTuning contains invalid values";
			return false;
		}
		reason = "OK";
		return true;
	}

	public Vector2[] GetColliderPointsOrThrow()
	{
		if (colliderPoints == null || colliderPoints.Count < 3)
		{
			throw new InvalidOperationException("Body colliderPoints must contain at least 3 points: " + base.name);
		}
		return colliderPoints.ToArray();
	}

	public Vector2[] GetColliderPointsOrFallback()
	{
		return GetColliderPointsOrThrow();
	}

	private void ApplyLightPreset()
	{
		displayName = "Light Body";
		costCap = 8;
		weaponSlots = 2;
		equipSlots = 1;
		baseHp = 7f;
		moveSpeed = 5.4f;
		forwardAcceleration = 10.2f;
		mass = 26f;
		drag = 0.2f;
		angularDrag = 2.6f;
		gravityScale = 2.2f;
		tractionGain = 9.5f;
		collisionImpulseScale = 0.05f;
		laneSpring = 34f;
		laneDamping = 10f;
		centerOfMassOffset = new Vector2(-0.02f, -0.1f);
		bodyColor = new Color(0.23f, 0.62f, 0.95f, 1f);
		bodyScale = new Vector3(1.15f, 0.72f, 1f);
		colliderPoints = new List<Vector2>
		{
			new Vector2(-0.6f, -0.33f),
			new Vector2(0.4f, -0.33f),
			new Vector2(0.63f, -0.18f),
			new Vector2(0.65f, 0.02f),
			new Vector2(0.24f, 0.27f),
			new Vector2(-0.34f, 0.28f),
			new Vector2(-0.58f, 0.06f)
		};
		wheels = new List<SummerRaceWheelDefConfig>
		{
			new SummerRaceWheelDefConfig
			{
				name = "Front",
				localPosition = new Vector2(0.4f, -0.4f),
				radius = 0.22f
			},
			new SummerRaceWheelDefConfig
			{
				name = "Back",
				localPosition = new Vector2(-0.36f, -0.4f),
				radius = 0.22f
			}
		};
		SyncMountsBySlotCount();
		PopulateBodyModularTuningDefaults();
		PopulateWheelModularPhysicsFromBodyStats();
	}

	private void ApplyMediumPreset()
	{
		displayName = "Medium Body";
		costCap = 10;
		weaponSlots = 2;
		equipSlots = 2;
		baseHp = 10f;
		moveSpeed = 4.7f;
		forwardAcceleration = 8.5f;
		mass = 36f;
		drag = 0.28f;
		angularDrag = 3.5f;
		gravityScale = 2.35f;
		tractionGain = 8.4f;
		collisionImpulseScale = 0.072f;
		laneSpring = 38f;
		laneDamping = 11f;
		centerOfMassOffset = new Vector2(0f, -0.07f);
		bodyColor = new Color(0.35f, 0.58f, 0.34f, 1f);
		bodyScale = new Vector3(1.26f, 0.75f, 1f);
		colliderPoints = new List<Vector2>
		{
			new Vector2(-0.62f, -0.35f),
			new Vector2(0.6f, -0.35f),
			new Vector2(0.63f, -0.1f),
			new Vector2(0.63f, 0.12f),
			new Vector2(0.4f, 0.29f),
			new Vector2(-0.3f, 0.31f),
			new Vector2(-0.6f, 0.12f)
		};
		wheels = new List<SummerRaceWheelDefConfig>
		{
			new SummerRaceWheelDefConfig
			{
				name = "Front",
				localPosition = new Vector2(0.4f, -0.34f),
				radius = 0.26f
			},
			new SummerRaceWheelDefConfig
			{
				name = "Back",
				localPosition = new Vector2(-0.4f, -0.34f),
				radius = 0.26f
			}
		};
		SyncMountsBySlotCount();
		PopulateBodyModularTuningDefaults();
		PopulateWheelModularPhysicsFromBodyStats();
	}

	private void ApplyHeavyPreset()
	{
		displayName = "Heavy Body";
		costCap = 7;
		weaponSlots = 2;
		equipSlots = 1;
		baseHp = 13f;
		moveSpeed = 4f;
		forwardAcceleration = 7.1f;
		mass = 52f;
		drag = 0.35f;
		angularDrag = 5f;
		gravityScale = 2.6f;
		tractionGain = 7.2f;
		collisionImpulseScale = 0.095f;
		laneSpring = 42f;
		laneDamping = 13f;
		centerOfMassOffset = new Vector2(0.08f, -0.09f);
		bodyColor = new Color(0.66f, 0.35f, 0.25f, 1f);
		bodyScale = new Vector3(1.36f, 0.78f, 1f);
		colliderPoints = new List<Vector2>
		{
			new Vector2(-0.7f, -0.38f),
			new Vector2(0.7f, -0.38f),
			new Vector2(0.72f, -0.04f),
			new Vector2(0.72f, 0.26f),
			new Vector2(0.3f, 0.34f),
			new Vector2(-0.42f, 0.34f),
			new Vector2(-0.7f, 0.18f)
		};
		wheels = new List<SummerRaceWheelDefConfig>
		{
			new SummerRaceWheelDefConfig
			{
				name = "Front",
				localPosition = new Vector2(0.46f, -0.27f),
				radius = 0.31f
			},
			new SummerRaceWheelDefConfig
			{
				name = "Back",
				localPosition = new Vector2(-0.46f, -0.27f),
				radius = 0.31f
			}
		};
		SyncMountsBySlotCount();
		PopulateBodyModularTuningDefaults();
		PopulateWheelModularPhysicsFromBodyStats();
	}

	private void OnValidate()
	{
		PopulateBodyModularTuningDefaults();
		PopulateWheelModularPhysicsFromBodyStats();
	}

	private void PopulateBodyModularTuningDefaults()
	{
		modularChassisClearance = Mathf.Max(0.01f, 0.16f + Mathf.Abs(centerOfMassOffset.y) * 0.15f);
		modularStabilityAssist = Mathf.Clamp(laneSpring * 0.22f, 2f, 18f);
		if (modularPhysicsTuning == null)
		{
			modularPhysicsTuning = new SummerRaceModularPhysicsTuningConfig();
		}
		float num = Mathf.InverseLerp(26f, 52f, Mathf.Max(1f, mass));
		float num2 = ComputeAverageWheelRadiusForTuning();
		float num3 = Mathf.InverseLerp(0.22f, 0.34f, num2);
		float t = Mathf.Clamp01((1f - num) * 0.75f + (1f - num3) * 0.25f);
		modularPhysicsTuning.suspensionProbeExtra = Mathf.Clamp(num2 * 0.85f, 0.18f, 0.28f);
		modularPhysicsTuning.maxContactPerWheel = Mathf.Max(1, modularPhysicsTuning.maxContactPerWheel);
		modularPhysicsTuning.massDistributionAmplify = Mathf.Max(0.01f, Mathf.Lerp(1.05f, 1.18f, num));
		modularPhysicsTuning.recoilAmplify = 1f;
		modularPhysicsTuning.centerOfMassOffsetAmplify.x = 1f;
		modularPhysicsTuning.centerOfMassOffsetAmplify.y = 1f;
		modularPhysicsTuning.wheelAsymmetryYawAmplify = Mathf.Max(0f, Mathf.Lerp(16f, 8f, num));
		modularPhysicsTuning.comBiasYawAmplify = 0f;
		modularPhysicsTuning.recoilMassReference = Mathf.Max(0.01f, mass);
		modularPhysicsTuning.driveForceAmplify = Mathf.Max(0.01f, Mathf.Lerp(1.16f, 1.02f, num));
		modularPhysicsTuning.tractionAmplify = Mathf.Max(0.01f, Mathf.Lerp(1.12f, 1f, num));
		modularPhysicsTuning.driveLoadTransferStrength = Mathf.Clamp(modularPhysicsTuning.driveLoadTransferStrength, 0f, 0.45f);
		modularPhysicsTuning.dynamicSupportDriveScale = Mathf.Max(0f, modularPhysicsTuning.dynamicSupportDriveScale);
		modularPhysicsTuning.dynamicSupportRollingDragScale = Mathf.Max(0f, modularPhysicsTuning.dynamicSupportRollingDragScale);
		modularPhysicsTuning.dynamicSupportSpringScale = Mathf.Clamp(modularPhysicsTuning.dynamicSupportSpringScale, 0.2f, 1f);
		modularPhysicsTuning.steerTorque = Mathf.Max(0.01f, Mathf.Lerp(24f, 18f, num) * Mathf.Lerp(0.95f, 1.05f, t));
		modularPhysicsTuning.speedClampMultiplier = Mathf.Max(0.01f, Mathf.Lerp(1.18f, 1.03f, num));
		modularPhysicsTuning.slipToForceGain = Mathf.Max(0.01f, Mathf.Lerp(10f, 7f, num));
		modularPhysicsTuning.maxAngularSpeedDegPerSec = Mathf.Max(0.01f, Mathf.Lerp(460f, 360f, num));
		modularPhysicsTuning.uprightAssistDamping = Mathf.Max(0f, Mathf.Lerp(1f, 1.6f, num));
		modularPhysicsTuning.minUprightAssist = Mathf.Max(0f, Mathf.Lerp(1.6f, 2.4f, num));
		modularPhysicsTuning.maxUprightAssist = Mathf.Max(modularPhysicsTuning.minUprightAssist, Mathf.Lerp(16f, 11f, num));
		modularPhysicsTuning.collisionForceScale = Mathf.Max(0f, collisionImpulseScale);
		modularPhysicsTuning.flipRescueForwardForcePerMass = Mathf.Max(0.01f, modularPhysicsTuning.flipRescueForwardForcePerMass);
		modularPhysicsTuning.flipRescueForceLiftOffset = Mathf.Max(0f, modularPhysicsTuning.flipRescueForceLiftOffset);
		modularPhysicsTuning.wallStuckRescueDelay = Mathf.Max(0.05f, modularPhysicsTuning.wallStuckRescueDelay);
		modularPhysicsTuning.wallStuckRescueMinNormalX = Mathf.Clamp(modularPhysicsTuning.wallStuckRescueMinNormalX, 0.1f, 1f);
		modularPhysicsTuning.wallStuckRescueMaxSpeed = Mathf.Max(0f, modularPhysicsTuning.wallStuckRescueMaxSpeed);
		modularPhysicsTuning.wallStuckRescueMinEscapeSpeed = Mathf.Max(0f, modularPhysicsTuning.wallStuckRescueMinEscapeSpeed);
		modularPhysicsTuning.wallStuckRescueCooldown = Mathf.Max(0.05f, modularPhysicsTuning.wallStuckRescueCooldown);
		modularPhysicsTuning.wallStuckRescueTorque = Mathf.Max(0f, modularPhysicsTuning.wallStuckRescueTorque);
		modularPhysicsTuning.wallStuckRescueForcePerMass = Mathf.Max(0f, modularPhysicsTuning.wallStuckRescueForcePerMass);
		modularPhysicsTuning.wallStuckRescueForceDuration = Mathf.Max(0.05f, modularPhysicsTuning.wallStuckRescueForceDuration);
		modularPhysicsTuning.vehicleStuckRescueMinThrottle = Mathf.Clamp01(modularPhysicsTuning.vehicleStuckRescueMinThrottle);
		modularPhysicsTuning.vehicleStuckRescueMinContactDot = Mathf.Clamp01(modularPhysicsTuning.vehicleStuckRescueMinContactDot);
		modularPhysicsTuning.vehicleStuckRescueContactHold = Mathf.Max(0.05f, modularPhysicsTuning.vehicleStuckRescueContactHold);
	}

	private float ComputeAverageWheelRadiusForTuning()
	{
		if (wheels == null || wheels.Count <= 0)
		{
			return 0.26f;
		}
		float num = 0f;
		int num2 = 0;
		for (int i = 0; i < wheels.Count; i++)
		{
			SummerRaceWheelDefConfig summerRaceWheelDefConfig = wheels[i];
			if (summerRaceWheelDefConfig != null)
			{
				num += Mathf.Max(0.05f, summerRaceWheelDefConfig.radius);
				num2++;
			}
		}
		if (num2 <= 0)
		{
			return 0.26f;
		}
		return num / (float)num2;
	}

	private void PopulateWheelModularPhysicsFromBodyStats()
	{
		if (wheels == null)
		{
			return;
		}
		for (int i = 0; i < wheels.Count; i++)
		{
			SummerRaceWheelDefConfig summerRaceWheelDefConfig = wheels[i];
			if (summerRaceWheelDefConfig != null)
			{
				float num = Mathf.Max(0.05f, summerRaceWheelDefConfig.radius);
				float num2 = Mathf.Clamp(380f + mass * 7.8f, 300f, 980f);
				summerRaceWheelDefConfig.width = Mathf.Clamp(num * 0.62f, 0.12f, 0.45f);
				summerRaceWheelDefConfig.moduleMass = Mathf.Clamp(mass * 0.042f, 0.5f, 3.8f);
				summerRaceWheelDefConfig.moduleCost = Mathf.Max(1, Mathf.RoundToInt(num * 10f));
				summerRaceWheelDefConfig.grip = Mathf.Clamp(tractionGain / 8.2f, 0.5f, 1.8f);
				summerRaceWheelDefConfig.suspensionLength = Mathf.Clamp(num * 0.85f, 0.12f, 0.45f);
				summerRaceWheelDefConfig.springStrength = num2;
				summerRaceWheelDefConfig.damping = Mathf.Clamp(num2 * 0.1f, 26f, 120f);
				summerRaceWheelDefConfig.maxMotorTorque = Mathf.Clamp(moveSpeed * mass * 7.2f, 260f, 1800f);
				summerRaceWheelDefConfig.maxAngularVelocity = Mathf.Clamp(moveSpeed / Mathf.Max(0.08f, num), 12f, 42f);
				summerRaceWheelDefConfig.rollingResistance = Mathf.Clamp(0.55f + drag * 0.5f, 0.35f, 1.4f);
				summerRaceWheelDefConfig.powered = true;
				summerRaceWheelDefConfig.steerable = false;
			}
		}
	}

	private void EnsureMountCount(SummerRaceMountSlotTypeConfig slotType, int targetCount, float xStart)
	{
		targetCount = Mathf.Max(0, targetCount);
		if (mountPoints == null)
		{
			mountPoints = new List<SummerRaceMountPointDefConfig>();
		}
		List<SummerRaceMountPointDefConfig> list = new List<SummerRaceMountPointDefConfig>();
		for (int i = 0; i < mountPoints.Count; i++)
		{
			if (mountPoints[i] != null && mountPoints[i].slotType == slotType)
			{
				list.Add(mountPoints[i]);
			}
		}
		while (list.Count > targetCount)
		{
			SummerRaceMountPointDefConfig item = list[list.Count - 1];
			mountPoints.Remove(item);
			list.RemoveAt(list.Count - 1);
		}
		while (list.Count < targetCount)
		{
			SummerRaceMountPointDefConfig item2 = new SummerRaceMountPointDefConfig
			{
				slotType = slotType,
				slotIndex = list.Count,
				localPosition = new Vector2(xStart - (float)list.Count * 0.28f, (slotType == SummerRaceMountSlotTypeConfig.Weapon) ? 0.16f : 0.22f),
				localAngle = 0f
			};
			mountPoints.Add(item2);
			list.Add(item2);
		}
		for (int j = 0; j < list.Count; j++)
		{
			list[j].slotIndex = j;
		}
	}
}
