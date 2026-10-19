using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum TempleStageState
{
	[OriginalName("TEMPLE_STAGE_INIT")]
	TempleStageInit,
	[OriginalName("TEMPLE_STAGE_COMPLETE")]
	TempleStageComplete,
	[OriginalName("TEMPLE_STAGE_FAILURE")]
	TempleStageFailure
}
