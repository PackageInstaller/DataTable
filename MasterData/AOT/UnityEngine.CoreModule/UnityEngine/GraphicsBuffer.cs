using System;
using System.Runtime.CompilerServices;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[NativeHeader("Runtime/Shaders/GraphicsBuffer.h")]
[NativeHeader("Runtime/Export/Graphics/GraphicsBuffer.bindings.h")]
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
		if ((usageFlags & UsageFlags.LockBufferForWrite) != 0 && (target & Target.CopyDestination) != 0)
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

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GraphicsBuffer_Bindings::InternalSetData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetData(Array data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count, int elemSize);
}
