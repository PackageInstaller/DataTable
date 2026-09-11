using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Timeline;

namespace YS.T0WorldTrack;

[Serializable]
[DisplayName("T0小场景/小游戏/床上控制表情")]
[TrackClipType(typeof(T0WorldBedEmojiNode))]
[TrackBindingType(typeof(Animator))]
public class T0WorldBedEmojiTrack : TrackAsset
{
}
