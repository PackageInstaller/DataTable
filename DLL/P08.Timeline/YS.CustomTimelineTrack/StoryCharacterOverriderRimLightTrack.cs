using System;
using System.ComponentModel;
using UnityEngine.Pipelines.SimPipeline.Character;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/角色/角色边缘光(单材质)(StoryCharacterRimLightNode)")]
[TrackClipType(typeof(StoryCharacterOverriderRimLightNode))]
[TrackBindingType(typeof(CharacterEffectOverrider))]
public class StoryCharacterOverriderRimLightTrack : TrackAsset
{
}
