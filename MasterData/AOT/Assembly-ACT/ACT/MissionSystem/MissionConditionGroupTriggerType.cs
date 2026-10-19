using UnityEngine;

namespace ACT.MissionSystem;

public enum MissionConditionGroupTriggerType
{
	[InspectorName("触发一次")]
	Once,
	[InspectorName("重复触发")]
	Repeated
}
