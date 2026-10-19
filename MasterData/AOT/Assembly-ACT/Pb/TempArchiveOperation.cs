using Google.Protobuf.Reflection;

namespace Pb;

public enum TempArchiveOperation
{
	[OriginalName("Start")]
	Start,
	[OriginalName("Update")]
	Update,
	[OriginalName("DropCurrentStage")]
	DropCurrentStage,
	[OriginalName("DropAllStage")]
	DropAllStage,
	[OriginalName("Finish")]
	Finish
}
