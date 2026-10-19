using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum GuideStateEnum
{
	[OriginalName("GUIDE_STATE_ONGOING")]
	GuideStateOngoing,
	[OriginalName("GUIDE_STATE_COMPLETE")]
	GuideStateComplete
}
