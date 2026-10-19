using UnityEngine.Scripting;

namespace Unity.Collections;

[UsedByNativeCode]
public enum Allocator
{
	Invalid = 0,
	None = 1,
	Temp = 2,
	TempJob = 3,
	Persistent = 4,
	AudioKernel = 5,
	FirstUserIndex = 64
}
