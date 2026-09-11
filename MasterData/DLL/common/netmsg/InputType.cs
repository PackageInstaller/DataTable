using Google.Protobuf.Reflection;

namespace netmsg;

public enum InputType
{
	[OriginalName("IT_NONE")]
	ItNone,
	[OriginalName("IT_DO_SKILL")]
	ItDoSkill
}
