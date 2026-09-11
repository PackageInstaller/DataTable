using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("测试功能/HomeUIWordDisplay")]
[TrackClipType(typeof(HomeUIWordDisplayNode))]
public class HomeUIWordDisplayTrack : TrackAsset
{
}
