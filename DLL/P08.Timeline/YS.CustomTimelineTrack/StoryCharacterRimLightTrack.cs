using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/角色/角色边缘光(StoryCharacterRimLightNode)")]
[TrackClipType(typeof(StoryCharacterRimLightNode))]
[TrackBindingType(typeof(CharacterEffect))]
public class StoryCharacterRimLightTrack : TrackAsset
{
}
