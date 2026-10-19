using System;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
[NativeHeader("Runtime/Graphics/AsyncGPUReadbackManaged.h")]
internal struct AsyncRequestNativeArrayData
{
	public unsafe void* nativeArrayBuffer;

	public long lengthInBytes;

	public unsafe static AsyncRequestNativeArrayData CreateAndCheckAccess<T>(NativeArray<T> array) where T : struct
	{
		if (array.m_AllocatorLabel == Allocator.Temp || array.m_AllocatorLabel == Allocator.TempJob)
		{
			throw new ArgumentException("AsyncGPUReadback cannot use Temp memory as input since the result may only become available at an unspecified point in the future.");
		}
		return new AsyncRequestNativeArrayData
		{
			nativeArrayBuffer = array.GetUnsafePtr(),
			lengthInBytes = (long)array.Length * (long)UnsafeUtility.SizeOf<T>()
		};
	}

	public unsafe static AsyncRequestNativeArrayData CreateAndCheckAccess<T>(NativeSlice<T> array) where T : struct
	{
		return new AsyncRequestNativeArrayData
		{
			nativeArrayBuffer = array.GetUnsafePtr(),
			lengthInBytes = (long)array.Length * (long)UnsafeUtility.SizeOf<T>()
		};
	}
}
