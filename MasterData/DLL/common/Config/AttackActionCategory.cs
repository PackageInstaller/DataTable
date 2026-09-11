using Google.Protobuf.Reflection;

namespace Config;

public enum AttackActionCategory
{
	[OriginalName("AttackActionCategory_None")]
	None,
	[OriginalName("AttackActionCategory_Chop")]
	Chop,
	[OriginalName("AttackActionCategory_Stabbing")]
	Stabbing,
	[OriginalName("AttackActionCategory_Pound")]
	Pound,
	[OriginalName("AttackActionCategory_Shoot")]
	Shoot,
	[OriginalName("AttackActionCategory_Hit")]
	Hit,
	[OriginalName("AttackActionCategory_MagicHit")]
	MagicHit
}
