using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;

namespace System;

[Serializable]
public abstract class Array : ICollection, IEnumerable, IList, IStructuralComparable, IStructuralEquatable, ICloneable
{
	private sealed class ArrayEnumerator : IEnumerator, ICloneable
	{
		private Array _array;

		private int _index;

		private int _endIndex;

		public object Current
		{
			get
			{
				if (_index < 0)
				{
					throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
				}
				if (_index >= _endIndex)
				{
					throw new InvalidOperationException("Enumeration already finished.");
				}
				if (_index == 0 && _array.GetType().GetElementType().IsPointer)
				{
					throw new NotSupportedException("Type is not supported.");
				}
				return _array.GetValueImpl(_index);
			}
		}

		internal ArrayEnumerator(Array array)
		{
			_array = array;
			_index = -1;
			_endIndex = array.Length;
		}

		public bool MoveNext()
		{
			if (_index < _endIndex)
			{
				_index++;
				return _index < _endIndex;
			}
			return false;
		}

		public void Reset()
		{
			_index = -1;
		}

		public object Clone()
		{
			return MemberwiseClone();
		}
	}

	[StructLayout(LayoutKind.Sequential)]
	private class RawData
	{
		public IntPtr Bounds;

		public IntPtr Count;

		public byte Data;
	}

	internal struct InternalEnumerator<T> : IEnumerator<T>, IDisposable, IEnumerator
	{
		private readonly Array array;

		private int idx;

		public T Current
		{
			get
			{
				if (idx == -2)
				{
					throw new InvalidOperationException("Enumeration has not started. Call MoveNext");
				}
				if (idx == -1)
				{
					throw new InvalidOperationException("Enumeration already finished");
				}
				return array.InternalArray__get_Item<T>(array.Length - 1 - idx);
			}
		}

		object IEnumerator.Current => Current;

		internal InternalEnumerator(Array array)
		{
			this.array = array;
			idx = -2;
		}

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			if (idx == -2)
			{
				idx = array.Length;
			}
			if (idx != -1)
			{
				return --idx != -1;
			}
			return false;
		}

