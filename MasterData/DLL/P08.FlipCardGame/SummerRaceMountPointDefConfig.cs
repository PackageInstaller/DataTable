using System;
using UnityEngine;

[Serializable]
public sealed class SummerRaceMountPointDefConfig
{
	public SummerRaceMountSlotTypeConfig slotType;

	public int slotIndex;

	public Vector2 localPosition = new Vector2(0.45f, 0.15f);

	public float localAngle;
}
