using System;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class BlackScreenActionParam
{
	public enum BlackScreenType
	{
		[InspectorName("黑屏")]
		Show,
		[InspectorName("亮屏")]
		Hide
	}

	public BlackScreenType type;

	public float time = 0.5f;

	public float duration;
}
