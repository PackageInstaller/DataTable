using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/角色/外发光(StoryFlashAction)")]
[TrackClipType(typeof(StoryFlashActionNode))]
[TrackBindingType(typeof(CharacterEffect))]
public class StoryFlashActionTrack : TrackAsset
{
}
