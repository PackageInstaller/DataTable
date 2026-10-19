using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum MissionStateEnum
{
	[OriginalName("MISSION_STATE_WAIT_ACCEPT")]
	MissionStateWaitAccept,
	[OriginalName("MISSION_STATE_ONGOING")]
	MissionStateOngoing,
	[OriginalName("MISSION_STATE_FAILED")]
	MissionStateFailed,
	[OriginalName("MISSION_STATE_SUCCESS")]
	MissionStateSuccess,
	[OriginalName("MISSION_STATE_GIVEUP")]
	MissionStateGiveup
}
