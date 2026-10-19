using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum BloodstainState
{
	[OriginalName("BLOODSTAIN_STATE_INITIAL")]
	Initial,
	[OriginalName("BLOODSTAIN_STATE_INTERACTED")]
	Interacted
}
