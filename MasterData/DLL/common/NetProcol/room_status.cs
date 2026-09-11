using Google.Protobuf.Reflection;

namespace NetProcol;

public enum room_status
{
	[OriginalName("room_status_none")]
	None,
	[OriginalName("room_status_idle")]
	Idle,
	[OriginalName("room_status_full")]
	Full,
	[OriginalName("room_status_ready")]
	Ready,
	[OriginalName("room_status_run")]
	Run
}
