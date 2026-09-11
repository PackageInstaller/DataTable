using System;
using UnityEngine;

[Serializable]
public sealed class SummerRaceActivityBodySourceRecord
{
	public SummerRaceBodyTypeConfig BodyType = SummerRaceBodyTypeConfig.Medium;

	public string DisplayName = string.Empty;

	public int CostCap;

	public int WeaponSlots;

	public int EquipSlots;

	public float MaxHp;

	public float CruiseSpeed;

	public float ForwardAcceleration;

	public float Mass;

	public float Drag;

	public float AngularDrag;

	public float GravityScale;

	public float TractionGain;

	public float CollisionImpulseScale;

	public float LaneSpring;

	public float LaneDamping;

	public Vector2 CenterOfMassOffset;

	public Color BodyColor = Color.white;

	public Vector3 BodyScale = Vector3.one;

	public Vector2[] ColliderPoints = Array.Empty<Vector2>();

	public SummerRaceActivityWheelSourceRecord[] Wheels = Array.Empty<SummerRaceActivityWheelSourceRecord>();

	public SummerRaceActivityMountPointSourceRecord[] MountPoints = Array.Empty<SummerRaceActivityMountPointSourceRecord>();

	public string ChassisPrefabPath = string.Empty;

	public string UnlockStageId = string.Empty;
}
