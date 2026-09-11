using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/特效/场景灰化(SceneGrayness)")]
[TrackClipType(typeof(SceneGraynessNode))]
[TrackBindingType(typeof(SceneSetting))]
public class SceneGraynessTrack : TrackAsset
{
}
