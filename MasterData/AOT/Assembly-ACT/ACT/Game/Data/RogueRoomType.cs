using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum RogueRoomType
{
	[OriginalName("ROGUE_ROOM_TYPE_NULL")]
	Null,
	[OriginalName("ROGUE_ROOM_TYPE_ALLY")]
	Ally,
	[OriginalName("ROGUE_ROOM_TYPE_ITEM")]
	Item,
	[OriginalName("ROGUE_ROOM_TYPE_CION")]
	Cion,
	[OriginalName("ROGUE_ROOM_TYPE_SHOP")]
	Shop,
	[OriginalName("ROGUE_ROOM_TYPE_BOSS")]
	Boss
}
