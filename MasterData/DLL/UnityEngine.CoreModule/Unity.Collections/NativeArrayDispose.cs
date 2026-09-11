using Unity.Collections.LowLevel.Unsafe;

namespace Unity.Collections;

[NativeContainer]
internal struct NativeArrayDispose
{
	[NativeDisableUnsafePtrRestriction]
	internal unsafe void* m_Buffer;

	internal Allocator m_AllocatorLabel;

	public unsafe void Dispose()
	{
		UnsafeUtility.FreeTracked(m_Buffer, m_AllocatorLabel);
	}
}
