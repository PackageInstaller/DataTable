using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/ModularVehicle/Chassis Definition", fileName = "ChassisDefinition")]
public class ChassisDefinition : ScriptableObject
{
	[Serializable]
	public struct MountPointTemplate
	{
		public string localId;

		public VehicleMountType mountType;

		public Vector2 localPosition;

		public float localRotation;

		public Vector2 sizeLimitMin;

		public Vector2 sizeLimitMax;

		public string[] allowedTags;

		public bool isMirroredPair;
	}

	[Header("SummerRace Reference")]
	public SummerRaceBodyDefSO summerRaceBodyDef;

	[Header("Base Physics")]
	[Min(0.01f)]
	public float baseMass = 45f;

	public Vector2 baseCenterOfMassOffset = new Vector2(0f, -0.1f);

	[Min(0f)]
	public float baseDrag = 0.3f;

	[Min(0f)]
	public float baseAngularDrag = 1.2f;

	[Min(0f)]
	public float chassisClearance = 0.15f;

	[Min(0f)]
	public float stabilityAssist = 8f;

	[Header("Mount Template (Optional)")]
	public List<MountPointTemplate> mountPointTemplates = new List<MountPointTemplate>();

	public SummerRaceBodyTypeConfig BodyType => RequireBodyDef("BodyType").bodyType;

