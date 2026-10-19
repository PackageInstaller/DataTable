using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum AbyssStageState
{
	[OriginalName("ABYSS_STAGE_ONGOING")]
	AbyssStageOngoing,
	[OriginalName("ABYSS_STAGE_TMP_LEAVE")]
	AbyssStageTmpLeave,
	[OriginalName("ABYSS_STAGE_Complete")]
	AbyssStageComplete,
	[OriginalName("ABYSS_STAGE_FAILURE")]
	AbyssStageFailure
}
