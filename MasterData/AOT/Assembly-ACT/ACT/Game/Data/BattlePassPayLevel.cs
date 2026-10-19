using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum BattlePassPayLevel
{
	[OriginalName("BATTLE_PASS_PAY_NULL")]
	BattlePassPayNull,
	[OriginalName("BATTLE_PASS_PAY_LOW")]
	BattlePassPayLow,
	[OriginalName("BATTLE_PASS_PAY_HIGH")]
	BattlePassPayHigh
}
