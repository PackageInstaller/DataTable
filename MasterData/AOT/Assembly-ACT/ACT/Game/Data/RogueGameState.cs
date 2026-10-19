using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum RogueGameState
{
	[OriginalName("ROGUE_GAME_NULL")]
	RogueGameNull,
	[OriginalName("ROGUE_GAME_HANG")]
	RogueGameHang,
	[OriginalName("ROGUE_GAME_PLAY")]
	RogueGamePlay
}
