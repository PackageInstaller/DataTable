using UnityEngine;

public enum DamageType
{
	[InspectorName("无")]
	None,
	[InspectorName("近战伤害")]
	Melee,
	[InspectorName("远程伤害")]
	Range,
	[InspectorName("DOT")]
	DOT,
	[InspectorName("陷阱伤害")]
	Trap,
	[InspectorName("区域伤害")]
	Area
}
