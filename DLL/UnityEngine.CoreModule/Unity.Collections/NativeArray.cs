using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs;
using UnityEngine.Internal;

namespace Unity.Collections;

[NativeContainerSupportsMinMaxWriteRestriction]
[NativeContainerSupportsDeferredConvertListToArray]
[NativeContainerSupportsDeallocateOnJobCompletion]
[NativeContainer]
[DebuggerDisplay("Length = {Length}")]
[DebuggerTypeProxy(typeof(NativeArrayDebugView<>))]
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

	[DefaultMember("Item")]
	[DebuggerTypeProxy(typeof(NativeArrayReadOnlyDebugView<>))]
	[NativeContainerIsReadOnly]
	[NativeContainer]
	[DebuggerDisplay("Length = {Length}")]
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

	private unsafe static void Allocate(int length, Allocator allocator, out NativeArray<T> array)
	{
		long size = (long)UnsafeUtility.SizeOf<T>() * (long)length;
		array = default(NativeArray<T>);
		array.m_Buffer = UnsafeUtility.Malloc(size, UnsafeUtility.AlignOf<T>(), allocator);
		array.m_Length = length;
		array.m_AllocatorLabel = allocator;
	}

	[WriteAccessRequired]
	public unsafe void Dispose()
	{
		if (m_Buffer == null)
		{
			throw new ObjectDisposedException("The NativeArray is already disposed.");
		}
		if (m_AllocatorLabel == Allocator.Invalid)
		{
			throw new InvalidOperationException("The NativeArray can not be Disposed because it was not allocated with a valid allocator.");
		}
		if (m_AllocatorLabel > Allocator.None)
		{
			UnsafeUtility.Free(m_Buffer, m_AllocatorLabel);
			m_AllocatorLabel = Allocator.Invalid;
		}
		m_Buffer = null;
	}

	public unsafe JobHandle Dispose(JobHandle inputDeps)
	{
		if (m_AllocatorLabel == Allocator.Invalid)
		{
			throw new InvalidOperationException("The NativeArray can not be Disposed because it was not allocated with a valid allocator.");
		}
		if (m_Buffer == null)
		{
			throw new InvalidOperationException("The NativeArray is already disposed.");
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

	public static void Copy(NativeArray<T> src, NativeArray<T> dst)
	{
		Copy(src, 0, dst, 0, src.Length);
	}

	public static void Copy(T[] src, NativeArray<T> dst)
	{
		Copy(src, 0, dst, 0, src.Length);
	}

	public static void Copy(NativeArray<T> src, T[] dst)
	{
		Copy(src, 0, dst, 0, src.Length);
	}

	public static void Copy(NativeArray<T> src, NativeArray<T> dst, int length)
	{
		Copy(src, 0, dst, 0, length);
	}

	public static void Copy(NativeArray<T> src, T[] dst, int length)
	{
		Copy(src, 0, dst, 0, length);
	}

	public unsafe static void Copy(NativeArray<T> src, int srcIndex, NativeArray<T> dst, int dstIndex, int length)
	{
		UnsafeUtility.MemCpy((byte*)dst.m_Buffer + dstIndex * UnsafeUtility.SizeOf<T>(), (byte*)src.m_Buffer + srcIndex * UnsafeUtility.SizeOf<T>(), length * UnsafeUtility.SizeOf<T>());
	}

	public unsafe static void Copy(T[] src, int srcIndex, NativeArray<T> dst, int dstIndex, int length)
	{
		GCHandle gCHandle = GCHandle.Alloc(src, GCHandleType.Pinned);
		IntPtr intPtr = gCHandle.AddrOfPinnedObject();
		UnsafeUtility.MemCpy((byte*)dst.m_Buffer + dstIndex * UnsafeUtility.SizeOf<T>(), (byte*)(void*)intPtr + srcIndex * UnsafeUtility.SizeOf<T>(), length * UnsafeUtility.SizeOf<T>());
		gCHandle.Free();
	}

	public unsafe static void Copy(NativeArray<T> src, int srcIndex, T[] dst, int dstIndex, int length)
	{
		GCHandle gCHandle = GCHandle.Alloc(dst, GCHandleType.Pinned);
		IntPtr intPtr = gCHandle.AddrOfPinnedObject();
		UnsafeUtility.MemCpy((byte*)(void*)intPtr + dstIndex * UnsafeUtility.SizeOf<T>(), (byte*)src.m_Buffer + srcIndex * UnsafeUtility.SizeOf<T>(), length * UnsafeUtility.SizeOf<T>());
		gCHandle.Free();
	}

	private unsafe NativeArray<U> InternalReinterpret<U>(int length) where U : struct
	{
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<U>(m_Buffer, length, m_AllocatorLabel);
	}

	public NativeArray<U> Reinterpret<U>() where U : struct
	{
		return InternalReinterpret<U>(Length);
	}

	public NativeArray<U> Reinterpret<U>(int expectedTypeSize) where U : struct
	{
		long num = UnsafeUtility.SizeOf<T>();
		long num2 = UnsafeUtility.SizeOf<U>();
		long num3 = Length * num;
		long num4 = num3 / num2;
		return InternalReinterpret<U>((int)num4);
	}

	public unsafe NativeArray<T> GetSubArray(int start, int length)
	{
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>((byte*)m_Buffer + (long)UnsafeUtility.SizeOf<T>() * (long)start, length, Allocator.None);
	}

	public unsafe ReadOnly AsReadOnly()
	{
		return new ReadOnly(m_Buffer, m_Length);
	}
}
