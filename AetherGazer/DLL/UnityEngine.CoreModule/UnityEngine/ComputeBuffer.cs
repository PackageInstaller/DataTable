using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[NativeClass("GraphicsBuffer")]
[NativeHeader("Runtime/Export/Graphics/GraphicsBuffer.bindings.h")]
[NativeHeader("Runtime/Shaders/GraphicsBuffer.h")]
public sealed class ComputeBuffer : IDisposable
{
	internal IntPtr m_Ptr;

	public extern int count
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int stride
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	private extern ComputeBufferMode usage
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public string name
	{
		set
		{
			SetName(value);
		}
	}

	~ComputeBuffer()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		if (disposing)
		{
			DestroyBuffer(this);
		}
		else if (m_Ptr != IntPtr.Zero)
		{
			Debug.LogWarning("GarbageCollector disposing of ComputeBuffer. Please use ComputeBuffer.Release() or .Dispose() to manually release the buffer.");
		}
		m_Ptr = IntPtr.Zero;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GraphicsBuffer_Bindings::InitComputeBuffer")]
	private static extern IntPtr InitBuffer(int count, int stride, ComputeBufferType type, ComputeBufferMode usage);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GraphicsBuffer_Bindings::DestroyComputeBuffer")]
	private static extern void DestroyBuffer(ComputeBuffer buf);

	public ComputeBuffer(int count, int stride)
		: this(count, stride, ComputeBufferType.Default, ComputeBufferMode.Immutable, 3)
	{
	}

	public ComputeBuffer(int count, int stride, ComputeBufferType type)
		: this(count, stride, type, ComputeBufferMode.Immutable, 3)
	{
	}

	public ComputeBuffer(int count, int stride, ComputeBufferType type, ComputeBufferMode usage)
		: this(count, stride, type, usage, 3)
	{
	}

	private ComputeBuffer(int count, int stride, ComputeBufferType type, ComputeBufferMode usage, int stackDepth)
	{
		if (count <= 0)
		{
			throw new ArgumentException("Attempting to create a zero length compute buffer", "count");
		}
		if (stride <= 0)
		{
			throw new ArgumentException("Attempting to create a compute buffer with a negative or null stride", "stride");
		}
		long num = (long)count * (long)stride;
		long maxGraphicsBufferSize = SystemInfo.maxGraphicsBufferSize;
		if (num > maxGraphicsBufferSize)
		{
			throw new ArgumentException($"The total size of the compute buffer ({num} bytes) exceeds the maximum buffer size. Maximum supported buffer size: {maxGraphicsBufferSize} bytes.");
		}
		m_Ptr = InitBuffer(count, stride, type, usage);
	}

	public void Release()
	{
		Dispose();
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GraphicsBuffer_Bindings::IsValidBuffer")]
	private static extern bool IsValidBuffer(ComputeBuffer buf);

	public bool IsValid()
	{
		return m_Ptr != IntPtr.Zero && IsValidBuffer(this);
	}

	public void SetData(Array data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to ComputeBuffer.SetData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
		}
		InternalSetData(data, 0, 0, data.Length, UnsafeUtility.SizeOf(data.GetType().GetElementType()));
	}

