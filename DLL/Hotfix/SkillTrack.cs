using System;

[Serializable]
[TrackName(Name = "技能状态")]
[TrackColor(1f, 82f / 85f, 0f)]
[TrackBindClip(Types = new Type[]
{
	typeof(ExecuteSkillStateClip),
	typeof(SkillDeroveWindowClip),
	typeof(SkillBreakWindowClip)
})]
public class SkillTrack : StandardTrack
{
}
