using System;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

public static class SummerRaceRuntimeModuleFactory
{
	private const int RuntimeWeaponModuleSortingOrder = 37;

	private const int RuntimeUtilityModuleSortingOrder = 37;

	private const float RuntimeWheelSpringStrengthScale = 1.22f;

	private const float RuntimeWheelDampingScale = 1.3f;

	private const float RuntimeDynamicSupportSpringScale = 1.2f;

	private const float RuntimeDynamicSupportRollingDragScale = 1.25f;

	private const float RuntimeCollisionForceScale = 0.78f;

	public static void ReleaseBuild(SummerRaceRuntimeVehicleBuild build)
	{
		if (build == null)
		{
			return;
		}
		HashSet<ModuleDefinition> hashSet = new HashSet<ModuleDefinition>();
		CollectBindingModules(build.wheelBindings, hashSet);
		CollectBindingModules(build.weaponBindings, hashSet);
		CollectBindingModules(build.utilityBindings, hashSet);
		foreach (ModuleDefinition item in hashSet)
		{
			ReleaseRuntimeModule(item);
		}
		SafeDestroyObject(build.chassis);
		build.chassis = null;
		build.physicsTuning = null;
		build.wheelBindings.Clear();
		build.weaponBindings.Clear();
		build.utilityBindings.Clear();
	}

	public static SummerRaceRuntimeVehicleBuild CreateBuild(SummerRaceBodyType bodyType, IReadOnlyList<SummerRaceWeaponDefSO> weaponDefs, IReadOnlyList<SummerRaceEquipDefSO> equipDefs, float mountXSign, Func<SummerRaceMountPointDefConfig, float, Vector2> mountPositionResolver = null, IReadOnlyList<int> weaponSlotIndices = null, IReadOnlyList<int> equipSlotIndices = null)
	{
		SummerRaceBodyDefSO summerRaceBodyDefSO = SummerRaceConfigLoader.LoadBodyDef(bodyType);
		if (summerRaceBodyDefSO == null)
		{
			throw new InvalidOperationException("Missing body config: " + bodyType);
		}
		if (float.IsNaN(mountXSign) || float.IsInfinity(mountXSign) || Mathf.Abs(mountXSign) < 0.0001f)
		{
			throw new InvalidOperationException("Invalid mountXSign for runtime build: " + mountXSign);
		}
		float mountXSign2 = ((mountXSign < 0f) ? (-1f) : 1f);
		ValidateBodyData(summerRaceBodyDefSO);
		ValidateWeaponData(weaponDefs);
		ValidateEquipData(equipDefs);
		SummerRaceRuntimeVehicleBuild obj = new SummerRaceRuntimeVehicleBuild
		{
			chassis = CreateRuntimeChassis(summerRaceBodyDefSO, mountXSign2, mountPositionResolver),
			physicsTuning = CreateRuntimePhysicsTuning(summerRaceBodyDefSO)
		};
		AppendWheelModules(obj, summerRaceBodyDefSO);
		AppendWeaponModules(obj, weaponDefs, weaponSlotIndices, mountXSign2);
		AppendUtilityModules(obj, equipDefs, equipSlotIndices, mountXSign2);
		ValidateMountCoverage(obj);
		return obj;
	}

	private static void ValidateBodyData(SummerRaceBodyDefSO bodyDef)
	{
		if (!bodyDef.ValidateModularData(out var reason))
		{
			throw new InvalidOperationException("Invalid body modular data (" + bodyDef.name + "): " + reason);
		}
		if (bodyDef.mountPoints == null)
		{
			throw new InvalidOperationException("Body mountPoints is null: " + bodyDef.name);
		}
	}

	private static void ValidateWeaponData(IReadOnlyList<SummerRaceWeaponDefSO> weaponDefs)
	{
		if (weaponDefs == null)
		{
			return;
		}
		for (int i = 0; i < weaponDefs.Count; i++)
		{
			SummerRaceWeaponDefSO summerRaceWeaponDefSO = weaponDefs[i];
			if (summerRaceWeaponDefSO == null)
			{
				throw new InvalidOperationException("Weapon definition is null at slot " + i);
			}
			if (!summerRaceWeaponDefSO.ValidateModularData(out var reason))
			{
				throw new InvalidOperationException("Invalid weapon modular data (" + summerRaceWeaponDefSO.name + "): " + reason);
			}
		}
	}