		void IEnumerator.Reset()
		{
			idx = -2;
		}
	}

	internal class EmptyInternalEnumerator<T> : IEnumerator<T>, IDisposable, IEnumerator
	{
		public static readonly EmptyInternalEnumerator<T> Value = new EmptyInternalEnumerator<T>();

		public T Current
		{
			get
			{
				throw new InvalidOperationException("Enumeration has not started. Call MoveNext");
			}
		}

		object IEnumerator.Current => Current;

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			return false;
		}

		void IEnumerator.Reset()
		{
		}
	}

	private struct SorterObjectArray
	{
		private object[] keys;

		private object[] items;

		private IComparer comparer;

		internal SorterObjectArray(object[] keys, object[] items, IComparer comparer)
		{
			if (comparer == null)
			{
				comparer = Comparer.Default;
			}
			this.keys = keys;
			this.items = items;
			this.comparer = comparer;
		}

		internal void SwapIfGreaterWithItems(int a, int b)
		{
			if (a != b && comparer.Compare(keys[a], keys[b]) > 0)
			{
				object obj = keys[a];
				keys[a] = keys[b];
				keys[b] = obj;
				if (items != null)
				{
					object obj2 = items[a];
					items[a] = items[b];
					items[b] = obj2;
				}
			}
		}

		private void Swap(int i, int j)
		{
			object obj = keys[i];
			keys[i] = keys[j];
			keys[j] = obj;
			if (items != null)
			{
				object obj2 = items[i];
				items[i] = items[j];
				items[j] = obj2;
			}
		}

		internal void Sort(int left, int length)
		{
			IntrospectiveSort(left, length);
		}

		private void IntrospectiveSort(int left, int length)
		{
			if (length < 2)
			{
				return;
			}
			try
			{
				IntroSort(left, length + left - 1, 2 * IntrospectiveSortUtilities.FloorLog2PlusOne(keys.Length));
			}
			catch (IndexOutOfRangeException)
			{
				IntrospectiveSortUtilities.ThrowOrIgnoreBadComparer(comparer);
			}
			catch (Exception innerException)
			{
				throw new InvalidOperationException("Failed to compare two elements in the array.", innerException);
			}
		}

		private void IntroSort(int lo, int hi, int depthLimit)
		{
			while (hi > lo)
			{
				int num = hi - lo + 1;
				if (num <= 16)
				{
					switch (num)
					{
					case 1:
						break;
					case 2:
						SwapIfGreaterWithItems(lo, hi);
						break;
					case 3:
						SwapIfGreaterWithItems(lo, hi - 1);
						SwapIfGreaterWithItems(lo, hi);
						SwapIfGreaterWithItems(hi - 1, hi);
						break;
					default:
						InsertionSort(lo, hi);
						break;
					}
					break;
				}
				if (depthLimit == 0)
				{
					Heapsort(lo, hi);
					break;
				}
				depthLimit--;
				int num2 = PickPivotAndPartition(lo, hi);
				IntroSort(num2 + 1, hi, depthLimit);
				hi = num2 - 1;
			}
		}

		private int PickPivotAndPartition(int lo, int hi)
		{
			int num = lo + (hi - lo) / 2;
			SwapIfGreaterWithItems(lo, num);
			SwapIfGreaterWithItems(lo, hi);
			SwapIfGreaterWithItems(num, hi);
			object obj = keys[num];
			Swap(num, hi - 1);
			int num2 = lo;
			int num3 = hi - 1;
			while (num2 < num3)
			{
				while (comparer.Compare(keys[++num2], obj) < 0)
				{
				}
				while (comparer.Compare(obj, keys[--num3]) < 0)
				{
				}
				if (num2 >= num3)
				{
					break;
				}
				Swap(num2, num3);
			}
			Swap(num2, hi - 1);
			return num2;
		}

		private void Heapsort(int lo, int hi)
		{
			int num = hi - lo + 1;
			for (int num2 = num / 2; num2 >= 1; num2--)
			{
				DownHeap(num2, num, lo);
			}
			for (int num3 = num; num3 > 1; num3--)
			{
				Swap(lo, lo + num3 - 1);
				DownHeap(1, num3 - 1, lo);
			}
		}

		private void DownHeap(int i, int n, int lo)
		{
			object obj = keys[lo + i - 1];
			object obj2 = ((items != null) ? items[lo + i - 1] : null);
			while (i <= n / 2)
			{
				int num = 2 * i;
				if (num < n && comparer.Compare(keys[lo + num - 1], keys[lo + num]) < 0)
				{
					num++;
				}
				if (comparer.Compare(obj, keys[lo + num - 1]) >= 0)
				{
					break;
				}
				keys[lo + i - 1] = keys[lo + num - 1];
				if (items != null)
				{
					items[lo + i - 1] = items[lo + num - 1];
				}
				i = num;
			}
			keys[lo + i - 1] = obj;
			if (items != null)
			{
				items[lo + i - 1] = obj2;
			}
		}

		private void InsertionSort(int lo, int hi)
		{
			for (int i = lo; i < hi; i++)
			{
				int num = i;
				object obj = keys[i + 1];
				object obj2 = ((items != null) ? items[i + 1] : null);
				while (num >= lo && comparer.Compare(obj, keys[num]) < 0)
				{
					keys[num + 1] = keys[num];
					if (items != null)
					{
						items[num + 1] = items[num];
					}
					num--;
				}
				keys[num + 1] = obj;
				if (items != null)
				{
					items[num + 1] = obj2;
				}
			}
		}
	}

	private struct SorterGenericArray
	{
		private Array keys;

		private Array items;

		private IComparer comparer;

		internal SorterGenericArray(Array keys, Array items, IComparer comparer)
		{
			if (comparer == null)
			{
				comparer = Comparer.Default;
			}
			this.keys = keys;
			this.items = items;
			this.comparer = comparer;
		}

		internal void SwapIfGreaterWithItems(int a, int b)
		{
			if (a != b && comparer.Compare(keys.GetValue(a), keys.GetValue(b)) > 0)
			{
				object value = keys.GetValue(a);
				keys.SetValue(keys.GetValue(b), a);
				keys.SetValue(value, b);
				if (items != null)
				{
					object value2 = items.GetValue(a);
					items.SetValue(items.GetValue(b), a);
					items.SetValue(value2, b);
				}
			}
		}

		private void Swap(int i, int j)
		{
			object value = keys.GetValue(i);
			keys.SetValue(keys.GetValue(j), i);
			keys.SetValue(value, j);
			if (items != null)
			{
				object value2 = items.GetValue(i);
				items.SetValue(items.GetValue(j), i);
				items.SetValue(value2, j);
			}
		}

		internal void Sort(int left, int length)
		{
			IntrospectiveSort(left, length);
		}

		private void IntrospectiveSort(int left, int length)
		{
			if (length < 2)
			{
				return;
			}
			try
			{
				IntroSort(left, length + left - 1, 2 * IntrospectiveSortUtilities.FloorLog2PlusOne(keys.Length));
			}
			catch (IndexOutOfRangeException)
			{
				IntrospectiveSortUtilities.ThrowOrIgnoreBadComparer(comparer);
			}
			catch (Exception innerException)
			{
				throw new InvalidOperationException("Failed to compare two elements in the array.", innerException);
			}
		}

		private void IntroSort(int lo, int hi, int depthLimit)
		{
			while (hi > lo)
			{
				int num = hi - lo + 1;
				if (num <= 16)
				{
					switch (num)
					{
					case 1:
						break;
					case 2:
						SwapIfGreaterWithItems(lo, hi);
						break;
					case 3:
						SwapIfGreaterWithItems(lo, hi - 1);
						SwapIfGreaterWithItems(lo, hi);
						SwapIfGreaterWithItems(hi - 1, hi);
						break;
					default:
						InsertionSort(lo, hi);
						break;
					}
					break;
				}
				if (depthLimit == 0)
				{
					Heapsort(lo, hi);
					break;
				}
				depthLimit--;
				int num2 = PickPivotAndPartition(lo, hi);
				IntroSort(num2 + 1, hi, depthLimit);
				hi = num2 - 1;
			}
		}

		private int PickPivotAndPartition(int lo, int hi)
		{
			int num = lo + (hi - lo) / 2;
			SwapIfGreaterWithItems(lo, num);
			SwapIfGreaterWithItems(lo, hi);
			SwapIfGreaterWithItems(num, hi);
			object value = keys.GetValue(num);
			Swap(num, hi - 1);
			int num2 = lo;
			int num3 = hi - 1;
			while (num2 < num3)
			{
				while (comparer.Compare(keys.GetValue(++num2), value) < 0)
				{
				}
				while (comparer.Compare(value, keys.GetValue(--num3)) < 0)
				{
				}
				if (num2 >= num3)
				{
					break;
				}
				Swap(num2, num3);
			}
			Swap(num2, hi - 1);
			return num2;
		}

		private void Heapsort(int lo, int hi)
		{
			int num = hi - lo + 1;
			for (int num2 = num / 2; num2 >= 1; num2--)
			{
				DownHeap(num2, num, lo);
			}
			for (int num3 = num; num3 > 1; num3--)
			{
				Swap(lo, lo + num3 - 1);
				DownHeap(1, num3 - 1, lo);
			}
		}

		private void DownHeap(int i, int n, int lo)
		{
			object value = keys.GetValue(lo + i - 1);
			object value2 = ((items != null) ? items.GetValue(lo + i - 1) : null);
			while (i <= n / 2)
			{
				int num = 2 * i;
				if (num < n && comparer.Compare(keys.GetValue(lo + num - 1), keys.GetValue(lo + num)) < 0)
				{
					num++;
				}
				if (comparer.Compare(value, keys.GetValue(lo + num - 1)) >= 0)
				{
					break;
				}
				keys.SetValue(keys.GetValue(lo + num - 1), lo + i - 1);
				if (items != null)
				{
					items.SetValue(items.GetValue(lo + num - 1), lo + i - 1);
				}
				i = num;
			}
			keys.SetValue(value, lo + i - 1);
			if (items != null)
			{
				items.SetValue(value2, lo + i - 1);
			}
		}

		private void InsertionSort(int lo, int hi)
		{
			for (int i = lo; i < hi; i++)
			{
				int num = i;
				object value = keys.GetValue(i + 1);
				object value2 = ((items != null) ? items.GetValue(i + 1) : null);
				while (num >= lo && comparer.Compare(value, keys.GetValue(num)) < 0)
				{
					keys.SetValue(keys.GetValue(num), num + 1);
					if (items != null)
					{
						items.SetValue(items.GetValue(num), num + 1);
					}
					num--;
				}
				keys.SetValue(value, num + 1);
				if (items != null)
				{
					items.SetValue(value2, num + 1);
				}
			}
		}
	}

	int ICollection.Count => Length;

	bool IList.IsReadOnly => false;

	object IList.this[int index]
	{
		get
		{
			return GetValue(index);
		}
		set
		{
			SetValue(value, index);
		}
	}

	public long LongLength
	{
		get
		{
			long num = GetLength(0);
			for (int i = 1; i < Rank; i++)
			{
				num *= GetLength(i);
			}
			return num;
		}
	}

	public bool IsFixedSize => true;

	public bool IsReadOnly => false;

	public bool IsSynchronized => false;

	public object SyncRoot => this;

	public int Length
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			int num = GetLength(0);
			for (int i = 1; i < Rank; i++)
			{
				num *= GetLength(i);
			}
			return num;
		}
	}

	public int Rank
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			return GetRank();
		}
	}

	public static Array CreateInstance(Type elementType, params long[] lengths)
	{
		if (lengths == null)
		{
			throw new ArgumentNullException("lengths");
		}
		if (lengths.Length == 0)
		{
			throw new ArgumentException("Must provide at least one rank.");
		}
		int[] array = new int[lengths.Length];
		for (int i = 0; i < lengths.Length; i++)
		{
			long num = lengths[i];
			if (num > int.MaxValue || num < int.MinValue)
			{
				throw new ArgumentOutOfRangeException("len", "Arrays larger than 2GB are not supported.");
			}
			array[i] = (int)num;
		}
		return CreateInstance(elementType, array);
	}

	public static ReadOnlyCollection<T> AsReadOnly<T>(T[] array)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return new ReadOnlyCollection<T>(array);
	}

	public static void Resize<T>(ref T[] array, int newSize)
	{
		if (newSize < 0)
		{
			throw new ArgumentOutOfRangeException("newSize", "Non-negative number required.");
		}
		T[] array2 = array;
		if (array2 == null)
		{
			array = new T[newSize];
		}
		else if (array2.Length != newSize)
		{
			T[] array3 = new T[newSize];
			Copy(array2, 0, array3, 0, (array2.Length > newSize) ? newSize : array2.Length);
			array = array3;
		}
	}

	int IList.Add(object value)
	{
		throw new NotSupportedException("Collection was of a fixed size.");
	}

	bool IList.Contains(object value)
	{
		return IndexOf(this, value) >= 0;
	}

	void IList.Clear()
	{
		Clear(this, GetLowerBound(0), Length);
	}

	int IList.IndexOf(object value)
	{
		return IndexOf(this, value);
	}

	void IList.Insert(int index, object value)
	{
		throw new NotSupportedException("Collection was of a fixed size.");
	}

	void IList.Remove(object value)
	{
		throw new NotSupportedException("Collection was of a fixed size.");
	}

	void IList.RemoveAt(int index)
	{
		throw new NotSupportedException("Collection was of a fixed size.");
	}

	public void CopyTo(Array array, int index)
	{
		if (array != null && array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.");
		}
		Copy(this, GetLowerBound(0), array, index, Length);
	}

	public object Clone()
	{
		return MemberwiseClone();
	}

	int IStructuralComparable.CompareTo(object other, IComparer comparer)
	{
		if (other == null)
		{
			return 1;
		}
		if (!(other is Array array) || Length != array.Length)
		{
			throw new ArgumentException("Object is not a array with the same number of elements as the array to compare it to.", "other");
		}
		int i = 0;
		int num = 0;
		for (; i < array.Length; i++)
		{
			if (num != 0)
			{
				break;
			}
			object value = GetValue(i);
			object value2 = array.GetValue(i);
			num = comparer.Compare(value, value2);
		}
		return num;
	}

	bool IStructuralEquatable.Equals(object other, IEqualityComparer comparer)
	{
		if (other == null)
		{
			return false;
		}
		if (this == other)
		{
			return true;
		}
		if (!(other is Array array) || array.Length != Length)
		{
			return false;
		}
		for (int i = 0; i < array.Length; i++)
		{
			object value = GetValue(i);
			object value2 = array.GetValue(i);
			if (!comparer.Equals(value, value2))
			{
				return false;
			}
		}
		return true;
	}

	internal static int CombineHashCodes(int h1, int h2)
	{
		return ((h1 << 5) + h1) ^ h2;
	}

	int IStructuralEquatable.GetHashCode(IEqualityComparer comparer)
	{
		if (comparer == null)
		{
			throw new ArgumentNullException("comparer");
		}
		int num = 0;
		for (int i = ((Length >= 8) ? (Length - 8) : 0); i < Length; i++)
		{
			num = CombineHashCodes(num, comparer.GetHashCode(GetValue(i)));
		}
		return num;
	}

	public static int BinarySearch(Array array, object value)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return BinarySearch(array, array.GetLowerBound(0), array.Length, value, null);
	}

	public static TOutput[] ConvertAll<TInput, TOutput>(TInput[] array, Converter<TInput, TOutput> converter)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (converter == null)
		{
			throw new ArgumentNullException("converter");
		}
		TOutput[] array2 = new TOutput[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			array2[i] = converter(array[i]);
		}
		return array2;
	}

	public static void Copy(Array sourceArray, Array destinationArray, long length)
	{
		if (length > int.MaxValue || length < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("length", "Arrays larger than 2GB are not supported.");
		}
		Copy(sourceArray, destinationArray, (int)length);
	}

	public static void Copy(Array sourceArray, long sourceIndex, Array destinationArray, long destinationIndex, long length)
	{
		if (sourceIndex > int.MaxValue || sourceIndex < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("sourceIndex", "Arrays larger than 2GB are not supported.");
		}
		if (destinationIndex > int.MaxValue || destinationIndex < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("destinationIndex", "Arrays larger than 2GB are not supported.");
		}
		if (length > int.MaxValue || length < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("length", "Arrays larger than 2GB are not supported.");
		}
		Copy(sourceArray, (int)sourceIndex, destinationArray, (int)destinationIndex, (int)length);
	}

	public void CopyTo(Array array, long index)
	{
		if (index > int.MaxValue || index < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index", "Arrays larger than 2GB are not supported.");
		}
		CopyTo(array, (int)index);
	}

	public static void ForEach<T>(T[] array, Action<T> action)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		for (int i = 0; i < array.Length; i++)
		{
			action(array[i]);
		}
	}

	public long GetLongLength(int dimension)
	{
		return GetLength(dimension);
	}

	public object GetValue(long index)
	{
		if (index > int.MaxValue || index < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index", "Arrays larger than 2GB are not supported.");
		}
		return GetValue((int)index);
	}

	public object GetValue(long index1, long index2)
	{
		if (index1 > int.MaxValue || index1 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index1", "Arrays larger than 2GB are not supported.");
		}
		if (index2 > int.MaxValue || index2 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index2", "Arrays larger than 2GB are not supported.");
		}
		return GetValue((int)index1, (int)index2);
	}

	public object GetValue(long index1, long index2, long index3)
	{
		if (index1 > int.MaxValue || index1 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index1", "Arrays larger than 2GB are not supported.");
		}
		if (index2 > int.MaxValue || index2 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index2", "Arrays larger than 2GB are not supported.");
		}
		if (index3 > int.MaxValue || index3 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index3", "Arrays larger than 2GB are not supported.");
		}
		return GetValue((int)index1, (int)index2, (int)index3);
	}

	public object GetValue(params long[] indices)
	{
		if (indices == null)
		{
			throw new ArgumentNullException("indices");
		}
		if (Rank != indices.Length)
		{
			throw new ArgumentException("Indices length does not match the array rank.");
		}
		int[] array = new int[indices.Length];
		for (int i = 0; i < indices.Length; i++)
		{
			long num = indices[i];
			if (num > int.MaxValue || num < int.MinValue)
			{
				throw new ArgumentOutOfRangeException("index", "Arrays larger than 2GB are not supported.");
			}
			array[i] = (int)num;
		}
		return GetValue(array);
	}

	public static int BinarySearch(Array array, int index, int length, object value)
	{
		return BinarySearch(array, index, length, value, null);
	}

	public static int BinarySearch(Array array, object value, IComparer comparer)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return BinarySearch(array, array.GetLowerBound(0), array.Length, value, comparer);
	}

	public static int BinarySearch(Array array, int index, int length, object value, IComparer comparer)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0 || length < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "length", "Non-negative number required.");
		}
		if (array.Length - index < length)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (array.Rank != 1)
		{
			throw new RankException("Only single dimension arrays are supported here.");
		}
		if (comparer == null)
		{
			comparer = Comparer.Default;
		}
		int num = index;
		int num2 = index + length - 1;
		if (array is object[] array2)
		{
			while (num <= num2)
			{
				int median = GetMedian(num, num2);
				int num3;
				try
				{
					num3 = comparer.Compare(array2[median], value);
				}
				catch (Exception innerException)
				{
					throw new InvalidOperationException("Failed to compare two elements in the array.", innerException);
				}
				if (num3 == 0)
				{
					return median;
				}
				if (num3 < 0)
				{
					num = median + 1;
				}
				else
				{
					num2 = median - 1;
				}
			}
		}
		else
		{
			while (num <= num2)
			{
				int median2 = GetMedian(num, num2);
				int num4;
				try
				{
					num4 = comparer.Compare(array.GetValue(median2), value);
				}
				catch (Exception innerException2)
				{
					throw new InvalidOperationException("Failed to compare two elements in the array.", innerException2);
				}
				if (num4 == 0)
				{
					return median2;
				}
				if (num4 < 0)
				{
					num = median2 + 1;
				}
				else
				{
					num2 = median2 - 1;
				}
			}
		}
		return ~num;
	}

	private static int GetMedian(int low, int hi)
	{
		return low + (hi - low >> 1);
	}

	public static int BinarySearch<T>(T[] array, T value)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return BinarySearch(array, 0, array.Length, value, null);
	}

	public static int BinarySearch<T>(T[] array, T value, IComparer<T> comparer)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return BinarySearch(array, 0, array.Length, value, comparer);
	}

	public static int BinarySearch<T>(T[] array, int index, int length, T value)
	{
		return BinarySearch(array, index, length, value, null);
	}

	public static int BinarySearch<T>(T[] array, int index, int length, T value, IComparer<T> comparer)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0 || length < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "length", "Non-negative number required.");
		}
		if (array.Length - index < length)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		return ArraySortHelper<T>.Default.BinarySearch(array, index, length, value, comparer);
	}

	public static int IndexOf(Array array, object value)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return IndexOf(array, value, array.GetLowerBound(0), array.Length);
	}

	public static int IndexOf(Array array, object value, int startIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		int lowerBound = array.GetLowerBound(0);
		return IndexOf(array, value, startIndex, array.Length - startIndex + lowerBound);
	}

	public static int IndexOf(Array array, object value, int startIndex, int count)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Rank != 1)
		{
			throw new RankException("Only single dimension arrays are supported here.");
		}
		int lowerBound = array.GetLowerBound(0);
		if (startIndex < lowerBound || startIndex > array.Length + lowerBound)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || count > array.Length - startIndex + lowerBound)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		object[] array2 = array as object[];
		int num = startIndex + count;
		if (array2 != null)
		{
			if (value == null)
			{
				for (int i = startIndex; i < num; i++)
				{
					if (array2[i] == null)
					{
						return i;
					}
				}
			}
			else
			{
				for (int j = startIndex; j < num; j++)
				{
					object obj = array2[j];
					if (obj != null && obj.Equals(value))
					{
						return j;
					}
				}
			}
		}
		else
		{
			for (int k = startIndex; k < num; k++)
			{
				object value2 = array.GetValue(k);
				if (value2 == null)
				{
					if (value == null)
					{
						return k;
					}
				}
				else if (value2.Equals(value))
				{
					return k;
				}
			}
		}
		return lowerBound - 1;
	}

	public static int IndexOf<T>(T[] array, T value)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return IndexOfImpl(array, value, 0, array.Length);
	}

	public static int IndexOf<T>(T[] array, T value, int startIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return IndexOf(array, value, startIndex, array.Length - startIndex);
	}

	public static int IndexOf<T>(T[] array, T value, int startIndex, int count)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (startIndex < 0 || startIndex > array.Length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || count > array.Length - startIndex)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		return IndexOfImpl(array, value, startIndex, count);
	}

	public static int LastIndexOf(Array array, object value)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return LastIndexOf(array, value, array.Length - 1, array.Length);
	}

	public static int LastIndexOf(Array array, object value, int startIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return LastIndexOf(array, value, startIndex, startIndex + 1);
	}

	public static int LastIndexOf(Array array, object value, int startIndex, int count)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Length == 0)
		{
			return -1;
		}
		if (startIndex < 0 || startIndex >= array.Length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		if (count > startIndex + 1)
		{
			throw new ArgumentOutOfRangeException("endIndex", "endIndex cannot be greater than startIndex.");
		}
		if (array.Rank != 1)
		{
			throw new RankException("Only single dimension arrays are supported here.");
		}
		object[] array2 = array as object[];
		int num = startIndex - count + 1;
		if (array2 != null)
		{
			if (value == null)
			{
				for (int num2 = startIndex; num2 >= num; num2--)
				{
					if (array2[num2] == null)
					{
						return num2;
					}
				}
			}
			else
			{
				for (int num3 = startIndex; num3 >= num; num3--)
				{
					object obj = array2[num3];
					if (obj != null && obj.Equals(value))
					{
						return num3;
					}
				}
			}
		}
		else
		{
			for (int num4 = startIndex; num4 >= num; num4--)
			{
				object value2 = array.GetValue(num4);
				if (value2 == null)
				{
					if (value == null)
					{
						return num4;
					}
				}
				else if (value2.Equals(value))
				{
					return num4;
				}
			}
		}
		return -1;
	}

	public static int LastIndexOf<T>(T[] array, T value)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return LastIndexOf(array, value, array.Length - 1, array.Length);
	}

	public static int LastIndexOf<T>(T[] array, T value, int startIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return LastIndexOf(array, value, startIndex, (array.Length != 0) ? (startIndex + 1) : 0);
	}

	public static int LastIndexOf<T>(T[] array, T value, int startIndex, int count)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Length == 0)
		{
			if (startIndex != -1 && startIndex != 0)
			{
				throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			if (count != 0)
			{
				throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
			}
			return -1;
		}
		if (startIndex < 0 || startIndex >= array.Length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || startIndex - count + 1 < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		return LastIndexOfImpl(array, value, startIndex, count);
	}

	public static void Reverse(Array array)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		Reverse(array, array.GetLowerBound(0), array.Length);
	}

	public static void Reverse(Array array, int index, int length)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		int lowerBound = array.GetLowerBound(0);
		if (index < lowerBound || length < 0)
		{
			throw new ArgumentOutOfRangeException((index < lowerBound) ? "index" : "length", "Non-negative number required.");
		}
		if (array.Length - (index - lowerBound) < length)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (array.Rank != 1)
		{
			throw new RankException("Only single dimension arrays are supported here.");
		}
		if (array is object[] array2)
		{
			Reverse(array2, index, length);
			return;
		}
		int num = index;
		int num2 = index + length - 1;
		while (num < num2)
		{
			object value = array.GetValue(num);
			array.SetValue(array.GetValue(num2), num);
			array.SetValue(value, num2);
			num++;
			num2--;
		}
	}

	public static void Reverse<T>(T[] array)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		Reverse(array, 0, array.Length);
	}

	public static void Reverse<T>(T[] array, int index, int length)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0 || length < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "length", "Non-negative number required.");
		}
		if (array.Length - index < length)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (length > 1)
		{
			ref T reference = ref Unsafe.Add(ref Unsafe.As<byte, T>(ref array.GetRawSzArrayData()), index);
			ref T reference2 = ref Unsafe.Add(ref Unsafe.Add(ref reference, length), -1);
			do
			{
				T val = reference;
				reference = reference2;
				reference2 = val;
				reference = ref Unsafe.Add(ref reference, 1);
				reference2 = ref Unsafe.Add(ref reference2, -1);
			}
			while (Unsafe.IsAddressLessThan(ref reference, ref reference2));
		}
	}

	public void SetValue(object value, long index)
	{
		if (index > int.MaxValue || index < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index", "Arrays larger than 2GB are not supported.");
		}
		SetValue(value, (int)index);
	}

	public void SetValue(object value, long index1, long index2)
	{
		if (index1 > int.MaxValue || index1 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index1", "Arrays larger than 2GB are not supported.");
		}
		if (index2 > int.MaxValue || index2 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index2", "Arrays larger than 2GB are not supported.");
		}
		SetValue(value, (int)index1, (int)index2);
	}

	public void SetValue(object value, long index1, long index2, long index3)
	{
		if (index1 > int.MaxValue || index1 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index1", "Arrays larger than 2GB are not supported.");
		}
		if (index2 > int.MaxValue || index2 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index2", "Arrays larger than 2GB are not supported.");
		}
		if (index3 > int.MaxValue || index3 < int.MinValue)
		{
			throw new ArgumentOutOfRangeException("index3", "Arrays larger than 2GB are not supported.");
		}
		SetValue(value, (int)index1, (int)index2, (int)index3);
	}

	public void SetValue(object value, params long[] indices)
	{
		if (indices == null)
		{
			throw new ArgumentNullException("indices");
		}
		if (Rank != indices.Length)
		{
			throw new ArgumentException("Indices length does not match the array rank.");
		}
		int[] array = new int[indices.Length];
		for (int i = 0; i < indices.Length; i++)
		{
			long num = indices[i];
			if (num > int.MaxValue || num < int.MinValue)
			{
				throw new ArgumentOutOfRangeException("index", "Arrays larger than 2GB are not supported.");
			}
			array[i] = (int)num;
		}
		SetValue(value, array);
	}

	public static void Sort(Array array)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		Sort(array, null, array.GetLowerBound(0), array.Length, null);
	}

	public static void Sort(Array array, int index, int length)
	{
		Sort(array, null, index, length, null);
	}

	public static void Sort(Array array, IComparer comparer)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		Sort(array, null, array.GetLowerBound(0), array.Length, comparer);
	}

	public static void Sort(Array array, int index, int length, IComparer comparer)
	{
		Sort(array, null, index, length, comparer);
	}

	public static void Sort(Array keys, Array items)
	{
		if (keys == null)
		{
			throw new ArgumentNullException("keys");
		}
		Sort(keys, items, keys.GetLowerBound(0), keys.Length, null);
	}

	public static void Sort(Array keys, Array items, IComparer comparer)
	{
		if (keys == null)
		{
			throw new ArgumentNullException("keys");
		}
		Sort(keys, items, keys.GetLowerBound(0), keys.Length, comparer);
	}

	public static void Sort(Array keys, Array items, int index, int length)
	{
		Sort(keys, items, index, length, null);
	}

	public static void Sort(Array keys, Array items, int index, int length, IComparer comparer)
	{
		if (keys == null)
		{
			throw new ArgumentNullException("keys");
		}
		if (keys.Rank != 1 || (items != null && items.Rank != 1))
		{
			throw new RankException("Only single dimension arrays are supported here.");
		}
		int lowerBound = keys.GetLowerBound(0);
		if (items != null && lowerBound != items.GetLowerBound(0))
		{
			throw new ArgumentException("The arrays' lower bounds must be identical.");
		}
		if (index < lowerBound || length < 0)
		{
			throw new ArgumentOutOfRangeException((length < 0) ? "length" : "index", "Non-negative number required.");
		}
		if (keys.Length - (index - lowerBound) < length || (items != null && index - lowerBound > items.Length - length))
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (length > 1)
		{
			SortImpl(keys, items, index, length, comparer);
		}
	}

	public static void Sort<T>(T[] array)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		Sort(array, 0, array.Length, null);
	}

	public static void Sort<T>(T[] array, int index, int length)
	{
		Sort(array, index, length, null);
	}

	public static void Sort<T>(T[] array, IComparer<T> comparer)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		Sort(array, 0, array.Length, comparer);
	}

	public static void Sort<T>(T[] array, int index, int length, IComparer<T> comparer)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0 || length < 0)
		{
			throw new ArgumentOutOfRangeException((length < 0) ? "length" : "index", "Non-negative number required.");
		}
		if (array.Length - index < length)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (length > 1)
		{
			ArraySortHelper<T>.Default.Sort(array, index, length, comparer);
		}
	}

	public static void Sort<T>(T[] array, Comparison<T> comparison)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (comparison == null)
		{
			throw new ArgumentNullException("comparison");
		}
		ArraySortHelper<T>.Sort(array, 0, array.Length, comparison);
	}

	public static void Sort<TKey, TValue>(TKey[] keys, TValue[] items)
	{
		if (keys == null)
		{
			throw new ArgumentNullException("keys");
		}
		Sort(keys, items, 0, keys.Length, null);
	}

	public static void Sort<TKey, TValue>(TKey[] keys, TValue[] items, int index, int length)
	{
		Sort(keys, items, index, length, null);
	}

	public static void Sort<TKey, TValue>(TKey[] keys, TValue[] items, IComparer<TKey> comparer)
	{
		if (keys == null)
		{
			throw new ArgumentNullException("keys");
		}
		Sort(keys, items, 0, keys.Length, comparer);
	}

	public static void Sort<TKey, TValue>(TKey[] keys, TValue[] items, int index, int length, IComparer<TKey> comparer)
	{
		if (keys == null)
		{
			throw new ArgumentNullException("keys");
		}
		if (index < 0 || length < 0)
		{
			throw new ArgumentOutOfRangeException((length < 0) ? "length" : "index", "Non-negative number required.");
		}
		if (keys.Length - index < length || (items != null && index > items.Length - length))
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (length > 1)
		{
			if (items == null)
			{
				Sort(keys, index, length, comparer);
			}
			else
			{
				ArraySortHelper<TKey, TValue>.Default.Sort(keys, items, index, length, comparer);
			}
		}
	}

	public static bool Exists<T>(T[] array, Predicate<T> match)
	{
		return FindIndex(array, match) != -1;
	}

	public static void Fill<T>(T[] array, T value)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = value;
		}
	}

	public static void Fill<T>(T[] array, T value, int startIndex, int count)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (startIndex < 0 || startIndex > array.Length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || startIndex > array.Length - count)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		for (int i = startIndex; i < startIndex + count; i++)
		{
			array[i] = value;
		}
	}

	public static T Find<T>(T[] array, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (match == null)
		{
			throw new ArgumentNullException("match");
		}
		for (int i = 0; i < array.Length; i++)
		{
			if (match(array[i]))
			{
				return array[i];
			}
		}
		return default(T);
	}

	public static T[] FindAll<T>(T[] array, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (match == null)
		{
			throw new ArgumentNullException("match");
		}
		int num = 0;
		T[] array2 = Empty<T>();
		for (int i = 0; i < array.Length; i++)
		{
			if (match(array[i]))
			{
				if (num == array2.Length)
				{
					Resize(ref array2, Math.Min((num == 0) ? 4 : (num * 2), array.Length));
				}
				array2[num++] = array[i];
			}
		}
		if (num != array2.Length)
		{
			Resize(ref array2, num);
		}
		return array2;
	}

	public static int FindIndex<T>(T[] array, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return FindIndex(array, 0, array.Length, match);
	}

	public static int FindIndex<T>(T[] array, int startIndex, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return FindIndex(array, startIndex, array.Length - startIndex, match);
	}

	public static int FindIndex<T>(T[] array, int startIndex, int count, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (startIndex < 0 || startIndex > array.Length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || startIndex > array.Length - count)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		if (match == null)
		{
			throw new ArgumentNullException("match");
		}
		int num = startIndex + count;
		for (int i = startIndex; i < num; i++)
		{
			if (match(array[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public static T FindLast<T>(T[] array, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (match == null)
		{
			throw new ArgumentNullException("match");
		}
		for (int num = array.Length - 1; num >= 0; num--)
		{
			if (match(array[num]))
			{
				return array[num];
			}
		}
		return default(T);
	}

	public static int FindLastIndex<T>(T[] array, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return FindLastIndex(array, array.Length - 1, array.Length, match);
	}

	public static int FindLastIndex<T>(T[] array, int startIndex, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		return FindLastIndex(array, startIndex, startIndex + 1, match);
	}

	public static int FindLastIndex<T>(T[] array, int startIndex, int count, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (match == null)
		{
			throw new ArgumentNullException("match");
		}
		if (array.Length == 0)
		{
			if (startIndex != -1)
			{
				throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
		}
		else if (startIndex < 0 || startIndex >= array.Length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || startIndex - count + 1 < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		int num = startIndex - count;
		for (int num2 = startIndex; num2 > num; num2--)
		{
			if (match(array[num2]))
			{
				return num2;
			}
		}
		return -1;
	}

	public static bool TrueForAll<T>(T[] array, Predicate<T> match)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (match == null)
		{
			throw new ArgumentNullException("match");
		}
		for (int i = 0; i < array.Length; i++)
		{
			if (!match(array[i]))
			{
				return false;
			}
		}
		return true;
	}

	public IEnumerator GetEnumerator()
	{
		return new ArrayEnumerator(this);
	}

	private Array()
	{
	}

	internal int InternalArray__ICollection_get_Count()
	{
		return Length;
	}

	internal bool InternalArray__ICollection_get_IsReadOnly()
	{
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal ref byte GetRawSzArrayData()
	{
		return ref Unsafe.As<RawData>(this).Data;
	}

	internal IEnumerator<T> InternalArray__IEnumerable_GetEnumerator<T>()
	{
		if (Length == 0)
		{
			return EmptyInternalEnumerator<T>.Value;
		}
		return new InternalEnumerator<T>(this);
	}

	internal void InternalArray__ICollection_Clear()
	{
		throw new NotSupportedException("Collection is read-only");
	}

	internal void InternalArray__ICollection_Add<T>(T item)
	{
		throw new NotSupportedException("Collection is of a fixed size");
	}

	internal bool InternalArray__ICollection_Remove<T>(T item)
	{
		throw new NotSupportedException("Collection is of a fixed size");
	}

	internal bool InternalArray__ICollection_Contains<T>(T item)
	{
		if (Rank > 1)
		{
			throw new RankException("Only single dimension arrays are supported.");
		}
		int length = Length;
		for (int i = 0; i < length; i++)
		{
			GetGenericValueImpl<T>(i, out var value);
			if (item == null)
			{
				if (value == null)
				{
					return true;
				}
			}
			else if (item.Equals(value))
			{
				return true;
			}
		}
		return false;
	}

	internal void InternalArray__ICollection_CopyTo<T>(T[] array, int arrayIndex)
	{
		Copy(this, GetLowerBound(0), array, arrayIndex, Length);
	}

	internal T InternalArray__IReadOnlyList_get_Item<T>(int index)
	{
		if ((uint)index >= (uint)Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		GetGenericValueImpl<T>(index, out var value);
		return value;
	}

	internal int InternalArray__IReadOnlyCollection_get_Count()
	{
		return Length;
	}

	internal void InternalArray__Insert<T>(int index, T item)
	{
		throw new NotSupportedException("Collection is of a fixed size");
	}

	internal void InternalArray__RemoveAt(int index)
	{
		throw new NotSupportedException("Collection is of a fixed size");
	}

	internal int InternalArray__IndexOf<T>(T item)
	{
		if (Rank > 1)
		{
			throw new RankException("Only single dimension arrays are supported.");
		}
		int length = Length;
		for (int i = 0; i < length; i++)
		{
			GetGenericValueImpl<T>(i, out var value);
			if (item == null)
			{
				if (value == null)
				{
					return i + GetLowerBound(0);
				}
			}
			else if (value.Equals(item))
			{
				return i + GetLowerBound(0);
			}
		}
		return GetLowerBound(0) - 1;
	}

	internal T InternalArray__get_Item<T>(int index)
	{
		if ((uint)index >= (uint)Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		GetGenericValueImpl<T>(index, out var value);
		return value;
	}

	internal void InternalArray__set_Item<T>(int index, T item)
	{
		if ((uint)index >= (uint)Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		if (this is object[] array)
		{
			array[index] = item;
		}
		else
		{
			SetGenericValueImpl(index, ref item);
		}
	}

	internal void GetGenericValueImpl<T>(int pos, out T value)
	{
		throw new NotImplementedException("GetGenericValueImpl should be remapped to an intrinsic");
	}

	internal void SetGenericValueImpl<T>(int pos, ref T value)
	{
		throw new NotImplementedException("SetGenericValueImpl should be remapped to an intrinsic");
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern int GetRank();

	[MethodImpl((MethodImplOptions)4096)]
	public extern int GetLength(int dimension);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public extern int GetLowerBound(int dimension);

	[MethodImpl((MethodImplOptions)4096)]
	public extern object GetValue(params int[] indices);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetValue(object value, params int[] indices);

	[MethodImpl((MethodImplOptions)4096)]
	internal extern object GetValueImpl(int pos);

	[MethodImpl((MethodImplOptions)4096)]
	internal extern void SetValueImpl(object value, int pos);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool FastCopy(Array source, int source_idx, Array dest, int dest_idx, int length);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern Array CreateInstanceImpl(Type elementType, int[] lengths, int[] bounds);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public int GetUpperBound(int dimension)
	{
		return GetLowerBound(dimension) + GetLength(dimension) - 1;
	}

	public object GetValue(int index)
	{
		if (Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.");
		}
		int lowerBound = GetLowerBound(0);
		if (index < lowerBound || index > GetUpperBound(0))
		{
			throw new IndexOutOfRangeException("Index has to be between upper and lower bound of the array.");
		}
		if (GetType().GetElementType().IsPointer)
		{
			throw new NotSupportedException("Type is not supported.");
		}
		return GetValueImpl(index - lowerBound);
	}

	public object GetValue(int index1, int index2)
	{
		int[] indices = new int[2] { index1, index2 };
		return GetValue(indices);
	}

	public object GetValue(int index1, int index2, int index3)
	{
		int[] indices = new int[3] { index1, index2, index3 };
		return GetValue(indices);
	}

	public void SetValue(object value, int index)
	{
		if (Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.");
		}
		int lowerBound = GetLowerBound(0);
		if (index < lowerBound || index > GetUpperBound(0))
		{
			throw new IndexOutOfRangeException("Index has to be >= lower bound and <= upper bound of the array.");
		}
		if (GetType().GetElementType().IsPointer)
		{
			throw new NotSupportedException("Type is not supported.");
		}
		SetValueImpl(value, index - lowerBound);
	}

	public void SetValue(object value, int index1, int index2)
	{
		int[] indices = new int[2] { index1, index2 };
		SetValue(value, indices);
	}

	public void SetValue(object value, int index1, int index2, int index3)
	{
		int[] indices = new int[3] { index1, index2, index3 };
		SetValue(value, indices);
	}

	internal static Array UnsafeCreateInstance(Type elementType, int[] lengths, int[] lowerBounds)
	{
		return CreateInstance(elementType, lengths, lowerBounds);
	}

	internal static Array UnsafeCreateInstance(Type elementType, int length1, int length2)
	{
		return CreateInstance(elementType, length1, length2);
	}

	internal static Array UnsafeCreateInstance(Type elementType, params int[] lengths)
	{
		return CreateInstance(elementType, lengths);
	}

	public static Array CreateInstance(Type elementType, int length)
	{
		int[] lengths = new int[1] { length };
		return CreateInstance(elementType, lengths);
	}

	public static Array CreateInstance(Type elementType, int length1, int length2)
	{
		int[] lengths = new int[2] { length1, length2 };
		return CreateInstance(elementType, lengths);
	}

	public static Array CreateInstance(Type elementType, int length1, int length2, int length3)
	{
		int[] lengths = new int[3] { length1, length2, length3 };
		return CreateInstance(elementType, lengths);
	}

	public static Array CreateInstance(Type elementType, params int[] lengths)
	{
		if (elementType == null)
		{
			throw new ArgumentNullException("elementType");
		}
		if (lengths == null)
		{
			throw new ArgumentNullException("lengths");
		}
		if (lengths.Length > 255)
		{
			throw new TypeLoadException();
		}
		int[] bounds = null;
		elementType = elementType.UnderlyingSystemType as RuntimeType;
		if (elementType == null)
		{
			throw new ArgumentException("Type must be a type provided by the runtime.", "elementType");
		}
		if (elementType.Equals(typeof(void)))
		{
			throw new NotSupportedException("Array type can not be void");
		}
		if (elementType.ContainsGenericParameters)
		{
			throw new NotSupportedException("Array type can not be an open generic type");
		}
		return CreateInstanceImpl(elementType, lengths, bounds);
	}

	public static Array CreateInstance(Type elementType, int[] lengths, int[] lowerBounds)
	{
		if (elementType == null)
		{
			throw new ArgumentNullException("elementType");
		}
		if (lengths == null)
		{
			throw new ArgumentNullException("lengths");
		}
		if (lowerBounds == null)
		{
			throw new ArgumentNullException("lowerBounds");
		}
		elementType = elementType.UnderlyingSystemType as RuntimeType;
		if (elementType == null)
		{
			throw new ArgumentException("Type must be a type provided by the runtime.", "elementType");
		}
		if (elementType.Equals(typeof(void)))
		{
			throw new NotSupportedException("Array type can not be void");
		}
		if (elementType.ContainsGenericParameters)
		{
			throw new NotSupportedException("Array type can not be an open generic type");
		}
		if (lengths.Length < 1)
		{
			throw new ArgumentException("Arrays must contain >= 1 elements.");
		}
		if (lengths.Length != lowerBounds.Length)
		{
			throw new ArgumentException("Arrays must be of same size.");
		}
		for (int i = 0; i < lowerBounds.Length; i++)
		{
			if (lengths[i] < 0)
			{
				throw new ArgumentOutOfRangeException("lengths", "Each value has to be >= 0.");
			}
			if ((long)lowerBounds[i] + (long)lengths[i] > int.MaxValue)
			{
				throw new ArgumentOutOfRangeException("lengths", "Length + bound must not exceed Int32.MaxValue.");
			}
		}
		if (lengths.Length > 255)
		{
			throw new TypeLoadException();
		}
		return CreateInstanceImpl(elementType, lengths, lowerBounds);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static void Clear(Array array, int index, int length)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (length < 0)
		{
			throw new IndexOutOfRangeException("length < 0");
		}
		int lowerBound = array.GetLowerBound(0);
		if (index < lowerBound)
		{
			throw new IndexOutOfRangeException("index < lower bound");
		}
		index -= lowerBound;
		if (index > array.Length - length)
		{
			throw new IndexOutOfRangeException("index + length > size");
		}
		ClearInternal(array, index, length);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ClearInternal(Array a, int index, int count);

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public static void Copy(Array sourceArray, Array destinationArray, int length)
	{
		if (sourceArray == null)
		{
			throw new ArgumentNullException("sourceArray");
		}
		if (destinationArray == null)
		{
			throw new ArgumentNullException("destinationArray");
		}
		Copy(sourceArray, sourceArray.GetLowerBound(0), destinationArray, destinationArray.GetLowerBound(0), length);
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public static void Copy(Array sourceArray, int sourceIndex, Array destinationArray, int destinationIndex, int length)
	{
		if (sourceArray == null)
		{
			throw new ArgumentNullException("sourceArray");
		}
		if (destinationArray == null)
		{
			throw new ArgumentNullException("destinationArray");
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", "Value has to be >= 0.");
		}
		if (sourceArray.Rank != destinationArray.Rank)
		{
			throw new RankException("Only single dimension arrays are supported here.");
		}
		if (sourceIndex < 0)
		{
			throw new ArgumentOutOfRangeException("sourceIndex", "Value has to be >= 0.");
		}
		if (destinationIndex < 0)
		{
			throw new ArgumentOutOfRangeException("destinationIndex", "Value has to be >= 0.");
		}
		if (FastCopy(sourceArray, sourceIndex, destinationArray, destinationIndex, length))
		{
			return;
		}
		int num = sourceIndex - sourceArray.GetLowerBound(0);
		int num2 = destinationIndex - destinationArray.GetLowerBound(0);
		if (num2 < 0)
		{
			throw new ArgumentOutOfRangeException("destinationIndex", "Index was less than the array's lower bound in the first dimension.");
		}
		if (num > sourceArray.Length - length)
		{
			throw new ArgumentException("length");
		}
		if (num2 > destinationArray.Length - length)
		{
			throw new ArgumentException("Destination array was not long enough. Check destIndex and length, and the array's lower bounds", "destinationArray");
		}
		Type elementType = sourceArray.GetType().GetElementType();
		Type elementType2 = destinationArray.GetType().GetElementType();
		bool isValueType = elementType2.IsValueType;
		if (sourceArray != destinationArray || num > num2)
		{
			for (int i = 0; i < length; i++)
			{
				object valueImpl = sourceArray.GetValueImpl(num + i);
				if ((valueImpl == null) & isValueType)
				{
					throw new InvalidCastException();
				}
				try
				{
					destinationArray.SetValueImpl(valueImpl, num2 + i);
				}
				catch (ArgumentException)
				{
					throw CreateArrayTypeMismatchException();
				}
				catch (InvalidCastException)
				{
					if (CanAssignArrayElement(elementType, elementType2))
					{
						throw;
					}
					throw CreateArrayTypeMismatchException();
				}
			}
			return;
		}
		for (int num3 = length - 1; num3 >= 0; num3--)
		{
			object valueImpl2 = sourceArray.GetValueImpl(num + num3);
			try
			{
				destinationArray.SetValueImpl(valueImpl2, num2 + num3);
			}
			catch (ArgumentException)
			{
				throw CreateArrayTypeMismatchException();
			}
			catch
			{
				if (CanAssignArrayElement(elementType, elementType2))
				{
					throw;
				}
				throw CreateArrayTypeMismatchException();
			}
		}
	}

	private static ArrayTypeMismatchException CreateArrayTypeMismatchException()
	{
		return new ArrayTypeMismatchException();
	}

	private static bool CanAssignArrayElement(Type source, Type target)
	{
		if (source.IsValueType)
		{
			return source.IsAssignableFrom(target);
		}
		if (source.IsInterface)
		{
			return !target.IsValueType;
		}
		if (target.IsInterface)
		{
			return !source.IsValueType;
		}
		if (!source.IsAssignableFrom(target))
		{
			return target.IsAssignableFrom(source);
		}
		return true;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static void ConstrainedCopy(Array sourceArray, int sourceIndex, Array destinationArray, int destinationIndex, int length)
	{
		Copy(sourceArray, sourceIndex, destinationArray, destinationIndex, length);
	}

	public static T[] Empty<T>()
	{
		return EmptyArray<T>.Value;
	}

	public void Initialize()
	{
	}

	private static int IndexOfImpl<T>(T[] array, T value, int startIndex, int count)
	{
		return EqualityComparer<T>.Default.IndexOf(array, value, startIndex, count);
	}

	private static int LastIndexOfImpl<T>(T[] array, T value, int startIndex, int count)
	{
		return EqualityComparer<T>.Default.LastIndexOf(array, value, startIndex, count);
	}

	private static void SortImpl(Array keys, Array items, int index, int length, IComparer comparer)
	{
		object[] array = keys as object[];
		object[] array2 = null;
		if (array != null)
		{
			array2 = items as object[];
		}
		if (array != null && (items == null || array2 != null))
		{
			new SorterObjectArray(array, array2, comparer).Sort(index, length);
		}
		else
		{
			new SorterGenericArray(keys, items, comparer).Sort(index, length);
		}
	}

	internal static T UnsafeLoad<T>(T[] array, int index)
	{
		return array[index];
	}

	internal static void UnsafeStore<T>(T[] array, int index, T value)
	{
		array[index] = value;
	}

	internal static R UnsafeMov<S, R>(S instance)
	{
		return (R)(object)instance;
	}
}
