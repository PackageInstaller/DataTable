using System;

[Serializable]
[TrackName(Name = "Buff")]
[TrackColor(1f, 0f, 0f)]
[TrackBindClip(Types = new Type[] { typeof(PlayBuffClip) })]
public class BuffTrack : StandardTrack
{
}
