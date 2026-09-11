using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("特效工具/特效预制体(EffectPrefab)")]
[TrackClipType(typeof(EffectPrefabClip))]
[TrackBindingType(typeof(GameObject))]
public class EffectPrefabTrack : TrackAsset
{
}
