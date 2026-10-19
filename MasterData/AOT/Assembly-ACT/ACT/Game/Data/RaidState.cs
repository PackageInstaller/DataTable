using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum RaidState
{
	[OriginalName("RAID_STATE_INIT")]
	Init,
	[OriginalName("RAID_STATE_TOOK_REWARD")]
	TookReward,
	[OriginalName("RAID_STATE_FAILURE")]
	Failure
}
