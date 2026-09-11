using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Internal;

namespace Unity.Collections;

[DebuggerTypeProxy(typeof(NativeSliceDebugView<>))]
[NativeContainerSupportsMinMaxWriteRestriction]
[DebuggerDisplay("Length = {Length}")]
[NativeContainer]
public struct NativeSlice<T> : IEnumerable<T>, IEnumerable, IEquatable<NativeSlice<T>> where T : struct
{
	[ExcludeFromDocs]
	public struct Enumerator(ref NativeSlice<T> array) : IEnumerator<T>, IEnumerator, IDisposable
	{
		private NativeSlice<T> m_Array = array;

		private int m_Index = -1;

		public T Current => m_Array[m_Index];

		object IEnumerator.Current => Current;

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			m_Index++;
			return m_Index < m_Array.Length;
		}

		public void Reset()
		{
			m_Index = -1;
		}
	}

	[NativeDisableUnsafePtrRestriction]
	internal unsafe byte* m_Buffer;

	internal int m_Stride;

	internal int m_Length;

	public unsafe T this[int index]
	{
		get
		{
			return UnsafeUtility.ReadArrayElementWithStride<T>(m_Buffer, index, m_Stride);
		}
		[WriteAccessRequired]
		set
		{
			UnsafeUtility.WriteArrayElementWithStride(m_Buffer, index, m_Stride, value);
		}
	}

	public int Stride => m_Stride;

	public int Length => m_Length;

	public unsafe NativeSlice(NativeSlice<T> slice, int start, int length)
	{
		m_Stride = slice.m_Stride;
		m_Buffer = slice.m_Buffer + m_Stride * start;
		m_Length = length;
	}

	public NativeSlice(NativeArray<T> array)
		: this(array, 0, array.Length)
	{
	}

	public static implicit operator NativeSlice<T>(NativeArray<T> array)
	{
		return new NativeSlice<T>(array);
	}

	public unsafe NativeSlice(NativeArray<T> array, int start, int length)
	{
		m_Stride = UnsafeUtility.SizeOf<T>();
		byte* buffer = (byte*)array.m_Buffer + m_Stride * start;
		m_Buffer = buffer;
		m_Length = length;
	}

	public unsafe NativeSlice<U> SliceConvert<U>() where U : struct
	{
		int num = UnsafeUtility.SizeOf<U>();
		NativeSlice<U> result = default(NativeSlice<U>);
		result.m_Buffer = m_Buffer;
		result.m_Stride = num;
		result.m_Length = m_Length * m_Stride / num;
		return result;
	}

	[WriteAccessRequired]
	public unsafe void CopyFrom(NativeSlice<T> slice)
	{
		UnsafeUtility.MemCpyStride(this.GetUnsafePtr(), Stride, slice.GetUnsafeReadOnlyPtr(), slice.Stride, UnsafeUtility.SizeOf<T>(), m_Length);
	}

	[WriteAccessRequired]
	public unsafe void CopyFrom(T[] array)
	{
		GCHandle gCHandle = GCHandle.Alloc(array, GCHandleType.Pinned);
		IntPtr intPtr = gCHandle.AddrOfPinnedObject();
		int num = UnsafeUtility.SizeOf<T>();
		UnsafeUtility.MemCpyStride(this.GetUnsafePtr(), Stride, (void*)intPtr, num, num, m_Length);
		gCHandle.Free();
	}

	public unsafe void CopyTo(NativeArray<T> array)
	{
		int num = UnsafeUtility.SizeOf<T>();
		UnsafeUtility.MemCpyStride(array.GetUnsafePtr(), num, this.GetUnsafeReadOnlyPtr(), Stride, num, m_Length);
	}

	public unsafe void CopyTo(T[] array)
	{
		GCHandle gCHandle = GCHandle.Alloc(array, GCHandleType.Pinned);
		IntPtr intPtr = gCHandle.AddrOfPinnedObject();
		int num = UnsafeUtility.SizeOf<T>();
		UnsafeUtility.MemCpyStride((void*)intPtr, num, this.GetUnsafeReadOnlyPtr(), Stride, num, m_Length);
		gCHandle.Free();
	}

	public T[] ToArray()
	{
		T[] array = new T[Length];
		CopyTo(array);
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

	public unsafe bool Equals(NativeSlice<T> other)
	{
		return m_Buffer == other.m_Buffer && m_Stride == other.m_Stride && m_Length == other.m_Length;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is NativeSlice<T> && Equals((NativeSlice<T>)obj);
	}

	public unsafe override int GetHashCode()
	{
		int num = (int)m_Buffer;
		num = (num * 397) ^ m_Stride;
		return (num * 397) ^ m_Length;
	}
}
