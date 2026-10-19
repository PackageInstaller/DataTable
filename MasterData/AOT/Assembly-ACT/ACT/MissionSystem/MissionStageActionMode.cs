using UnityEngine;

namespace ACT.MissionSystem;

public enum MissionStageActionMode
{
	[InspectorName("同时执行")]
	Parallel,
	[InspectorName("顺序执行")]
	Sequence
}