	private static void ValidateEquipData(IReadOnlyList<SummerRaceEquipDefSO> equipDefs)
	{
		if (equipDefs == null)
		{
			return;
		}
		for (int i = 0; i < equipDefs.Count; i++)
		{
			SummerRaceEquipDefSO summerRaceEquipDefSO = equipDefs[i];
			if (summerRaceEquipDefSO == null)
			{
				throw new InvalidOperationException("Equip definition is null at slot " + i);
			}
			if (!summerRaceEquipDefSO.ValidateModularData(out var reason))
			{
				throw new InvalidOperationException("Invalid equip modular data (" + summerRaceEquipDefSO.name + "): " + reason);
			}
		}
	}

	private static ChassisDefinition CreateRuntimeChassis(SummerRaceBodyDefSO bodyDef, float mountXSign, Func<SummerRaceMountPointDefConfig, float, Vector2> mountPositionResolver)
	{
		ChassisDefinition chassisDefinition = ScriptableObject.CreateInstance<ChassisDefinition>();
		chassisDefinition.name = "RuntimeChassis_" + bodyDef.name;
		chassisDefinition.summerRaceBodyDef = bodyDef;
		chassisDefinition.baseMass = bodyDef.mass;
		chassisDefinition.baseCenterOfMassOffset = bodyDef.centerOfMassOffset;
		chassisDefinition.baseDrag = bodyDef.drag;
		chassisDefinition.baseAngularDrag = bodyDef.angularDrag;
		chassisDefinition.stabilityAssist = bodyDef.modularStabilityAssist;
		chassisDefinition.chassisClearance = bodyDef.modularChassisClearance;
		chassisDefinition.mountPointTemplates = new List<ChassisDefinition.MountPointTemplate>(16);
		for (int i = 0; i < bodyDef.wheels.Count; i++)
		{
			SummerRaceWheelDefConfig summerRaceWheelDefConfig = bodyDef.wheels[i];
			string localId = BuildWheelMountId(summerRaceWheelDefConfig);
			float num = ResolveRuntimeWheelRadius(summerRaceWheelDefConfig);
			Vector2 vector = new Vector2(summerRaceWheelDefConfig.width, num * 2f);
			chassisDefinition.mountPointTemplates.Add(new ChassisDefinition.MountPointTemplate
			{
				localId = localId,
				mountType = VehicleMountType.Wheel,
				localPosition = MirrorLocalPosition(summerRaceWheelDefConfig.localPosition, mountXSign),
				localRotation = MirrorLocalAngle(0f, mountXSign),
				sizeLimitMin = vector,
				sizeLimitMax = vector,
				allowedTags = Array.Empty<string>(),
				isMirroredPair = false
			});
		}
		for (int j = 0; j < bodyDef.mountPoints.Count; j++)
		{
			SummerRaceMountPointDefConfig summerRaceMountPointDefConfig = bodyDef.mountPoints[j];
			bool flag = summerRaceMountPointDefConfig.slotType == SummerRaceMountSlotTypeConfig.Weapon;
			chassisDefinition.mountPointTemplates.Add(new ChassisDefinition.MountPointTemplate
			{
				localId = (flag ? BuildWeaponMountId(summerRaceMountPointDefConfig.slotIndex) : BuildUtilityMountId(summerRaceMountPointDefConfig.slotIndex)),
				mountType = (flag ? VehicleMountType.Weapon : VehicleMountType.Utility),
				localPosition = ResolveMountLocalPosition(summerRaceMountPointDefConfig, mountXSign, mountPositionResolver),
				localRotation = MirrorLocalAngle(summerRaceMountPointDefConfig.localAngle, mountXSign),
				sizeLimitMin = new Vector2(0.01f, 0.01f),
				sizeLimitMax = new Vector2(10f, 10f),
				allowedTags = Array.Empty<string>(),
				isMirroredPair = false
			});
		}
		return chassisDefinition;
	}

