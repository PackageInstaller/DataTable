using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("测试功能/StoryTimelineCharacterOutline")]
[TrackClipType(typeof(StoryTimelineCharactorOutlineNode))]
[TrackBindingType(typeof(CharacterEffect))]
public class StoryTimelineCharacterOutline : TrackAsset
{
}
