using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.Rendering;

public static class CoreUnsafeUtils
{
	public struct FixedBufferStringQueue
	{
		private unsafe byte* m_ReadCursor;

		private unsafe byte* m_WriteCursor;

		private unsafe readonly byte* m_BufferEnd;

		private unsafe readonly byte* m_BufferStart;

		private readonly int m_BufferLength;

		public int Count { get; private set; }

		public unsafe FixedBufferStringQueue(byte* ptr, int length)
		{
			m_BufferStart = ptr;
			m_BufferLength = length;
			m_BufferEnd = m_BufferStart + m_BufferLength;
			m_ReadCursor = m_BufferStart;
			m_WriteCursor = m_BufferStart;
			Count = 0;
			Clear();
		}

		public unsafe bool TryPush(string v)
		{
			int num = v.Length * 2 + 4;
			if (m_WriteCursor + num >= m_BufferEnd)
			{
				return false;
			}
			*(int*)m_WriteCursor = v.Length;
			m_WriteCursor += 4;
			char* ptr = (char*)m_WriteCursor;
			int num2 = 0;
			while (num2 < v.Length)
			{
				*ptr = v[num2];
				num2++;
				ptr++;
			}
			m_WriteCursor += 2 * v.Length;
			int count = Count + 1;
			Count = count;
			return true;
		}

		public unsafe bool TryPop(out string v)
		{
			int readCursor = *(int*)m_ReadCursor;
			if (readCursor != 0)
			{
				m_ReadCursor += 4;
				v = new string((char*)m_ReadCursor, 0, readCursor);
				m_ReadCursor += readCursor * 2;
				return true;
			}
			v = null;
			return false;
		}

		public unsafe void Clear()
		{
			m_WriteCursor = m_BufferStart;
			m_ReadCursor = m_BufferStart;
			Count = 0;
			UnsafeUtility.MemClear(m_BufferStart, m_BufferLength);
		}
	}

