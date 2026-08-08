using Google.Protobuf.Reflection;

namespace Config;

public enum SkillSubType
{
	[OriginalName("SkillSubType_Normal")]
	Normal,
	[OriginalName("SkillSubType_Charge")]
	Charge,
	[OriginalName("SkillSubType_Transfiguration")]
	Transfiguration,
	[OriginalName("SkillSubType_Persist")]
	Persist,
	[OriginalName("SkillSubType_Strengthen")]
	Strengthen,
	[OriginalName("SkillSubType_Switch")]
	Switch,
	[OriginalName("SkillSubType_Prepare")]
	Prepare
}
