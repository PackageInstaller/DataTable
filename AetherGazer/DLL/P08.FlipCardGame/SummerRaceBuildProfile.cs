using System;
using UnityEngine;

[Serializable]
public struct SummerRaceBuildProfile
{
	public string SourceTag;

	public SummerRaceBodyType BodyType;

	public string BodyLabel;

	public WeaponKind[] Weapons;

	public EquipKind[] Equips;

	public float TotalMass;

	public Vector2 CenterOfMassLocal;

	public float FrontWheelRadius;

	public float BackWheelRadius;

	public float WheelBase;

	public float FrontRearMassBias;

	public float CruiseSpeed;

	public float TractionGain;

	public float EstimatedDps;

	public float RecoilLoad;

	public int CostUsed;

	public int CostCap;
}
