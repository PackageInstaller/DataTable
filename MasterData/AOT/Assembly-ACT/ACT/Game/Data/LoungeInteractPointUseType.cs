using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum LoungeInteractPointUseType
{
	[OriginalName("LOUNGE_INTERACT_POINT_USE_EMPTY")]
	LoungeInteractPointUseEmpty,
	[OriginalName("LOUNGE_INTERACT_POINT_USE_INVITE")]
	LoungeInteractPointUseInvite,
	[OriginalName("LOUNGE_INTERACT_POINT_USE_GLOBAL")]
	LoungeInteractPointUseGlobal,
	[OriginalName("LOUNGE_INTERACT_POINT_USE_RAND")]
	LoungeInteractPointUseRand
}
