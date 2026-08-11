using System;

[Serializable]
[TrackName(Name = "音频")]
[TrackColor(0.99215686f, 0.7607843f, 0.015686275f)]
[TrackBindClip(Types = new Type[] { typeof(PlayAudioClip) })]
public class AudioTrack : StandardTrack
{
}
