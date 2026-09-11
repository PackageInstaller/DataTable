using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Burst;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs;
using UnityEngine.Internal;

namespace Unity.Collections;

[NativeContainerSupportsDeferredConvertListToArray]
[NativeContainer]
[DebuggerDisplay("Length = {m_Length}")]
[NativeContainerSupportsDeallocateOnJobCompletion]
[DebuggerTypeProxy(typeof(NativeArrayDebugView<>))]
[NativeContainerSupportsMinMaxWriteRestriction]
public struct NativeArray<T> : IDisposable, IEnumerable<T>, IEnumerable, IEquatable<NativeArray<T>> where T : struct
{
	[ExcludeFromDocs]
	public struct Enumerator(ref NativeArray<T> array) : IEnumerator<T>, IEnumerator, IDisposable
	{
		private NativeArray<T> m_Array = array;

		private int m_Index = -1;

		private T value = default(T);

		public T Current
		{
			[MethodImpl((MethodImplOptions)256)]
			get
			{
				return value;
			}
		}

		object IEnumerator.Current
		{
			[MethodImpl((MethodImplOptions)256)]
			get
			{
				return Current;
			}
		}

		public void Dispose()
		{
		}

		[MethodImpl((MethodImplOptions)256)]
		public unsafe bool MoveNext()
		{
			m_Index++;
			if (m_Index < m_Array.m_Length)
			{
				value = UnsafeUtility.ReadArrayElement<T>(m_Array.m_Buffer, m_Index);
				return true;
			}
			value = default(T);
			return false;
		}

		public void Reset()
		{
			m_Index = -1;
		}
	}

	[DebuggerTypeProxy(typeof(NativeArrayReadOnlyDebugView<>))]
	[NativeContainer]
	[DebuggerDisplay("Length = {Length}")]
	[NativeContainerIsReadOnly]
	public struct ReadOnly : IEnumerable<T>, IEnumerable
	{
		[ExcludeFromDocs]
		public struct Enumerator(in ReadOnly array) : IEnumerator<T>, IEnumerator, IDisposable
		{
			private ReadOnly m_Array = array;

			private int m_Index = -1;

			private T value = default(T);

			public T Current
			{
				[MethodImpl((MethodImplOptions)256)]
				get
				{
					return value;
				}
			}

			object IEnumerator.Current => Current;

			public void Dispose()
			{
			}

			[MethodImpl((MethodImplOptions)256)]
			public unsafe bool MoveNext()
			{
				m_Index++;
				if (m_Index < m_Array.m_Length)
				{
					value = UnsafeUtility.ReadArrayElement<T>(m_Array.m_Buffer, m_Index);
					return true;
				}
				value = default(T);
				return false;
			}

			public void Reset()
			{
				m_Index = -1;
			}
		}

		[NativeDisableUnsafePtrRestriction]
		internal unsafe void* m_Buffer;

		internal int m_Length;

		public int Length
		{
			[MethodImpl((MethodImplOptions)256)]
			get
			{
				return m_Length;
			}
		}

		public unsafe T this[int index]
		{
			[MethodImpl((MethodImplOptions)256)]
			get
			{
				return UnsafeUtility.ReadArrayElement<T>(m_Buffer, index);
			}
		}

		public unsafe bool IsCreated
		{
			[MethodImpl((MethodImplOptions)256)]
			get
			{
				return m_Buffer != null;
			}
		}

		internal unsafe ReadOnly(void* buffer, int length)
		{
			m_Buffer = buffer;
			m_Length = length;
		}

		public Enumerator GetEnumerator()
		{
			return new Enumerator(this);
		}

		IEnumerator<T> IEnumerable<T>.GetEnumerator()
		{
			return GetEnumerator();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}
	}

	[NativeDisableUnsafePtrRestriction]
	internal unsafe void* m_Buffer;

	internal int m_Length;

	internal Allocator m_AllocatorLabel;

