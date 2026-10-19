using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum GachaPoolState
{
	[OriginalName("GACHA_POOL_STATE_EFFECTIVE")]
	Effective,
	[OriginalName("GACHA_POOL_STATE_OFF_SHELF")]
	OffShelf,
	[OriginalName("GACHA_POOL_STATE_SHIELD")]
	Shield
}
