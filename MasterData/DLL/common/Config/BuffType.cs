using Google.Protobuf.Reflection;

namespace Config;

public enum BuffType
{
	[OriginalName("BuffType_none")]
	None,
	[OriginalName("BuffType_buff")]
	Buff,
	[OriginalName("BuffType_debuff")]
	Debuff
}
