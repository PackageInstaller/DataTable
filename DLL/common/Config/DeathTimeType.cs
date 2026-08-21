using Google.Protobuf.Reflection;

namespace Config;

public enum DeathTimeType
{
	[OriginalName("DeathTimeType_ImmediatelyDeath")]
	ImmediatelyDeath,
	[OriginalName("DeathTimeType_WaitHitRecover")]
	WaitHitRecover,
	[OriginalName("DeathTimeType_WaitGetUp")]
	WaitGetUp
}