	public interface IKeyGetter<TValue, TKey>
	{
		TKey Get(ref TValue v);
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct DefaultKeyGetter<T> : IKeyGetter<T, T>
	{
		public T Get(ref T v)
		{
			return v;
		}
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct UintKeyGetter : IKeyGetter<uint, uint>
	{
		public uint Get(ref uint v)
		{
			return v;
		}
	}

	public unsafe static void CopyTo<T>(this List<T> list, void* dest, int count) where T : struct
	{
		int num = Mathf.Min(count, list.Count);
		for (int i = 0; i < num; i++)
		{
			UnsafeUtility.WriteArrayElement(dest, i, list[i]);
		}
	}

	public unsafe static void CopyTo<T>(this T[] list, void* dest, int count) where T : struct
	{
		int num = Mathf.Min(count, list.Length);
		for (int i = 0; i < num; i++)
		{
			UnsafeUtility.WriteArrayElement(dest, i, list[i]);
		}
	}

	private static void CalculateRadixParams(int radixBits, out int bitStates)
	{
		if (radixBits != 2 && radixBits != 4 && radixBits != 8)
		{
			throw new Exception("Radix bits must be 2, 4 or 8 for uint radix sort.");
		}
		bitStates = 1 << radixBits;
	}

	private static int CalculateRadixSupportSize(int bitStates, int arrayLength)
	{
		return bitStates * 3 + arrayLength;
	}

	private unsafe static void CalculateRadixSortSupportArrays(int bitStates, int arrayLength, uint* supportArray, out uint* bucketIndices, out uint* bucketSizes, out uint* bucketPrefix, out uint* arrayOutput)
	{
		bucketIndices = supportArray;
		bucketSizes = bucketIndices + bitStates;
		bucketPrefix = bucketSizes + bitStates;
		arrayOutput = bucketPrefix + bitStates;
	}

	private unsafe static void MergeSort(uint* array, uint* support, int length)
	{
		for (int num = 1; num < length; num *= 2)
		{
			for (int i = 0; i + num < length; i += num * 2)
			{
				int num2 = i + num;
				int num3 = num2 + num;
				if (num3 > length)
				{
					num3 = length;
				}
				int num4 = i;
				int num5 = i;
				int num6 = num2;
				while (num5 < num2 && num6 < num3)
				{
					if (array[num5] <= array[num6])
					{
						support[num4] = array[num5++];
					}
					else
					{
						support[num4] = array[num6++];
					}
					num4++;
				}
				while (num5 < num2)
				{
					support[num4] = array[num5++];
					num4++;
				}
				while (num6 < num3)
				{
					support[num4] = array[num6++];
					num4++;
				}
				for (num4 = i; num4 < num3; num4++)
				{
					array[num4] = support[num4];
				}
			}
		}
	}

	public unsafe static void MergeSort(uint[] arr, int sortSize, ref uint[] supportArray)
	{
		sortSize = Math.Min(sortSize, arr.Length);
		if (arr == null || sortSize == 0)
		{
			return;
		}
		if (supportArray == null || supportArray.Length < sortSize)
		{
			supportArray = new uint[sortSize];
		}
		fixed (uint* array = arr)
		{
			fixed (uint* support = supportArray)
			{
				MergeSort(array, support, sortSize);
			}
		}
	}

	public unsafe static void MergeSort(NativeArray<uint> arr, int sortSize, ref NativeArray<uint> supportArray)
	{
		sortSize = Math.Min(sortSize, arr.Length);
		if (arr.IsCreated && sortSize != 0)
		{
			if (!supportArray.IsCreated || supportArray.Length < sortSize)
			{
				ArrayExtensions.ResizeArray(ref supportArray, arr.Length);
			}
			MergeSort((uint*)arr.GetUnsafePtr(), (uint*)supportArray.GetUnsafePtr(), sortSize);
		}
	}

	private unsafe static void InsertionSort(uint* arr, int length)
	{
		for (int i = 0; i < length; i++)
		{
			int num = i;
			while (num >= 1 && arr[num] < arr[num - 1])
			{
				uint num2 = arr[num];
				arr[num] = arr[num - 1];
				arr[num - 1] = num2;
				num--;
			}
		}
	}

	public unsafe static void InsertionSort(uint[] arr, int sortSize)
	{
		sortSize = Math.Min(arr.Length, sortSize);
		if (arr != null && sortSize != 0)
		{
			fixed (uint* arr2 = arr)
			{
				InsertionSort(arr2, sortSize);
			}
		}
	}

	public unsafe static void InsertionSort(NativeArray<uint> arr, int sortSize)
	{
		sortSize = Math.Min(arr.Length, sortSize);
		if (arr.IsCreated && sortSize != 0)
		{
			InsertionSort((uint*)arr.GetUnsafePtr(), sortSize);
		}
	}

	private unsafe static void RadixSort(uint* array, uint* support, int radixBits, int bitStates, int length)
	{
		uint num = (uint)(bitStates - 1);
		CalculateRadixSortSupportArrays(bitStates, length, support, out var bucketIndices, out var bucketSizes, out var bucketPrefix, out var arrayOutput);
		int num2 = 32 / radixBits;
		uint* ptr = arrayOutput;
		uint* ptr2 = array;
		for (int i = 0; i < num2; i++)
		{
			int num3 = i * radixBits;
			for (int j = 0; j < 3 * bitStates; j++)
			{
				bucketIndices[j] = 0u;
			}
			for (int k = 0; k < length; k++)
			{
				bucketSizes[(ptr2[k] >> num3) & num]++;
			}
			for (int l = 1; l < bitStates; l++)
			{
				bucketPrefix[l] = bucketPrefix[l - 1] + bucketSizes[l - 1];
			}
			for (int m = 0; m < length; m++)
			{
				uint num4 = ptr2[m];
				uint num5 = (num4 >> num3) & num;
				ptr[bucketPrefix[num5] + bucketIndices[num5]++] = num4;
			}
			uint* intPtr = ptr2;
			ptr2 = ptr;
			ptr = intPtr;
		}
	}

	public unsafe static void RadixSort(uint[] arr, int sortSize, ref uint[] supportArray, int radixBits = 8)
	{
		sortSize = Math.Min(sortSize, arr.Length);
		CalculateRadixParams(radixBits, out var bitStates);
		if (arr == null || sortSize == 0)
		{
			return;
		}
		int num = CalculateRadixSupportSize(bitStates, sortSize);
		if (supportArray == null || supportArray.Length < num)
		{
			supportArray = new uint[num];
		}
		fixed (uint* array = arr)
		{
			fixed (uint* support = supportArray)
			{
				RadixSort(array, support, radixBits, bitStates, sortSize);
			}
		}
	}

	public unsafe static void RadixSort(NativeArray<uint> array, int sortSize, ref NativeArray<uint> supportArray, int radixBits = 8)
	{
		sortSize = Math.Min(sortSize, array.Length);
		CalculateRadixParams(radixBits, out var bitStates);
		if (array.IsCreated && sortSize != 0)
		{
			int num = CalculateRadixSupportSize(bitStates, sortSize);
			if (!supportArray.IsCreated || supportArray.Length < num)
			{
				ArrayExtensions.ResizeArray(ref supportArray, num);
			}
			RadixSort((uint*)array.GetUnsafePtr(), (uint*)supportArray.GetUnsafePtr(), radixBits, bitStates, sortSize);
		}
	}

	public unsafe static void QuickSort(uint[] arr, int left, int right)
	{
		fixed (uint* data = arr)
		{
			QuickSort<uint, uint, UintKeyGetter>(data, left, right);
		}
	}

	public unsafe static void QuickSort<T>(int count, void* data) where T : struct, IComparable<T>
	{
		QuickSort<T, T, DefaultKeyGetter<T>>(data, 0, count - 1);
	}

	public unsafe static void QuickSort<TValue, TKey, TGetter>(int count, void* data) where TValue : struct where TKey : struct, IComparable<TKey> where TGetter : struct, IKeyGetter<TValue, TKey>
	{
		QuickSort<TValue, TKey, TGetter>(data, 0, count - 1);
	}

	public unsafe static void QuickSort<TValue, TKey, TGetter>(void* data, int left, int right) where TValue : struct where TKey : struct, IComparable<TKey> where TGetter : struct, IKeyGetter<TValue, TKey>
	{
		if (left < right)
		{
			int num = Partition<TValue, TKey, TGetter>(data, left, right);
			if (num >= 1)
			{
				QuickSort<TValue, TKey, TGetter>(data, left, num);
			}
			if (num + 1 < right)
			{
				QuickSort<TValue, TKey, TGetter>(data, num + 1, right);
			}
		}
	}

	public unsafe static int IndexOf<T>(void* data, int count, T v) where T : struct, IEquatable<T>
	{
		for (int i = 0; i < count; i++)
		{
			if (UnsafeUtility.ReadArrayElement<T>(data, i).Equals(v))
			{
				return i;
			}
		}
		return -1;
	}

	public unsafe static int CompareHashes<TOldValue, TOldGetter, TNewValue, TNewGetter>(int oldHashCount, void* oldHashes, int newHashCount, void* newHashes, int* addIndices, int* removeIndices, out int addCount, out int remCount) where TOldValue : struct where TOldGetter : struct, IKeyGetter<TOldValue, Hash128> where TNewValue : struct where TNewGetter : struct, IKeyGetter<TNewValue, Hash128>
	{
		TOldGetter val = new TOldGetter();
		TNewGetter val2 = new TNewGetter();
		addCount = 0;
		remCount = 0;
		if (oldHashCount == newHashCount)
		{
			Hash128 hash = default(Hash128);
			Hash128 hash2 = default(Hash128);
			CombineHashes<TOldValue, TOldGetter>(oldHashCount, oldHashes, &hash);
			CombineHashes<TNewValue, TNewGetter>(newHashCount, newHashes, &hash2);
			if (hash == hash2)
			{
				return 0;
			}
		}
		int num = 0;
		int i = 0;
		int j = 0;
		while (i < oldHashCount || j < newHashCount)
		{
			if (i == oldHashCount)
			{
				for (; j < newHashCount; j++)
				{
					addIndices[addCount++] = j;
					num++;
				}
				continue;
			}
			if (j == newHashCount)
			{
				for (; i < oldHashCount; i++)
				{
					removeIndices[remCount++] = i;
					num++;
				}
				continue;
			}
			TNewValue v = UnsafeUtility.ReadArrayElement<TNewValue>(newHashes, j);
			TOldValue v2 = UnsafeUtility.ReadArrayElement<TOldValue>(oldHashes, i);
			Hash128 hash3 = val2.Get(ref v);
			Hash128 hash4 = val.Get(ref v2);
			if (hash3 == hash4)
			{
				j++;
				i++;
				continue;
			}
			if (hash3 < hash4)
			{
				while (j < newHashCount && hash3 < hash4)
				{
					addIndices[addCount++] = j;
					j++;
					num++;
					v = UnsafeUtility.ReadArrayElement<TNewValue>(newHashes, j);
					hash3 = val2.Get(ref v);
				}
				continue;
			}
			for (; i < oldHashCount; i++)
			{
				if (!(hash4 < hash3))
				{
					break;
				}
				removeIndices[remCount++] = i;
				num++;
			}
		}
		return num;
	}

	public unsafe static int CompareHashes(int oldHashCount, Hash128* oldHashes, int newHashCount, Hash128* newHashes, int* addIndices, int* removeIndices, out int addCount, out int remCount)
	{
		return CompareHashes<Hash128, DefaultKeyGetter<Hash128>, Hash128, DefaultKeyGetter<Hash128>>(oldHashCount, oldHashes, newHashCount, newHashes, addIndices, removeIndices, out addCount, out remCount);
	}

	public unsafe static void CombineHashes<TValue, TGetter>(int count, void* hashes, Hash128* outHash) where TValue : struct where TGetter : struct, IKeyGetter<TValue, Hash128>
	{
		TGetter val = new TGetter();
		for (int i = 0; i < count; i++)
		{
			TValue v = UnsafeUtility.ReadArrayElement<TValue>(hashes, i);
			Hash128 inHash = val.Get(ref v);
			HashUtilities.AppendHash(ref inHash, ref *outHash);
		}
	}

	public unsafe static void CombineHashes(int count, Hash128* hashes, Hash128* outHash)
	{
		CombineHashes<Hash128, DefaultKeyGetter<Hash128>>(count, hashes, outHash);
	}

	private unsafe static int Partition<TValue, TKey, TGetter>(void* data, int left, int right) where TValue : struct where TKey : struct, IComparable<TKey> where TGetter : struct, IKeyGetter<TValue, TKey>
	{
		TGetter val = default(TGetter);
		TValue v = UnsafeUtility.ReadArrayElement<TValue>(data, left);
		TKey other = val.Get(ref v);
		left--;
		right++;
		while (true)
		{
			int num = 0;
			TValue val2 = default(TValue);
			TKey val3 = default(TKey);
			do
			{
				left++;
				val2 = UnsafeUtility.ReadArrayElement<TValue>(data, left);
				num = val.Get(ref val2).CompareTo(other);
			}
			while (num < 0);
			TValue val4 = default(TValue);
			TKey val5 = default(TKey);
			do
			{
				right--;
				val4 = UnsafeUtility.ReadArrayElement<TValue>(data, right);
				num = val.Get(ref val4).CompareTo(other);
			}
			while (num > 0);
			if (left >= right)
			{
				break;
			}
			UnsafeUtility.WriteArrayElement(data, right, val2);
			UnsafeUtility.WriteArrayElement(data, left, val4);
		}
		return right;
	}

	public unsafe static bool HaveDuplicates(int[] arr)
	{
		int* ptr = stackalloc int[arr.Length];
		arr.CopyTo(ptr, arr.Length);
		QuickSort<int>(arr.Length, ptr);
		for (int num = arr.Length - 1; num > 0; num--)
		{
			if (UnsafeUtility.ReadArrayElement<int>(ptr, num).CompareTo(UnsafeUtility.ReadArrayElement<int>(ptr, num - 1)) == 0)
			{
				return true;
			}
		}
		return false;
	}
}
