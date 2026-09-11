using Google.Protobuf.Reflection;

namespace netmsg;

public enum MessageType
{
	[OriginalName("MT_NONE")]
	MtNone,
	[OriginalName("MT_LOGIN")]
	MtLogin,
	[OriginalName("MT_BATTLE_START")]
	MtBattleStart,
	[OriginalName("MT_BATTLE_UPDATE")]
	MtBattleUpdate,
	[OriginalName("MT_BATTLE_END")]
	MtBattleEnd
}
