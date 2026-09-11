using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/特效/场景环境光(ProbeLighting)")]
[TrackClipType(typeof(SceneProbeLightingNode))]
[TrackBindingType(typeof(SceneSetting))]
public class SceneProbeLightingTrack : TrackAsset
{
}
