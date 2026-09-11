using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/特效/截屏(CaptureSnapshot)")]
[TrackClipType(typeof(CaptureSnapshotNode))]
public class CaptureSnapshotTrack : TrackAsset
{
}
