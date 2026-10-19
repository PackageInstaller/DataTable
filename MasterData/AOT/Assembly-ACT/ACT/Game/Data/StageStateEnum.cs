using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum StageStateEnum
{
	[OriginalName("STAGE_STATE_OUT")]
	StageStateOut,
	[OriginalName("STAGE_STATE_ONGOING")]
	StageStateOngoing,
	[OriginalName("STAGE_STATE_FAILURE")]
	StageStateFailure,
	[OriginalName("STAGE_STATE_SUCCESS")]
	StageStateSuccess,
	[OriginalName("STAGE_STATE_TMP_LEAVE")]
	StageStateTmpLeave
}