	private static Vector2 ResolveMountLocalPosition(SummerRaceMountPointDefConfig mount, float mountXSign, Func<SummerRaceMountPointDefConfig, float, Vector2> mountPositionResolver)
	{
		return mountPositionResolver?.Invoke(mount, mountXSign) ?? MirrorLocalPosition(mount.localPosition, mountXSign);
	}

	private static SummerRaceRuntimePhysicsTuningData CreateRuntimePhysicsTuning(SummerRaceBodyDefSO bodyDef)
	{
		SummerRaceModularPhysicsTuningConfig modularPhysicsTuning = bodyDef.modularPhysicsTuning;
		if (modularPhysicsTuning == null)
		{
			throw new InvalidOperationException("Body modularPhysicsTuning is null: " + bodyDef.name);
		}
		float num = Mathf.Max(1f, bodyDef.mass);
		float num2 = Mathf.InverseLerp(26f, 52f, num);
		float value = ComputeAverageWheelRadius(bodyDef);
		float num3 = Mathf.InverseLerp(0.22f, 0.34f, value);
		float t = Mathf.Clamp01((1f - num2) * 0.75f + (1f - num3) * 0.25f);
		return new SummerRaceRuntimePhysicsTuningData
		{
			useContactProbe = modularPhysicsTuning.useContactProbe,
			suspensionProbeExtra = modularPhysicsTuning.suspensionProbeExtra,
			maxContactPerWheel = modularPhysicsTuning.maxContactPerWheel,
			exaggerateBuildDifference = modularPhysicsTuning.exaggerateBuildDifference,
			massDistributionAmplify = Mathf.Lerp(1.05f, 1.18f, num2),
			recoilAmplify = Mathf.Lerp(2.2f, 1.7f, num2),
			centerOfMassOffsetAmplify = Vector2.one,
			wheelAsymmetryYawAmplify = Mathf.Lerp(16f, 8f, num2),
			comBiasYawAmplify = 0f,
			recoilMassReference = num,
			driveForceAmplify = Mathf.Lerp(1.16f, 1.02f, num2),
			tractionAmplify = Mathf.Lerp(1.12f, 1f, num2),
			driveLoadTransferStrength = modularPhysicsTuning.driveLoadTransferStrength,
			dynamicSupportDriveScale = modularPhysicsTuning.dynamicSupportDriveScale,
			dynamicSupportRollingDragScale = Mathf.Clamp01(modularPhysicsTuning.dynamicSupportRollingDragScale * 1.25f),
			dynamicSupportSpringScale = Mathf.Clamp(modularPhysicsTuning.dynamicSupportSpringScale * 1.2f, 0.2f, 1f),
			steerTorque = Mathf.Lerp(24f, 18f, num2) * Mathf.Lerp(0.95f, 1.05f, t),
			speedClampMultiplier = Mathf.Lerp(1.18f, 1.03f, num2),
			slipToForceGain = Mathf.Lerp(10f, 7f, num2),
			maxAngularSpeedDegPerSec = Mathf.Lerp(460f, 360f, num2),
			uprightAssistDamping = Mathf.Lerp(1f, 1.6f, num2),
			minUprightAssist = Mathf.Lerp(1.6f, 2.4f, num2),
			maxUprightAssist = Mathf.Lerp(16f, 11f, num2),
			collisionForceScale = Mathf.Max(0f, modularPhysicsTuning.collisionForceScale * 0.78f),
			flipRescueForwardForcePerMass = Mathf.Max(0.01f, modularPhysicsTuning.flipRescueForwardForcePerMass),
			flipRescueForceLiftOffset = Mathf.Clamp(modularPhysicsTuning.flipRescueForceLiftOffset, 0f, 2f),
			wallStuckRescueDelay = Mathf.Max(0.05f, modularPhysicsTuning.wallStuckRescueDelay),
			wallStuckRescueMinNormalX = Mathf.Clamp(modularPhysicsTuning.wallStuckRescueMinNormalX, 0.1f, 1f),
			wallStuckRescueMaxSpeed = Mathf.Max(0f, modularPhysicsTuning.wallStuckRescueMaxSpeed),
			wallStuckRescueMinEscapeSpeed = Mathf.Max(0f, modularPhysicsTuning.wallStuckRescueMinEscapeSpeed),
			wallStuckRescueCooldown = Mathf.Max(0.05f, modularPhysicsTuning.wallStuckRescueCooldown),
			wallStuckRescueTorque = Mathf.Max(0f, modularPhysicsTuning.wallStuckRescueTorque),
			wallStuckRescueForcePerMass = Mathf.Max(0f, modularPhysicsTuning.wallStuckRescueForcePerMass),
			wallStuckRescueForceDuration = Mathf.Max(0.05f, modularPhysicsTuning.wallStuckRescueForceDuration),
			vehicleStuckRescueMinThrottle = Mathf.Clamp01(modularPhysicsTuning.vehicleStuckRescueMinThrottle),
			vehicleStuckRescueMinContactDot = Mathf.Clamp01(modularPhysicsTuning.vehicleStuckRescueMinContactDot),
			vehicleStuckRescueContactHold = Mathf.Max(0.05f, modularPhysicsTuning.vehicleStuckRescueContactHold)
		};
	}

