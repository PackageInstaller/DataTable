using UnityEngine.Scripting;

namespace Unity.Collections;

[UsedByNativeCode]
public enum Allocator
{
	Invalid,
	None,
	Temp,
	TempJob,
	Persistent,
	AudioKernel
}
