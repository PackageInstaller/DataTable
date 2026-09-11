using Google.Protobuf.Reflection;

namespace Config;

public enum EffectType
{
	[OriginalName("EffectType_none")]
	None,
	[OriginalName("EffectType_general_harm")]
	GeneralHarm,
	[OriginalName("EffectType_harm")]
	Harm,
	[OriginalName("EffectType_effect")]
	Effect,
	[OriginalName("EffectType_death")]
	Death
}
