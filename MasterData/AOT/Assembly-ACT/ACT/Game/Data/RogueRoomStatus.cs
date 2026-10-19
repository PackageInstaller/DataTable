using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum RogueRoomStatus
{
	[OriginalName("ROGUE_ROOM_STATUS_UNFINISHED")]
	Unfinished,
	[OriginalName("ROGUE_ROOM_STATUS_FINISHED")]
	Finished
}
