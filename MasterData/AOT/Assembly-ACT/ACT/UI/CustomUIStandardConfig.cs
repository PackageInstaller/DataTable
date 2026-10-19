using System.Collections.Generic;
using Sirenix.OdinInspector;

namespace ACT.UI;

public class CustomUIStandardConfig : LuminSerializedScriptableObject
{
	public Dictionary<CustomUICompType, CustomUICompStandardConfig> compStandard;

	public int customSchemeMaxNum;

	[Unit(Units.Percent)]
	public float compDiameterMin;

	[Unit(Units.Percent)]
	public float compDiameterMax;

	public float edgeOffsetMin;

	public float edgeOffsetMax;

	public float posModifyStep;
}
