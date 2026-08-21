using System;

[Serializable]
[TrackName(Name = "技能加成")]
[TrackColor(1f, 0.52f, 0.97f)]
[TrackBindClip(Types = new Type[] { typeof(SetSkillAdditionClip) })]
public class SkillAdditionTrack : StandardTrack
{
}
