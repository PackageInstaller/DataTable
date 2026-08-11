using Unity.Jobs;

namespace Unity.Collections;

internal struct NativeArrayDisposeJob : IJob
{
	internal NativeArrayDispose Data;

	public void Execute()
	{
		Data.Dispose();
	}
}
