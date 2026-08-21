using System;

[Serializable]
[TrackName(Name = "特效")]
[TrackColor(0f, 1f, 0.45f)]
[TrackBindClip(Types = new Type[] { typeof(PlayEffectClip) })]
public class EffectTrack : StandardTrack
{
}
