using System;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Shaders/GraphicsBuffer.h")]
[NativeHeader("Runtime/Export/Graphics/GraphicsBuffer.bindings.h")]
[UsedByNativeCode]
[NativeClass("GraphicsBuffer")]
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
	[FreeFunction("GraphicsBuffer_Bindings::DestroyBuffer")]
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

	public unsafe void SetData<T>(NativeArray<T> data) where T : struct
	{
		InternalSetNativeData((IntPtr)data.GetUnsafeReadOnlyPtr(), 0, 0, data.Length, UnsafeUtility.SizeOf<T>());
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

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::SetName", HasExplicitThis = true)]
	private extern void SetName(string name);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetCounterValue(uint counterValue);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void CopyCount(ComputeBuffer src, ComputeBuffer dst, int dstOffsetBytes);
}
