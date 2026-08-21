using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[NativeHeader("Runtime/Export/Graphics/GraphicsBuffer.bindings.h")]
[NativeHeader("Runtime/Shaders/GraphicsBuffer.h")]
public sealed class GraphicsBuffer : IDisposable
{
	[Flags]
	public enum Target
	{
		Vertex = 1,
		Index = 2,
		CopySource = 4,
		CopyDestination = 8,
		Structured = 0x10,
		Raw = 0x20,
		Append = 0x40,
		Counter = 0x80,
		IndirectArguments = 0x100,
		Constant = 0x200
	}

	[Flags]
	public enum UsageFlags
	{
		None = 0,
		LockBufferForWrite = 1
	}

	public struct IndirectDrawArgs
	{
		[DebuggerBrowsable(DebuggerBrowsableState.Never)]
		[CompilerGenerated]
		private uint _003CvertexCountPerInstance_003Ek__BackingField;

		[DebuggerBrowsable(DebuggerBrowsableState.Never)]
		[CompilerGenerated]
		private uint _003CinstanceCount_003Ek__BackingField;

		[CompilerGenerated]
		[DebuggerBrowsable(DebuggerBrowsableState.Never)]
		private uint _003CstartVertex_003Ek__BackingField;

		[DebuggerBrowsable(DebuggerBrowsableState.Never)]
		[CompilerGenerated]
		private uint _003CstartInstance_003Ek__BackingField;
	}

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

	public extern Target target
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public UsageFlags usageFlags => GetUsageFlags();

	public GraphicsBufferHandle bufferHandle
	{
		get
		{
			get_bufferHandle_Injected(out var ret);
			return ret;
		}
	}

	public string name
	{
		set
		{
			SetName(value);
		}
	}

