using UnityEngine.Bindings;

namespace Unity.IO.LowLevel.Unsafe;

[NativeHeader("Runtime/File/AsyncReadManagerMetrics.h")]
public enum ProcessingState
{
	Unknown,
	InQueue,
	Reading,
	Completed,
	Failed,
	Canceled
}