	public string DisplayName
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("DisplayName");
			RequireNonEmpty(summerRaceBodyDefSO.displayName, "displayName", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.displayName;
		}
	}

	public int CostCap
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("CostCap");
			if (summerRaceBodyDefSO.costCap < 0)
			{
				throw new InvalidOperationException("[ChassisDefinition] Invalid costCap on " + summerRaceBodyDefSO.name);
			}
			return summerRaceBodyDefSO.costCap;
		}
	}

	public int WeaponSlots
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("WeaponSlots");
			if (summerRaceBodyDefSO.weaponSlots < 0)
			{
				throw new InvalidOperationException("[ChassisDefinition] Invalid weaponSlots on " + summerRaceBodyDefSO.name);
			}
			return summerRaceBodyDefSO.weaponSlots;
		}
	}

	public int EquipSlots
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("EquipSlots");
			if (summerRaceBodyDefSO.equipSlots < 0)
			{
				throw new InvalidOperationException("[ChassisDefinition] Invalid equipSlots on " + summerRaceBodyDefSO.name);
			}
			return summerRaceBodyDefSO.equipSlots;
		}
	}

	public float BaseHp
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("BaseHp");
			RequireRange(summerRaceBodyDefSO.baseHp, 1f, "baseHp", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.baseHp;
		}
	}

	public float MoveSpeed
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("MoveSpeed");
			RequireRange(summerRaceBodyDefSO.moveSpeed, 0.01f, "moveSpeed", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.moveSpeed;
		}
	}

	public float GravityScale
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("GravityScale");
			RequireRange(summerRaceBodyDefSO.gravityScale, 0f, "gravityScale", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.gravityScale;
		}
	}

	public float TractionGain
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("TractionGain");
			RequireRange(summerRaceBodyDefSO.tractionGain, 0f, "tractionGain", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.tractionGain;
		}
	}

	public float CollisionImpulseScale
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("CollisionImpulseScale");
			RequireRange(summerRaceBodyDefSO.collisionImpulseScale, 0f, "collisionImpulseScale", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.collisionImpulseScale;
		}
	}

	public float LaneSpring
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("LaneSpring");
			RequireRange(summerRaceBodyDefSO.laneSpring, 0f, "laneSpring", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.laneSpring;
		}
	}

	public float LaneDamping
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("LaneDamping");
			RequireRange(summerRaceBodyDefSO.laneDamping, 0f, "laneDamping", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.laneDamping;
		}
	}

	public Color BodyColor => RequireBodyDef("BodyColor").bodyColor;

	public Vector3 BodyScale => RequireBodyDef("BodyScale").bodyScale;

	public List<Vector2> ColliderPoints
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("ColliderPoints");
			if (summerRaceBodyDefSO.colliderPoints == null || summerRaceBodyDefSO.colliderPoints.Count < 3)
			{
				throw new InvalidOperationException("[ChassisDefinition] Invalid collider points on " + summerRaceBodyDefSO.name);
			}
			return summerRaceBodyDefSO.colliderPoints;
		}
	}

	public float BaseMassValue
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("BaseMassValue");
			RequireRange(summerRaceBodyDefSO.mass, 0.01f, "mass", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.mass;
		}
	}

	public Vector2 BaseCenterOfMassOffsetValue => RequireBodyDef("BaseCenterOfMassOffsetValue").centerOfMassOffset;

	public float BaseDragValue
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("BaseDragValue");
			RequireRange(summerRaceBodyDefSO.drag, 0f, "drag", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.drag;
		}
	}

	public float BaseAngularDragValue
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("BaseAngularDragValue");
			RequireRange(summerRaceBodyDefSO.angularDrag, 0f, "angularDrag", summerRaceBodyDefSO.name);
			return summerRaceBodyDefSO.angularDrag;
		}
	}

	public List<SummerRaceWheelDefConfig> Wheels
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("Wheels");
			if (summerRaceBodyDefSO.wheels == null || summerRaceBodyDefSO.wheels.Count == 0)
			{
				throw new InvalidOperationException("[ChassisDefinition] Missing wheels on " + summerRaceBodyDefSO.name);
			}
			return summerRaceBodyDefSO.wheels;
		}
	}

	public List<SummerRaceMountPointDefConfig> MountPoints
	{
		get
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = RequireBodyDef("MountPoints");
			if (summerRaceBodyDefSO.mountPoints == null)
			{
				throw new InvalidOperationException("[ChassisDefinition] Missing mount points on " + summerRaceBodyDefSO.name);
			}
			return summerRaceBodyDefSO.mountPoints;
		}
	}

	private SummerRaceBodyDefSO RequireBodyDef(string member)
	{
		if (summerRaceBodyDef == null)
		{
			throw new InvalidOperationException("[ChassisDefinition] Missing SummerRaceBodyDefSO for " + base.name + " (" + member + ").");
		}
		return summerRaceBodyDef;
	}

	private static void RequireNonEmpty(string value, string fieldName, string assetName)
	{
		if (string.IsNullOrWhiteSpace(value))
		{
			throw new InvalidOperationException("[ChassisDefinition] Missing " + fieldName + " on " + assetName);
		}
	}

	private static void RequireRange(float value, float min, string fieldName, string assetName)
	{
		if (value < min)
		{
			throw new InvalidOperationException("[ChassisDefinition] Invalid " + fieldName + "=" + value + " on " + assetName);
		}
	}

	public Vector2[] GetColliderPointsOrFallback()
	{
		return ColliderPoints.ToArray();
	}

	private void OnValidate()
	{
		if (summerRaceBodyDef != null)
		{
			baseMass = summerRaceBodyDef.mass;
			baseCenterOfMassOffset = summerRaceBodyDef.centerOfMassOffset;
			baseDrag = summerRaceBodyDef.drag;
			baseAngularDrag = summerRaceBodyDef.angularDrag;
			SyncMountPointTemplatesFromSummerRace();
		}
	}

	private void SyncMountPointTemplatesFromSummerRace()
	{
		if (summerRaceBodyDef == null)
		{
			return;
		}
		mountPointTemplates.Clear();
		if (summerRaceBodyDef.wheels != null)
		{
			for (int i = 0; i < summerRaceBodyDef.wheels.Count; i++)
			{
				SummerRaceWheelDefConfig summerRaceWheelDefConfig = summerRaceBodyDef.wheels[i];
				mountPointTemplates.Add(new MountPointTemplate
				{
					localId = "Wheel_" + (string.IsNullOrEmpty(summerRaceWheelDefConfig.name) ? i.ToString() : summerRaceWheelDefConfig.name),
					mountType = VehicleMountType.Wheel,
					localPosition = summerRaceWheelDefConfig.localPosition,
					localRotation = 0f,
					sizeLimitMin = Vector2.zero,
					sizeLimitMax = new Vector2(summerRaceWheelDefConfig.radius * 2f, summerRaceWheelDefConfig.radius * 2f),
					allowedTags = Array.Empty<string>(),
					isMirroredPair = false
				});
			}
		}
		if (summerRaceBodyDef.mountPoints != null)
		{
			for (int j = 0; j < summerRaceBodyDef.mountPoints.Count; j++)
			{
				SummerRaceMountPointDefConfig summerRaceMountPointDefConfig = summerRaceBodyDef.mountPoints[j];
				mountPointTemplates.Add(new MountPointTemplate
				{
					localId = ((summerRaceMountPointDefConfig.slotType == SummerRaceMountSlotTypeConfig.Weapon) ? "Weapon_" : "Equip_") + summerRaceMountPointDefConfig.slotIndex,
					mountType = ((summerRaceMountPointDefConfig.slotType == SummerRaceMountSlotTypeConfig.Weapon) ? VehicleMountType.Weapon : VehicleMountType.Utility),
					localPosition = summerRaceMountPointDefConfig.localPosition,
					localRotation = summerRaceMountPointDefConfig.localAngle,
					sizeLimitMin = Vector2.zero,
					sizeLimitMax = new Vector2(2f, 2f),
					allowedTags = Array.Empty<string>(),
					isMirroredPair = false
				});
			}
		}
	}
}