	private static float ComputeAverageWheelRadius(SummerRaceBodyDefSO bodyDef)
	{
		if (bodyDef == null || bodyDef.wheels == null || bodyDef.wheels.Count == 0)
		{
			return 0.26f;
		}
		float num = 0f;
		int num2 = 0;
		for (int i = 0; i < bodyDef.wheels.Count; i++)
		{
			SummerRaceWheelDefConfig summerRaceWheelDefConfig = bodyDef.wheels[i];
			if (summerRaceWheelDefConfig != null)
			{
				num += ResolveRuntimeWheelRadius(summerRaceWheelDefConfig);
				num2++;
			}
		}
		if (num2 <= 0)
		{
			return 0.26f;
		}
		return num / (float)num2;
	}

	private static void AppendWheelModules(SummerRaceRuntimeVehicleBuild build, SummerRaceBodyDefSO bodyDef)
	{
		for (int i = 0; i < bodyDef.wheels.Count; i++)
		{
			SummerRaceWheelDefConfig summerRaceWheelDefConfig = bodyDef.wheels[i];
			float num = ResolveRuntimeWheelRadius(summerRaceWheelDefConfig);
			WheelModuleDefinition wheelModuleDefinition = ScriptableObject.CreateInstance<WheelModuleDefinition>();
			wheelModuleDefinition.name = "RuntimeWheel_" + summerRaceWheelDefConfig.name;
			wheelModuleDefinition.moduleId = "runtime_wheel_" + summerRaceWheelDefConfig.name;
			wheelModuleDefinition.displayName = summerRaceWheelDefConfig.name;
			wheelModuleDefinition.size = new Vector2(summerRaceWheelDefConfig.width, num * 2f);
			wheelModuleDefinition.mass = summerRaceWheelDefConfig.moduleMass;
			wheelModuleDefinition.cost = summerRaceWheelDefConfig.moduleCost;
			wheelModuleDefinition.radius = num;
			wheelModuleDefinition.width = summerRaceWheelDefConfig.width;
			wheelModuleDefinition.grip = summerRaceWheelDefConfig.grip;
			wheelModuleDefinition.suspensionLength = summerRaceWheelDefConfig.suspensionLength;
			wheelModuleDefinition.springStrength = Mathf.Max(1f, summerRaceWheelDefConfig.springStrength * 1.22f);
			wheelModuleDefinition.damping = Mathf.Max(1f, summerRaceWheelDefConfig.damping * 1.3f);
			wheelModuleDefinition.maxMotorTorque = summerRaceWheelDefConfig.maxMotorTorque;
			wheelModuleDefinition.maxAngularVelocity = summerRaceWheelDefConfig.maxAngularVelocity;
			wheelModuleDefinition.rollingResistance = summerRaceWheelDefConfig.rollingResistance;
			wheelModuleDefinition.powered = summerRaceWheelDefConfig.powered;
			wheelModuleDefinition.steerable = summerRaceWheelDefConfig.steerable;
			wheelModuleDefinition.wheelName = summerRaceWheelDefConfig.name;
			build.wheelBindings.Add(new SummerRaceRuntimeVehicleBuild.MountModuleBinding
			{
				mountId = BuildWheelMountId(summerRaceWheelDefConfig),
				module = wheelModuleDefinition
			});
		}
	}

