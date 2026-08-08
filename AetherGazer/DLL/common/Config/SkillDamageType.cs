using Google.Protobuf.Reflection;

namespace Config;

public enum SkillDamageType
{
	[OriginalName("SkillDamageType_Physics")]
	Physics = 0,
	[OriginalName("SkillDamageType_Wind")]
	Wind = 2,
	[OriginalName("SkillDamageType_Fire")]
	Fire = 4,
	[OriginalName("SkillDamageType_Ice")]
	Ice = 6,
	[OriginalName("SkillDamageType_Water")]
	Water = 8,
	[OriginalName("SkillDamageType_Dark")]
	Dark = 10,
	[OriginalName("SkillDamageType_Light")]
	Light = 12,
	[OriginalName("SkillDamageType_Thunder")]
	Thunder = 14,
	[OriginalName("SkillDamageType_Random")]
	Random = 254,
	[OriginalName("SkillDamageType_All")]
	All = 255
}
