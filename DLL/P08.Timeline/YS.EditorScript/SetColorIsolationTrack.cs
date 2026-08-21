using System.ComponentModel;
using UnityEngine;
using UnityEngine.Timeline;

namespace YS.EditorScript;

[DisplayName("剧情Timeline/特效/色调分离")]
[TrackClipType(typeof(SetColorIsolationNode))]
[TrackBindingType(typeof(Transform))]
public class SetColorIsolationTrack : PlayableTrack
{
}
