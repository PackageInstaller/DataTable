using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum GachaPoolType
{
	[OriginalName("POOL_TYPE_NULL")]
	PoolTypeNull,
	[OriginalName("POOL_TYPE_RESIDENT")]
	PoolTypeResident,
	[OriginalName("POOL_TYPE_LIMITED_GUARANTEED")]
	PoolTypeLimitedGuaranteed,
	[OriginalName("POOL_TYPE_LIMITED_UP")]
	PoolTypeLimitedUp,
	[OriginalName("POOL_TYPE_TEST_ROUND_TWO")]
	PoolTypeTestRoundTwo,
	[OriginalName("POOL_TYPE_NEWBIE")]
	PoolTypeNewbie
}
