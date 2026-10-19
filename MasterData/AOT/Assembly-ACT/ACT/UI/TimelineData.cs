using System;
using UnityEngine.Timeline;

namespace ACT.UI;

[Serializable]
public struct TimelineData
{
	public string beforeAnimationName;

	public TimelineAsset timeline;

	public string afterAnimationName;
}