	private static float ResolveRuntimeWheelRadius(SummerRaceWheelDefConfig wheel)
	{
		if (wheel == null)
		{
			return 0.05f;
		}
		float num = Mathf.Max(0.05f, wheel.radius);
		float num2 = Mathf.Max(0.01f, wheel.wheelVisualScale);
		return num * num2;
	}

	private static void AppendWeaponModules(SummerRaceRuntimeVehicleBuild build, IReadOnlyList<SummerRaceWeaponDefSO> weaponDefs, IReadOnlyList<int> weaponSlotIndices, float mountXSign)
	{
		if (weaponDefs != null)
		{
			for (int i = 0; i < weaponDefs.Count; i++)
			{
				SummerRaceWeaponDefSO summerRaceWeaponDefSO = weaponDefs[i];
				WeaponModuleDefinition weaponModuleDefinition = ScriptableObject.CreateInstance<WeaponModuleDefinition>();
				weaponModuleDefinition.name = "RuntimeWeapon_" + i;
				weaponModuleDefinition.moduleId = "runtime_weapon_" + i;
				weaponModuleDefinition.displayName = (string.IsNullOrEmpty(summerRaceWeaponDefSO.displayName) ? summerRaceWeaponDefSO.weaponType.ToString() : summerRaceWeaponDefSO.displayName);
				weaponModuleDefinition.summerRaceWeaponDef = summerRaceWeaponDefSO;
				weaponModuleDefinition.size = summerRaceWeaponDefSO.modularModuleSize;
				weaponModuleDefinition.mass = summerRaceWeaponDefSO.loadWeight;
				weaponModuleDefinition.cost = summerRaceWeaponDefSO.cost;
				weaponModuleDefinition.tags = new string[1] { summerRaceWeaponDefSO.weaponType.ToString() };
				int slotIndex = ResolveModuleMountSlotIndex(weaponSlotIndices, i, "weapon");
				string text = BuildWeaponMountId(slotIndex);
				weaponModuleDefinition.visualPrefab = CreateSpineModuleVisualPrefabOrThrow(summerRaceWeaponDefSO.modularSpineSkeletonDataPath, summerRaceWeaponDefSO.modularSpineLocalOffset, summerRaceWeaponDefSO.modularSpineLocalAngle, summerRaceWeaponDefSO.modularModuleSize, summerRaceWeaponDefSO.modularSpineScale, summerRaceWeaponDefSO.emitterIdleAnimName, mountXSign, 37, "weapon asset=" + summerRaceWeaponDefSO.name + " slot=" + i + " mountSlotIndex=" + slotIndex + " mountId=" + text);
				build.weaponBindings.Add(new SummerRaceRuntimeVehicleBuild.MountModuleBinding
				{
					mountId = text,
					module = weaponModuleDefinition
				});
			}
		}
	}

