using Unity.Collections;

namespace UnityEngine.Rendering;

public struct BatchCullingOutput
{
	public NativeArray<BatchCullingOutputDrawCommands> drawCommands;
}