	public int Length
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Length;
		}
	}

	public unsafe T this[int index]
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return UnsafeUtility.ReadArrayElement<T>(m_Buffer, index);
		}
		[MethodImpl((MethodImplOptions)256)]
		[WriteAccessRequired]
		set
		{
			UnsafeUtility.WriteArrayElement(m_Buffer, index, value);
		}
	}

	public unsafe bool IsCreated
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Buffer != null;
		}
	}

	public unsafe NativeArray(int length, Allocator allocator, NativeArrayOptions options = NativeArrayOptions.ClearMemory)
	{
		Allocate(length, allocator, out this);
		if ((options & NativeArrayOptions.ClearMemory) == NativeArrayOptions.ClearMemory)
		{
			UnsafeUtility.MemClear(m_Buffer, (long)Length * (long)UnsafeUtility.SizeOf<T>());
		}
	}

	public NativeArray(T[] array, Allocator allocator)
	{
		Allocate(array.Length, allocator, out this);
		Copy(array, this);
	}

	public NativeArray(NativeArray<T> array, Allocator allocator)
	{
		Allocate(array.Length, allocator, out this);
		Copy(array, 0, this, 0, array.Length);
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private static void CheckAllocateArguments(int length, Allocator allocator)
	{
		if (allocator <= Allocator.None)
		{
			throw new ArgumentException("Allocator must be Temp, TempJob or Persistent", "allocator");
		}
		if (allocator >= Allocator.FirstUserIndex)
		{
			throw new ArgumentException("Use CollectionHelper.CreateNativeArray for custom allocator", "allocator");
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", "Length must be >= 0");
		}
	}

	private unsafe static void Allocate(int length, Allocator allocator, out NativeArray<T> array)
	{
		long size = (long)UnsafeUtility.SizeOf<T>() * (long)length;
		array = default(NativeArray<T>);
		array.m_Buffer = UnsafeUtility.MallocTracked(size, UnsafeUtility.AlignOf<T>(), allocator, 0);
		array.m_Length = length;
		array.m_AllocatorLabel = allocator;
	}

	[BurstDiscard]
	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	internal static void IsUnmanagedAndThrow()
	{
		if (!UnsafeUtility.IsUnmanaged<T>())
		{
			throw new InvalidOperationException($"{typeof(T)} used in NativeArray<{typeof(T)}> must be unmanaged (contain no managed types).");
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private void CheckElementReadAccess(int index)
	{
	}

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private void CheckElementWriteAccess(int index)
	{
	}

	[WriteAccessRequired]
	public unsafe void Dispose()
	{
		if (IsCreated)
		{
			if (m_AllocatorLabel == Allocator.Invalid)
			{
				throw new InvalidOperationException("The NativeArray can not be Disposed because it was not allocated with a valid allocator.");
			}
			if (m_AllocatorLabel > Allocator.None)
			{
				UnsafeUtility.FreeTracked(m_Buffer, m_AllocatorLabel);
				m_AllocatorLabel = Allocator.Invalid;
			}
			m_Buffer = null;
		}
	}

	public unsafe JobHandle Dispose(JobHandle inputDeps)
	{
		if (!IsCreated)
		{
			return inputDeps;
		}
		if (m_AllocatorLabel >= Allocator.FirstUserIndex)
		{
			throw new InvalidOperationException("The NativeArray can not be Disposed because it was allocated with a custom allocator, use CollectionHelper.Dispose in com.unity.collections package.");
		}
		if (m_AllocatorLabel > Allocator.None)
		{
			JobHandle result = new NativeArrayDisposeJob
			{
				Data = new NativeArrayDispose
				{
					m_Buffer = m_Buffer,
					m_AllocatorLabel = m_AllocatorLabel
				}
			}.Schedule(inputDeps);
			m_Buffer = null;
			m_AllocatorLabel = Allocator.Invalid;
			return result;
		}
		m_Buffer = null;
		return inputDeps;
	}

	[WriteAccessRequired]
	public void CopyFrom(T[] array)
	{
		Copy(array, this);
	}

	[WriteAccessRequired]
	public void CopyFrom(NativeArray<T> array)
	{
		Copy(array, this);
	}

	public void CopyTo(T[] array)
	{
		Copy(this, array);
	}

	public void CopyTo(NativeArray<T> array)
	{
		Copy(this, array);
	}

	public T[] ToArray()
	{
		T[] array = new T[Length];
		Copy(this, array, Length);
		return array;
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(ref this);
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return new Enumerator(ref this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public unsafe bool Equals(NativeArray<T> other)
	{
		return m_Buffer == other.m_Buffer && m_Length == other.m_Length;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is NativeArray<T> && Equals((NativeArray<T>)obj);
	}

	public unsafe override int GetHashCode()
	{
		return ((int)m_Buffer * 397) ^ m_Length;
	}

	public static bool operator ==(NativeArray<T> left, NativeArray<T> right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(NativeArray<T> left, NativeArray<T> right)
	{
		return !left.Equals(right);
	}

	public static void Copy(NativeArray<T> src, NativeArray<T> dst)
	{
		CopySafe(src, 0, dst, 0, src.Length);
	}

	public static void Copy(ReadOnly src, NativeArray<T> dst)
	{
		CopySafe(src, 0, dst, 0, src.Length);
	}

	public static void Copy(T[] src, NativeArray<T> dst)
	{
		CopySafe(src, 0, dst, 0, src.Length);
	}

	public static void Copy(NativeArray<T> src, T[] dst)
	{
		CopySafe(src, 0, dst, 0, src.Length);
	}

	public static void Copy(ReadOnly src, T[] dst)
	{
		CopySafe(src, 0, dst, 0, src.Length);
	}

	public static void Copy(NativeArray<T> src, NativeArray<T> dst, int length)
	{
		CopySafe(src, 0, dst, 0, length);
	}

	public static void Copy(ReadOnly src, NativeArray<T> dst, int length)
	{
		CopySafe(src, 0, dst, 0, length);
	}

	public static void Copy(T[] src, NativeArray<T> dst, int length)
	{
		CopySafe(src, 0, dst, 0, length);
	}

	public static void Copy(NativeArray<T> src, T[] dst, int length)
	{
		CopySafe(src, 0, dst, 0, length);
	}

	public static void Copy(ReadOnly src, T[] dst, int length)
	{
		CopySafe(src, 0, dst, 0, length);
	}

	public static void Copy(NativeArray<T> src, int srcIndex, NativeArray<T> dst, int dstIndex, int length)
	{
		CopySafe(src, srcIndex, dst, dstIndex, length);
	}

	public static void Copy(ReadOnly src, int srcIndex, NativeArray<T> dst, int dstIndex, int length)
	{
		CopySafe(src, srcIndex, dst, dstIndex, length);
	}

	public static void Copy(T[] src, int srcIndex, NativeArray<T> dst, int dstIndex, int length)
	{
		CopySafe(src, srcIndex, dst, dstIndex, length);
	}

	public static void Copy(NativeArray<T> src, int srcIndex, T[] dst, int dstIndex, int length)
	{
		CopySafe(src, srcIndex, dst, dstIndex, length);
	}

	public static void Copy(ReadOnly src, int srcIndex, T[] dst, int dstIndex, int length)
	{
		CopySafe(src, srcIndex, dst, dstIndex, length);
	}

	private unsafe static void CopySafe(NativeArray<T> src, int srcIndex, NativeArray<T> dst, int dstIndex, int length)
	{
		UnsafeUtility.MemCpy((byte*)dst.m_Buffer + dstIndex * UnsafeUtility.SizeOf<T>(), (byte*)src.m_Buffer + srcIndex * UnsafeUtility.SizeOf<T>(), length * UnsafeUtility.SizeOf<T>());
	}

	private unsafe static void CopySafe(ReadOnly src, int srcIndex, NativeArray<T> dst, int dstIndex, int length)
	{
		UnsafeUtility.MemCpy((byte*)dst.m_Buffer + dstIndex * UnsafeUtility.SizeOf<T>(), (byte*)src.m_Buffer + srcIndex * UnsafeUtility.SizeOf<T>(), length * UnsafeUtility.SizeOf<T>());
	}

	private unsafe static void CopySafe(T[] src, int srcIndex, NativeArray<T> dst, int dstIndex, int length)
	{
		GCHandle gCHandle = GCHandle.Alloc(src, GCHandleType.Pinned);
		IntPtr intPtr = gCHandle.AddrOfPinnedObject();
		UnsafeUtility.MemCpy((byte*)dst.m_Buffer + dstIndex * UnsafeUtility.SizeOf<T>(), (byte*)(void*)intPtr + srcIndex * UnsafeUtility.SizeOf<T>(), length * UnsafeUtility.SizeOf<T>());
		gCHandle.Free();
	}

	private unsafe static void CopySafe(NativeArray<T> src, int srcIndex, T[] dst, int dstIndex, int length)
	{
		GCHandle gCHandle = GCHandle.Alloc(dst, GCHandleType.Pinned);
		IntPtr intPtr = gCHandle.AddrOfPinnedObject();
		UnsafeUtility.MemCpy((byte*)(void*)intPtr + dstIndex * UnsafeUtility.SizeOf<T>(), (byte*)src.m_Buffer + srcIndex * UnsafeUtility.SizeOf<T>(), length * UnsafeUtility.SizeOf<T>());
		gCHandle.Free();
	}

	private unsafe static void CopySafe(ReadOnly src, int srcIndex, T[] dst, int dstIndex, int length)
	{
		GCHandle gCHandle = GCHandle.Alloc(dst, GCHandleType.Pinned);
		IntPtr intPtr = gCHandle.AddrOfPinnedObject();
		UnsafeUtility.MemCpy((byte*)(void*)intPtr + dstIndex * UnsafeUtility.SizeOf<T>(), (byte*)src.m_Buffer + srcIndex * UnsafeUtility.SizeOf<T>(), length * UnsafeUtility.SizeOf<T>());
		gCHandle.Free();
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private static void CheckCopyPtr(T[] ptr)
	{
		if (ptr == null)
		{
			throw new ArgumentNullException("ptr");
		}
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private static void CheckCopyLengths(int srcLength, int dstLength)
	{
		if (srcLength != dstLength)
		{
			throw new ArgumentException("source and destination length must be the same");
		}
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private static void CheckCopyArguments(int srcLength, int srcIndex, int dstLength, int dstIndex, int length)
	{
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", "length must be equal or greater than zero.");
		}
		if (srcIndex < 0 || srcIndex > srcLength || (srcIndex == srcLength && srcLength > 0))
		{
			throw new ArgumentOutOfRangeException("srcIndex", "srcIndex is outside the range of valid indexes for the source NativeArray.");
		}
		if (dstIndex < 0 || dstIndex > dstLength || (dstIndex == dstLength && dstLength > 0))
		{
			throw new ArgumentOutOfRangeException("dstIndex", "dstIndex is outside the range of valid indexes for the destination NativeArray.");
		}
		if (srcIndex + length > srcLength)
		{
			throw new ArgumentException("length is greater than the number of elements from srcIndex to the end of the source NativeArray.", "length");
		}
		if (srcIndex + length < 0)
		{
			throw new ArgumentException("srcIndex + length causes an integer overflow");
		}
		if (dstIndex + length > dstLength)
		{
			throw new ArgumentException("length is greater than the number of elements from dstIndex to the end of the destination NativeArray.", "length");
		}
		if (dstIndex + length < 0)
		{
			throw new ArgumentException("dstIndex + length causes an integer overflow");
		}
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private void CheckReinterpretLoadRange<U>(int sourceIndex) where U : struct
	{
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private void CheckReinterpretStoreRange<U>(int destIndex) where U : struct
	{
	}

	public unsafe U ReinterpretLoad<U>(int sourceIndex) where U : struct
	{
		byte* source = (byte*)m_Buffer + (long)UnsafeUtility.SizeOf<T>() * (long)sourceIndex;
		return UnsafeUtility.ReadArrayElement<U>(source, 0);
	}

	public unsafe void ReinterpretStore<U>(int destIndex, U data) where U : struct
	{
		byte* destination = (byte*)m_Buffer + (long)UnsafeUtility.SizeOf<T>() * (long)destIndex;
		UnsafeUtility.WriteArrayElement(destination, 0, data);
	}

	private unsafe NativeArray<U> InternalReinterpret<U>(int length) where U : struct
	{
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<U>(m_Buffer, length, m_AllocatorLabel);
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private static void CheckReinterpretSize<U>() where U : struct
	{
		if (UnsafeUtility.SizeOf<T>() != UnsafeUtility.SizeOf<U>())
		{
			throw new InvalidOperationException($"Types {typeof(T)} and {typeof(U)} are different sizes - direct reinterpretation is not possible. If this is what you intended, use Reinterpret(<type size>)");
		}
	}

	public NativeArray<U> Reinterpret<U>() where U : struct
	{
		return InternalReinterpret<U>(Length);
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private void CheckReinterpretSize<U>(long tSize, long uSize, int expectedTypeSize, long byteLen, long uLen)
	{
		if (tSize != expectedTypeSize)
		{
			throw new InvalidOperationException($"Type {typeof(T)} was expected to be {expectedTypeSize} but is {tSize} bytes");
		}
		if (uLen * uSize != byteLen)
		{
			throw new InvalidOperationException($"Types {typeof(T)} (array length {Length}) and {typeof(U)} cannot be aliased due to size constraints. The size of the types and lengths involved must line up.");
		}
	}

	public NativeArray<U> Reinterpret<U>(int expectedTypeSize) where U : struct
	{
		long num = UnsafeUtility.SizeOf<T>();
		long num2 = UnsafeUtility.SizeOf<U>();
		long num3 = Length * num;
		long num4 = num3 / num2;
		return InternalReinterpret<U>((int)num4);
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private void CheckGetSubArrayArguments(int start, int length)
	{
		if (start < 0)
		{
			throw new ArgumentOutOfRangeException("start", "start must be >= 0");
		}
		if (start + length > Length)
		{
			throw new ArgumentOutOfRangeException("length", $"sub array range {start}-{start + length - 1} is outside the range of the native array 0-{Length - 1}");
		}
		if (start + length < 0)
		{
			throw new ArgumentException($"sub array range {start}-{start + length - 1} caused an integer overflow and is outside the range of the native array 0-{Length - 1}");
		}
	}

	public unsafe NativeArray<T> GetSubArray(int start, int length)
	{
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>((byte*)m_Buffer + (long)UnsafeUtility.SizeOf<T>() * (long)start, length, Allocator.None);
	}

	public unsafe ReadOnly AsReadOnly()
	{
		return new ReadOnly(m_Buffer, m_Length);
	}

	[WriteAccessRequired]
	public unsafe readonly Span<T> AsSpan()
	{
		return new Span<T>(m_Buffer, m_Length);
	}

	public unsafe readonly ReadOnlySpan<T> AsReadOnlySpan()
	{
		return new ReadOnlySpan<T>(m_Buffer, m_Length);
	}

	public static implicit operator Span<T>(in NativeArray<T> source)
	{
		return source.AsSpan();
	}

	public static implicit operator ReadOnlySpan<T>(in NativeArray<T> source)
	{
		return source.AsReadOnlySpan();
	}
}
