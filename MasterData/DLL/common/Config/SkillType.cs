using Google.Protobuf.Reflection;

namespace Config;

public enum SkillType
{
	[OriginalName("SkillType_Passive")]
	Passive,
	[OriginalName("SkillType_Skill")]
	Skill,
	[OriginalName("SkillType_Avoid")]
	Avoid,
	[OriginalName("SkillType_Melee")]
	Melee,
	[OriginalName("SkillType_Astrolabe")]
	Astrolabe,
	[OriginalName("SkillType_CoordinatedAttack")]
	CoordinatedAttack
}
