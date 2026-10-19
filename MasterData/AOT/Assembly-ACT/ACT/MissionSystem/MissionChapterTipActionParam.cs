using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.MissionSystem;

[Serializable]
public class MissionChapterTipActionParam
{
	public enum MissionChapterTipType
	{
		[InspectorName("章节开始")]
		Begin,
		[InspectorName("章节结束")]
		End
	}

	[FormerlySerializedAs("type")]
	public MissionChapterTipType tipType;
}
