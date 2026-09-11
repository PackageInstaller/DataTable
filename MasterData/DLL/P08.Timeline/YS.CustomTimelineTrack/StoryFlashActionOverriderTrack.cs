using System;
using System.ComponentModel;
using UnityEngine.Pipelines.SimPipeline.Character;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/角色/外发光(单材质)(StoryFlashActionOverrider)")]
[TrackClipType(typeof(StoryFlashActionOverriderNode))]
[TrackBindingType(typeof(CharacterEffectOverrider))]
public class StoryFlashActionOverriderTrack : TrackAsset
{
}
