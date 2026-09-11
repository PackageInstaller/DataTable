using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/角色/角色阴影(StoryCharacterLightingNode)")]
[TrackClipType(typeof(StoryCharacterLightingNode))]
[TrackBindingType(typeof(CharacterEffect))]
public class StoryCharacterLightingNodeTrack : TrackAsset
{
}