	private static void AppendUtilityModules(SummerRaceRuntimeVehicleBuild build, IReadOnlyList<SummerRaceEquipDefSO> equipDefs, IReadOnlyList<int> equipSlotIndices, float mountXSign)
	{
		if (equipDefs != null)
		{
			for (int i = 0; i < equipDefs.Count; i++)
			{
				SummerRaceEquipDefSO summerRaceEquipDefSO = equipDefs[i];
				UtilityModuleDefinition utilityModuleDefinition = ScriptableObject.CreateInstance<UtilityModuleDefinition>();
				utilityModuleDefinition.name = "RuntimeUtility_" + i;
				utilityModuleDefinition.moduleId = "runtime_utility_" + i;
				utilityModuleDefinition.displayName = (string.IsNullOrEmpty(summerRaceEquipDefSO.displayName) ? summerRaceEquipDefSO.equipType.ToString() : summerRaceEquipDefSO.displayName);
				utilityModuleDefinition.summerRaceEquipDef = summerRaceEquipDefSO;
				utilityModuleDefinition.size = summerRaceEquipDefSO.modularModuleSize;
				utilityModuleDefinition.mass = summerRaceEquipDefSO.loadWeight;
				utilityModuleDefinition.cost = summerRaceEquipDefSO.cost;
				int slotIndex = ResolveModuleMountSlotIndex(equipSlotIndices, i, "equip");
				string text = BuildUtilityMountId(slotIndex);
				utilityModuleDefinition.visualPrefab = CreateSpineModuleVisualPrefabOrThrow(summerRaceEquipDefSO.modularSpineSkeletonDataPath, summerRaceEquipDefSO.modularSpineLocalOffset, summerRaceEquipDefSO.modularSpineLocalAngle, summerRaceEquipDefSO.modularModuleSize, summerRaceEquipDefSO.modularSpineScale, summerRaceEquipDefSO.emitterIdleAnimName, mountXSign, 37, "equip asset=" + summerRaceEquipDefSO.name + " slot=" + i + " mountSlotIndex=" + slotIndex + " mountId=" + text);
				build.utilityBindings.Add(new SummerRaceRuntimeVehicleBuild.MountModuleBinding
				{
					mountId = text,
					module = utilityModuleDefinition
				});
			}
		}
	}

	private static int ResolveModuleMountSlotIndex(IReadOnlyList<int> slotIndices, int moduleIndex, string slotTypeLabel)
	{
		if (slotIndices == null || slotIndices.Count == 0)
		{
			return moduleIndex;
		}
		if (moduleIndex >= slotIndices.Count)
		{
			throw new InvalidOperationException("Missing " + slotTypeLabel + " mount slot index for module index " + moduleIndex + ". slotIndices=" + slotIndices.Count);
		}
		int num = slotIndices[moduleIndex];
		if (num < 0)
		{
			throw new InvalidOperationException("Invalid " + slotTypeLabel + " mount slot index: " + num + " moduleIndex=" + moduleIndex);
		}
		return num;
	}

