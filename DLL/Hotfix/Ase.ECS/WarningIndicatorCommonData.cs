using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class WarningIndicatorCommonData : IReference
{
	public Vector3 InitPos;

	public float InitAngle;

	public BaseEntity Creator;

	public bool IsRelativeAngle;

	public bool IsRelativePosition;

	public Vector3 PositionOffset;

	public float AngleOffset;

	public bool SkillStop;

	public Color ChargingColor;

	public Color FinishedColor;

	public Color BaseColor => new Color(ChargingColor.r, ChargingColor.g, ChargingColor.b, 0.5f);

	public void Clear()
	{
		InitPos = Vector3.zero;
		Creator = null;
	}
}