	public void SetData<T>(List<T> data) where T : struct
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsGenericListBlittable<T>())
		{
			throw new ArgumentException($"List<{typeof(T)}> passed to ComputeBuffer.SetData(List<>) must be blittable.\n{UnsafeUtility.GetReasonForGenericListNonBlittable<T>()}");
		}
		InternalSetData(NoAllocHelpers.ExtractArrayFromList(data), 0, 0, NoAllocHelpers.SafeLength(data), Marshal.SizeOf(typeof(T)));
	}

	public unsafe void SetData<T>(NativeArray<T> data) where T : struct
	{
		InternalSetNativeData((IntPtr)data.GetUnsafeReadOnlyPtr(), 0, 0, data.Length, UnsafeUtility.SizeOf<T>());
	}

	public void SetData(Array data, int managedBufferStartIndex, int computeBufferStartIndex, int count)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to ComputeBuffer.SetData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
		}
		if (managedBufferStartIndex < 0 || computeBufferStartIndex < 0 || count < 0 || managedBufferStartIndex + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (managedBufferStartIndex:{managedBufferStartIndex} computeBufferStartIndex:{computeBufferStartIndex} count:{count})");
		}
		InternalSetData(data, managedBufferStartIndex, computeBufferStartIndex, count, Marshal.SizeOf(data.GetType().GetElementType()));
	}

	public void SetData<T>(List<T> data, int managedBufferStartIndex, int computeBufferStartIndex, int count) where T : struct
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsGenericListBlittable<T>())
		{
			throw new ArgumentException($"List<{typeof(T)}> passed to ComputeBuffer.SetData(List<>) must be blittable.\n{UnsafeUtility.GetReasonForGenericListNonBlittable<T>()}");
		}
		if (managedBufferStartIndex < 0 || computeBufferStartIndex < 0 || count < 0 || managedBufferStartIndex + count > data.Count)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (managedBufferStartIndex:{managedBufferStartIndex} computeBufferStartIndex:{computeBufferStartIndex} count:{count})");
		}
		InternalSetData(NoAllocHelpers.ExtractArrayFromList(data), managedBufferStartIndex, computeBufferStartIndex, count, Marshal.SizeOf(typeof(T)));
	}

	public unsafe void SetData<T>(NativeArray<T> data, int nativeBufferStartIndex, int computeBufferStartIndex, int count) where T : struct
	{
		if (nativeBufferStartIndex < 0 || computeBufferStartIndex < 0 || count < 0 || nativeBufferStartIndex + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (nativeBufferStartIndex:{nativeBufferStartIndex} computeBufferStartIndex:{computeBufferStartIndex} count:{count})");
		}
		InternalSetNativeData((IntPtr)data.GetUnsafeReadOnlyPtr(), nativeBufferStartIndex, computeBufferStartIndex, count, UnsafeUtility.SizeOf<T>());
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::InternalSetNativeData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetNativeData(IntPtr data, int nativeBufferStartIndex, int computeBufferStartIndex, int count, int elemSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::InternalSetData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetData(Array data, int managedBufferStartIndex, int computeBufferStartIndex, int count, int elemSize);

	public void GetData(Array data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to ComputeBuffer.GetData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
		}
		InternalGetData(data, 0, 0, data.Length, Marshal.SizeOf(data.GetType().GetElementType()));
	}

	public void GetData(Array data, int managedBufferStartIndex, int computeBufferStartIndex, int count)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to ComputeBuffer.GetData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
		}
		if (managedBufferStartIndex < 0 || computeBufferStartIndex < 0 || count < 0 || managedBufferStartIndex + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count argument (managedBufferStartIndex:{managedBufferStartIndex} computeBufferStartIndex:{computeBufferStartIndex} count:{count})");
		}
		InternalGetData(data, managedBufferStartIndex, computeBufferStartIndex, count, Marshal.SizeOf(data.GetType().GetElementType()));
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::InternalGetData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalGetData(Array data, int managedBufferStartIndex, int computeBufferStartIndex, int count, int elemSize);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe extern void* BeginBufferWrite(int offset = 0, int size = 0);

	public unsafe NativeArray<T> BeginWrite<T>(int computeBufferStartIndex, int count) where T : struct
	{
		if (!IsValid())
		{
			throw new InvalidOperationException("BeginWrite requires a valid ComputeBuffer");
		}
		if (usage != ComputeBufferMode.SubUpdates)
		{
			throw new ArgumentException("ComputeBuffer must be created with usage mode ComputeBufferMode.SubUpdates to be able to be mapped with BeginWrite");
		}
		int num = UnsafeUtility.SizeOf<T>();
		if (computeBufferStartIndex < 0 || count < 0 || (computeBufferStartIndex + count) * num > this.count * stride)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (computeBufferStartIndex:{computeBufferStartIndex} count:{count} elementSize:{num}, this.count:{this.count}, this.stride{stride})");
		}
		void* dataPointer = BeginBufferWrite(computeBufferStartIndex * num, count * num);
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>(dataPointer, count, Allocator.Invalid);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void EndBufferWrite(int bytesWritten = 0);

	public void EndWrite<T>(int countWritten) where T : struct
	{
		if (countWritten < 0)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (countWritten:{countWritten})");
		}
		int num = UnsafeUtility.SizeOf<T>();
		EndBufferWrite(countWritten * num);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::SetName", HasExplicitThis = true)]
	private extern void SetName(string name);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetCounterValue(uint counterValue);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void CopyCount(ComputeBuffer src, ComputeBuffer dst, int dstOffsetBytes);

	[MethodImpl((MethodImplOptions)4096)]
	public extern IntPtr GetNativeBufferPtr();
}
