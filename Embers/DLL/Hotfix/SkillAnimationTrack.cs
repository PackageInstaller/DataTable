using System;

[Serializable]
[TrackName(Name = "动画")]
[TrackColor(0.49803922f, 84f / 85f, 76f / 85f)]
[TrackBindClip(Types = new Type[] { typeof(PlayAnimationClip) })]
public class SkillAnimationTrack : StandardTrack
{
}
