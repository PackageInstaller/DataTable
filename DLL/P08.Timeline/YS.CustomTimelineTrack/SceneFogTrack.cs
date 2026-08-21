using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/特效/场景雾效(SceneFog)")]
[TrackClipType(typeof(SceneFogNode))]
[TrackBindingType(typeof(SceneSetting))]
public class SceneFogTrack : TrackAsset
{
}
