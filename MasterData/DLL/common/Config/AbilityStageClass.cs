using Google.Protobuf.Reflection;

namespace Config;

public enum AbilityStageClass
{
	[OriginalName("AbilityStageClass_None")]
	None,
	[OriginalName("AbilityStageClass_CastAnimation")]
	CastAnimation,
	[OriginalName("AbilityStageClass_CastPoint")]
	CastPoint,
	[OriginalName("AbilityStageClass_CastBackswing")]
	CastBackswing,
	[OriginalName("AbilityStageClass_CastMoveswing")]
	CastMoveswing,
	[OriginalName("AbilityStageClass_CastTurn")]
	CastTurn,
	[OriginalName("AbilityStageClass_CastMoveTurn")]
	CastMoveTurn,
	[OriginalName("AbilityStageClass_CastMoveLock")]
	CastMoveLock,
	[OriginalName("AbilityStageClass_CastMoveLockBackswing")]
	CastMoveLockBackswing,
	[OriginalName("AbilityStageClass_CastMoveUpdateLock")]
	CastMoveUpdateLock
}
