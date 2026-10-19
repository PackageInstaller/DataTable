using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum MissionFlowType
{
	[OriginalName("MISSION_FLOW_TYPE_NORMAL")]
	Normal,
	[OriginalName("MISSION_FLOW_TYPE_FAIL")]
	Fail,
	[OriginalName("MISSION_FLOW_TYPE_EXTRA")]
	Extra
}
