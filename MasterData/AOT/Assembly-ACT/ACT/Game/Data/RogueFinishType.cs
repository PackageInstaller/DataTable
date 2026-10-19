using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum RogueFinishType
{
	[OriginalName("ROGUE_FINISH_TYPE_PASS")]
	Pass,
	[OriginalName("ROGUE_FINISH_TYPE_DEAD")]
	Dead,
	[OriginalName("ROGUE_FINISH_TYPE_QUIT")]
	Quit
}
