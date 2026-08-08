using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/角色/切片(CharacterSlice)")]
[TrackClipType(typeof(CharacterEffectSliceNode))]
[TrackBindingType(typeof(CharacterEffect))]
public class CharacterSliceTrack : TrackAsset
{
}