	private static GameObject CreateSpineModuleVisualPrefabOrThrow(string skeletonDataPath, Vector2 localOffset, float localAngle, Vector2 moduleSize, float scale, string idleAnimationName, float mountXSign, int sortingOrder, string context)
	{
		SkeletonDataAsset skeletonDataAsset = SummerRaceConfigLoader.LoadSkeletonDataAssetOrThrow(skeletonDataPath, context + " field=modularSpineSkeletonDataPath");
		Vector2 vector;
		if (!IsPositive(moduleSize.x) || !IsPositive(moduleSize.y))
		{
			vector = moduleSize;
			throw new InvalidOperationException("Invalid modular moduleSize for " + context + ": " + vector.ToString());
		}
		float num = Mathf.Max(0.01f, scale);
		GameObject gameObject = new GameObject("RuntimeModuleVisualRoot");
		GameObject gameObject2 = new GameObject("Visual");
		gameObject.hideFlags = HideFlags.DontSave;
		gameObject2.hideFlags = HideFlags.DontSave;
		gameObject2.transform.SetParent(gameObject.transform, worldPositionStays: false);
		Vector2 vector2 = MirrorLocalPosition(localOffset, mountXSign);
		float num2 = MirrorLocalAngle(localAngle, mountXSign);
		gameObject2.transform.localPosition = new Vector3(vector2.x, vector2.y, 0f);
		gameObject2.transform.localRotation = Quaternion.Euler(0f, 0f, num2);
		gameObject2.transform.localScale = Vector3.one;
		SkeletonAnimation skeletonAnimation = gameObject2.AddComponent<SkeletonAnimation>();
		skeletonAnimation.skeletonDataAsset = skeletonDataAsset;
		skeletonAnimation.Initialize(overwrite: true);
		if (string.IsNullOrWhiteSpace(idleAnimationName))
		{
			throw new InvalidOperationException("Missing emitter idle animation contract for " + context);
		}
		if (IsNoneAnimationToken(idleAnimationName))
		{
			skeletonAnimation.AnimationState.ClearTracks();
			skeletonAnimation.Skeleton.SetToSetupPose();
			skeletonAnimation.AnimationState.Apply(skeletonAnimation.Skeleton);
		}
		else
		{
			Spine.Animation animation = ((skeletonAnimation.Skeleton != null && skeletonAnimation.Skeleton.Data != null) ? skeletonAnimation.Skeleton.Data.FindAnimation(idleAnimationName) : null);
			if (animation == null)
			{
				throw new InvalidOperationException("Missing emitter idle animation '" + idleAnimationName + "' for " + context);
			}
			skeletonAnimation.AnimationState.SetAnimation(0, animation.Name, loop: true);
		}
		MeshRenderer component = skeletonAnimation.GetComponent<MeshRenderer>();
		if (component == null)
		{
			throw new InvalidOperationException("Missing MeshRenderer on runtime module visual. context=" + context);
		}
		Bounds bounds = component.bounds;
		Vector3 size = bounds.size;
		if (!IsPositive(size.x) || !IsPositive(size.y))
		{
			Vector3 vector3 = size;
			throw new InvalidOperationException("Invalid module skeleton bounds for " + context + " size=" + vector3.ToString());
		}
		float num3 = Mathf.Min(moduleSize.x / size.x, moduleSize.y / size.y);
		if (!IsPositive(num3))
		{
			string[] obj = new string[6] { "Invalid module fit scale for ", context, " moduleSize=", null, null, null };
			vector = moduleSize;
			obj[3] = vector.ToString();
			obj[4] = " boundsSize=";
			Vector3 vector3 = size;
			obj[5] = vector3.ToString();
			throw new InvalidOperationException(string.Concat(obj));
		}
		Vector3 vector4 = gameObject2.transform.InverseTransformPoint(bounds.center);
		float num4 = Mathf.Max(0.01f, num3 * num);
		gameObject2.transform.localScale = new Vector3(num4, num4, 1f);
		Vector2 vector5 = Rotate(vector4, num2);
		gameObject2.transform.localPosition = new Vector3(vector2.x, vector2.y, 0f);
		string[] array = new string[30];
		array[0] = "[SummerRace][ModuleVisual] context=";
		array[1] = context;
		array[2] = " moduleSize=";
		vector = moduleSize;
		array[3] = vector.ToString();
		array[4] = " boundsSize=(";
		array[5] = size.x.ToString("F3");
		array[6] = ",";
		array[7] = size.y.ToString("F3");
		array[8] = ") boundsCenterLocal=(";
		array[9] = vector4.x.ToString("F3");
		array[10] = ",";
		array[11] = vector4.y.ToString("F3");
		array[12] = ") rotatedCenterOffset=(";
		array[13] = vector5.x.ToString("F3");
		array[14] = ",";
		array[15] = vector5.y.ToString("F3");
		array[16] = ") anchorLocalOffset=(";
		array[17] = vector2.x.ToString("F3");
		array[18] = ",";
		array[19] = vector2.y.ToString("F3");
		array[20] = ") localPosition=(";
		array[21] = gameObject2.transform.localPosition.x.ToString("F3");
		array[22] = ",";
		array[23] = gameObject2.transform.localPosition.y.ToString("F3");
		array[24] = ") fitScale=";
		array[25] = num3.ToString("F3");
		array[26] = " configuredScale=";
		array[27] = num.ToString("F3");
		array[28] = " resolvedScale=";
		array[29] = num4.ToString("F3");
		SummerRaceRuntimeLog.Log(string.Concat(array));
		component.sortingOrder = sortingOrder;
		component.enabled = true;
		gameObject.SetActive(value: false);
		return gameObject;
	}

