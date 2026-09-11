using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/控制/循环(Loop)")]
[TrackClipType(typeof(LoopNode))]
public class LoopTrack : TrackAsset
{
}