	~GraphicsBuffer()
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
			Debug.LogWarning("GarbageCollector disposing of GraphicsBuffer. Please use GraphicsBuffer.Release() or .Dispose() to manually release the buffer.");
		}
		m_Ptr = IntPtr.Zero;
	}

	private static bool RequiresCompute(Target target)
	{
		Target target2 = Target.Structured | Target.Raw | Target.Append | Target.Counter | Target.IndirectArguments;
		return (target & target2) != 0;
	}

	private static bool IsVertexIndexOrCopyOnly(Target target)
	{
		Target target2 = Target.Vertex | Target.Index | Target.CopySource | Target.CopyDestination;
		return (target & target2) == target;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GraphicsBuffer_Bindings::InitBuffer")]
	private static extern IntPtr InitBuffer(Target target, UsageFlags usageFlags, int count, int stride);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GraphicsBuffer_Bindings::DestroyBuffer")]
	private static extern void DestroyBuffer(GraphicsBuffer buf);

	public GraphicsBuffer(Target target, int count, int stride)
	{
		InternalInitialization(target, ((target & (Target.Vertex | Target.Index)) == target) ? UsageFlags.LockBufferForWrite : UsageFlags.None, count, stride);
	}

	public GraphicsBuffer(Target target, UsageFlags usageFlags, int count, int stride)
	{
		InternalInitialization(target, usageFlags, count, stride);
	}

	private void InternalInitialization(Target target, UsageFlags usageFlags, int count, int stride)
	{
		if (RequiresCompute(target) && !SystemInfo.supportsComputeShaders)
		{
			throw new ArgumentException("Attempting to create a graphics buffer that requires compute shader support, but compute shaders are not supported on this platform. Target: " + target);
		}
		if (count <= 0)
		{
			throw new ArgumentException("Attempting to create a zero length graphics buffer", "count");
		}
		if (stride <= 0)
		{
			throw new ArgumentException("Attempting to create a graphics buffer with a negative or null stride", "stride");
		}
		if ((target & Target.Index) != 0 && stride != 2 && stride != 4)
		{
			throw new ArgumentException("Attempting to create an index buffer with an invalid stride: " + stride, "stride");
		}
		if (!IsVertexIndexOrCopyOnly(target) && stride % 4 != 0)
		{
			throw new ArgumentException("Stride must be a multiple of 4 unless the buffer is only used as a vertex buffer and/or index buffer ", "stride");
		}
		long num = (long)count * (long)stride;
		long maxGraphicsBufferSize = SystemInfo.maxGraphicsBufferSize;
		if (num > maxGraphicsBufferSize)
		{
			throw new ArgumentException($"The total size of the graphics buffer ({num} bytes) exceeds the maximum buffer size. Maximum supported buffer size: {maxGraphicsBufferSize} bytes.");
		}
		if ((usageFlags & UsageFlags.LockBufferForWrite) != UsageFlags.None && (target & Target.CopyDestination) != 0)
		{
			throw new ArgumentException("Attempting to create a LockBufferForWrite capable buffer that can be copied into. LockBufferForWrite buffers are read-only on the GPU.");
		}
		m_Ptr = InitBuffer(target, usageFlags, count, stride);
	}

	public void Release()
	{
		Dispose();
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GraphicsBuffer_Bindings::IsValidBuffer")]
	private static extern bool IsValidBuffer(GraphicsBuffer buf);

	public bool IsValid()
	{
		return m_Ptr != IntPtr.Zero && IsValidBuffer(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::GetUsageFlags", HasExplicitThis = true)]
	private extern UsageFlags GetUsageFlags();

	public void SetData(Array data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to GraphicsBuffer.SetData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
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
			throw new ArgumentException($"List<{typeof(T)}> passed to GraphicsBuffer.SetData(List<>) must be blittable.\n{UnsafeUtility.GetReasonForGenericListNonBlittable<T>()}");
		}
		InternalSetData(NoAllocHelpers.ExtractArrayFromList(data), 0, 0, NoAllocHelpers.SafeLength(data), Marshal.SizeOf(typeof(T)));
	}

	public unsafe void SetData<T>(NativeArray<T> data) where T : struct
	{
		InternalSetNativeData((IntPtr)data.GetUnsafeReadOnlyPtr(), 0, 0, data.Length, UnsafeUtility.SizeOf<T>());
	}

	public void SetData(Array data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to GraphicsBuffer.SetData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
		}
		if (managedBufferStartIndex < 0 || graphicsBufferStartIndex < 0 || count < 0 || managedBufferStartIndex + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (managedBufferStartIndex:{managedBufferStartIndex} graphicsBufferStartIndex:{graphicsBufferStartIndex} count:{count})");
		}
		InternalSetData(data, managedBufferStartIndex, graphicsBufferStartIndex, count, Marshal.SizeOf(data.GetType().GetElementType()));
	}

	public void SetData<T>(List<T> data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count) where T : struct
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsGenericListBlittable<T>())
		{
			throw new ArgumentException($"List<{typeof(T)}> passed to GraphicsBuffer.SetData(List<>) must be blittable.\n{UnsafeUtility.GetReasonForGenericListNonBlittable<T>()}");
		}
		if (managedBufferStartIndex < 0 || graphicsBufferStartIndex < 0 || count < 0 || managedBufferStartIndex + count > data.Count)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (managedBufferStartIndex:{managedBufferStartIndex} graphicsBufferStartIndex:{graphicsBufferStartIndex} count:{count})");
		}
		InternalSetData(NoAllocHelpers.ExtractArrayFromList(data), managedBufferStartIndex, graphicsBufferStartIndex, count, Marshal.SizeOf(typeof(T)));
	}

	public unsafe void SetData<T>(NativeArray<T> data, int nativeBufferStartIndex, int graphicsBufferStartIndex, int count) where T : struct
	{
		if (nativeBufferStartIndex < 0 || graphicsBufferStartIndex < 0 || count < 0 || nativeBufferStartIndex + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (nativeBufferStartIndex:{nativeBufferStartIndex} graphicsBufferStartIndex:{graphicsBufferStartIndex} count:{count})");
		}
		InternalSetNativeData((IntPtr)data.GetUnsafeReadOnlyPtr(), nativeBufferStartIndex, graphicsBufferStartIndex, count, UnsafeUtility.SizeOf<T>());
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::InternalSetNativeData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetNativeData(IntPtr data, int nativeBufferStartIndex, int graphicsBufferStartIndex, int count, int elemSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::InternalSetData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetData(Array data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count, int elemSize);

	public void GetData(Array data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to GraphicsBuffer.GetData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
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
			throw new ArgumentException($"Array passed to GraphicsBuffer.GetData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
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
	[FreeFunction(Name = "GraphicsBuffer_Bindings::InternalGetNativeBufferPtr", HasExplicitThis = true)]
	public extern IntPtr GetNativeBufferPtr();

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe extern void* BeginBufferWrite(int offset = 0, int size = 0);

	public unsafe NativeArray<T> LockBufferForWrite<T>(int bufferStartIndex, int count) where T : struct
	{
		if (!IsValid())
		{
			throw new InvalidOperationException("LockBufferForWrite requires a valid GraphicsBuffer");
		}
		if ((usageFlags & UsageFlags.LockBufferForWrite) == 0)
		{
			throw new InvalidOperationException("GraphicsBuffer must be created with usage mode UsageFlage.LockBufferForWrite to use LockBufferForWrite");
		}
		int num = UnsafeUtility.SizeOf<T>();
		if (bufferStartIndex < 0 || count < 0 || (bufferStartIndex + count) * num > this.count * stride)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (bufferStartIndex:{bufferStartIndex} count:{count} elementSize:{num}, this.count:{this.count}, this.stride{stride})");
		}
		void* dataPointer = BeginBufferWrite(bufferStartIndex * num, count * num);
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>(dataPointer, count, Allocator.Invalid);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void EndBufferWrite(int bytesWritten = 0);

	public void UnlockBufferAfterWrite<T>(int countWritten) where T : struct
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
	[FreeFunction(Name = "GraphicsBuffer_Bindings::CopyCount")]
	private static extern void CopyCountCC(ComputeBuffer src, ComputeBuffer dst, int dstOffsetBytes);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::CopyCount")]
	private static extern void CopyCountGC(GraphicsBuffer src, ComputeBuffer dst, int dstOffsetBytes);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::CopyCount")]
	private static extern void CopyCountCG(ComputeBuffer src, GraphicsBuffer dst, int dstOffsetBytes);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::CopyCount")]
	private static extern void CopyCountGG(GraphicsBuffer src, GraphicsBuffer dst, int dstOffsetBytes);

	public static void CopyCount(ComputeBuffer src, ComputeBuffer dst, int dstOffsetBytes)
	{
		CopyCountCC(src, dst, dstOffsetBytes);
	}

	public static void CopyCount(GraphicsBuffer src, ComputeBuffer dst, int dstOffsetBytes)
	{
		CopyCountGC(src, dst, dstOffsetBytes);
	}

	public static void CopyCount(ComputeBuffer src, GraphicsBuffer dst, int dstOffsetBytes)
	{
		CopyCountCG(src, dst, dstOffsetBytes);
	}

	public static void CopyCount(GraphicsBuffer src, GraphicsBuffer dst, int dstOffsetBytes)
	{
		CopyCountGG(src, dst, dstOffsetBytes);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_bufferHandle_Injected(out GraphicsBufferHandle ret);
}