	private static bool IsNoneAnimationToken(string animationName)
	{
		if (!string.IsNullOrWhiteSpace(animationName))
		{
			return string.Equals(animationName.Trim(), "none", StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	private static Vector2 MirrorLocalPosition(Vector2 localPosition, float mountXSign)
	{
		if (!(mountXSign >= 0f))
		{
			return new Vector2(0f - localPosition.x, localPosition.y);
		}
		return localPosition;
	}

	private static Vector2 Rotate(Vector2 value, float angleDegrees)
	{
		float f = angleDegrees * (MathF.PI / 180f);
		float num = Mathf.Cos(f);
		float num2 = Mathf.Sin(f);
		return new Vector2(value.x * num - value.y * num2, value.x * num2 + value.y * num);
	}

	private static float MirrorLocalAngle(float localAngle, float mountXSign)
	{
		if (!(mountXSign >= 0f))
		{
			return 0f - localAngle;
		}
		return localAngle;
	}

	private static bool IsPositive(float value)
	{
		if (!float.IsNaN(value) && !float.IsInfinity(value))
		{
			return value > 0.0001f;
		}
		return false;
	}

	private static void ValidateMountCoverage(SummerRaceRuntimeVehicleBuild build)
	{
		HashSet<string> hashSet = new HashSet<string>();
		for (int i = 0; i < build.chassis.mountPointTemplates.Count; i++)
		{
			hashSet.Add(build.chassis.mountPointTemplates[i].localId);
		}
		ValidateBindings(build.wheelBindings, hashSet, "wheel");
		ValidateBindings(build.weaponBindings, hashSet, "weapon");
		ValidateBindings(build.utilityBindings, hashSet, "utility");
	}

	private static void ValidateBindings(List<SummerRaceRuntimeVehicleBuild.MountModuleBinding> bindings, HashSet<string> mountIds, string bindingType)
	{
		HashSet<string> hashSet = new HashSet<string>();
		for (int i = 0; i < bindings.Count; i++)
		{
			SummerRaceRuntimeVehicleBuild.MountModuleBinding mountModuleBinding = bindings[i];
			if (mountModuleBinding == null || string.IsNullOrEmpty(mountModuleBinding.mountId) || mountModuleBinding.module == null)
			{
				throw new InvalidOperationException("Invalid " + bindingType + " binding at index " + i);
			}
			if (!mountIds.Contains(mountModuleBinding.mountId))
			{
				throw new InvalidOperationException("Missing mount template for " + bindingType + ": " + mountModuleBinding.mountId);
			}
			if (!hashSet.Add(mountModuleBinding.mountId))
			{
				throw new InvalidOperationException("Duplicate " + bindingType + " binding mount id: " + mountModuleBinding.mountId);
			}
		}
	}

	private static void CollectBindingModules(List<SummerRaceRuntimeVehicleBuild.MountModuleBinding> bindings, HashSet<ModuleDefinition> output)
	{
		if (bindings == null || output == null)
		{
			return;
		}
		for (int i = 0; i < bindings.Count; i++)
		{
			SummerRaceRuntimeVehicleBuild.MountModuleBinding mountModuleBinding = bindings[i];
			if (mountModuleBinding != null && !(mountModuleBinding.module == null))
			{
				output.Add(mountModuleBinding.module);
			}
		}
	}

	private static void ReleaseRuntimeModule(ModuleDefinition module)
	{
		if (!(module == null))
		{
			if (module.visualPrefab != null)
			{
				SafeDestroyObject(module.visualPrefab);
				module.visualPrefab = null;
			}
			SafeDestroyObject(module);
		}
	}

	private static void SafeDestroyObject(UnityEngine.Object obj)
	{
		if (!(obj == null))
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(obj);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(obj);
			}
		}
	}

	private static string BuildWheelMountId(SummerRaceWheelDefConfig wheel)
	{
		if (wheel == null || string.IsNullOrWhiteSpace(wheel.name))
		{
			throw new InvalidOperationException("Wheel name is empty.");
		}
		return "Wheel_" + wheel.name;
	}

	private static string BuildWeaponMountId(int slotIndex)
	{
		if (slotIndex < 0)
		{
			throw new InvalidOperationException("Invalid weapon slot index: " + slotIndex);
		}
		return "Weapon_" + slotIndex;
	}

	private static string BuildUtilityMountId(int slotIndex)
	{
		if (slotIndex < 0)
		{
			throw new InvalidOperationException("Invalid equip slot index: " + slotIndex);
		}
		return "Equip_" + slotIndex;
	}
}
