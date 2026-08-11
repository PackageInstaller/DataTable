using System;
using System.Collections.Generic;
using System.Linq;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.InputSystem.Utilities;

internal static class ArrayHelpers
{
	public static int LengthSafe<TValue>(this TValue[] array)
	{
		if (array == null)
		{
			return 0;
		}
		return array.Length;
	}

	public static void Clear<TValue>(this TValue[] array)
	{
		if (array != null)
		{
			Array.Clear(array, 0, array.Length);
		}
	}

	public static void Clear<TValue>(this TValue[] array, int count)
	{
		if (array != null)
		{
			Array.Clear(array, 0, count);
		}
	}

	public static void Clear<TValue>(this TValue[] array, ref int count)
	{
		if (array != null)
		{
			Array.Clear(array, 0, count);
			count = 0;
		}
	}

	public static void EnsureCapacity<TValue>(ref TValue[] array, int count, int capacity, int capacityIncrement = 10)
	{
		if (capacity != 0)
		{
			if (array == null)
			{
				array = new TValue[Math.Max(capacity, capacityIncrement)];
			}
			else if (array.Length - count < capacity)
			{
				DuplicateWithCapacity(ref array, count, capacity, capacityIncrement);
			}
		}
	}

	public static void DuplicateWithCapacity<TValue>(ref TValue[] array, int count, int capacity, int capacityIncrement = 10)
	{
		if (array == null)
		{
			array = new TValue[Math.Max(capacity, capacityIncrement)];
			return;
		}
		TValue[] array2 = new TValue[count + Math.Max(capacity, capacityIncrement)];
		Array.Copy(array, array2, count);
		array = array2;
	}

	public static bool Contains<TValue>(TValue[] array, TValue value)
	{
		if (array == null)
		{
			return false;
		}
		EqualityComparer<TValue> equalityComparer = EqualityComparer<TValue>.Default;
		for (int i = 0; i < array.Length; i++)
		{
			if (equalityComparer.Equals(array[i], value))
			{
				return true;
			}
		}
		return false;
	}

	public static bool ContainsReference<TValue>(this TValue[] array, TValue value) where TValue : class
	{
		return array?.ContainsReference(array.Length, value) ?? false;
	}

	public static bool ContainsReference<TFirst, TSecond>(this TFirst[] array, int count, TSecond value) where TFirst : TSecond where TSecond : class
	{
		return array.IndexOfReference(value, count) != -1;
	}

	public static bool ContainsReference<TFirst, TSecond>(this TFirst[] array, int startIndex, int count, TSecond value) where TFirst : TSecond where TSecond : class
	{
		return array.IndexOfReference(value, startIndex, count) != -1;
	}

	public static bool HaveDuplicateReferences<TFirst>(this TFirst[] first, int index, int count)
	{
		for (int i = 0; i < count; i++)
		{
			TFirst val = first[i];
			for (int j = i + 1; j < count - i; j++)
			{
				if ((object)val == (object)first[j])
				{
					return true;
				}
			}
		}
		return false;
	}

	public static bool HaveEqualElements<TValue>(TValue[] first, TValue[] second, int count = int.MaxValue)
	{
		if (first == null || second == null)
		{
			return second == first;
		}
		int num = Math.Min(count, first.Length);
		int num2 = Math.Min(count, second.Length);
		if (num != num2)
		{
			return false;
		}
		EqualityComparer<TValue> equalityComparer = EqualityComparer<TValue>.Default;
		for (int i = 0; i < num; i++)
		{
			if (!equalityComparer.Equals(first[i], second[i]))
			{
				return false;
			}
		}
		return true;
	}

	public static int IndexOf<TValue>(TValue[] array, TValue value, int startIndex = 0, int count = -1)
	{
		if (array == null)
		{
			return -1;
		}
		if (count < 0)
		{
			count = array.Length - startIndex;
		}
		EqualityComparer<TValue> equalityComparer = EqualityComparer<TValue>.Default;
		for (int i = startIndex; i < startIndex + count; i++)
		{
			if (equalityComparer.Equals(array[i], value))
			{
				return i;
			}
		}
		return -1;
	}

	public static int IndexOf<TValue>(this TValue[] array, Predicate<TValue> predicate)
	{
		if (array == null)
		{
			return -1;
		}
		int num = array.Length;
		for (int i = 0; i < num; i++)
		{
			if (predicate(array[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public static int IndexOf<TValue>(this TValue[] array, Predicate<TValue> predicate, int startIndex = 0, int count = -1)
	{
		if (array == null)
		{
			return -1;
		}
		int num = startIndex + ((count < 0) ? (array.Length - startIndex) : count);
		for (int i = startIndex; i < num; i++)
		{
			if (predicate(array[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public static int IndexOfReference<TFirst, TSecond>(this TFirst[] array, TSecond value, int count = -1) where TFirst : TSecond where TSecond : class
	{
		return array.IndexOfReference(value, 0, count);
	}

	public static int IndexOfReference<TFirst, TSecond>(this TFirst[] array, TSecond value, int startIndex, int count) where TFirst : TSecond where TSecond : class
	{
		if (array == null)
		{
			return -1;
		}
		if (count < 0)
		{
			count = array.Length - startIndex;
		}
		for (int i = startIndex; i < startIndex + count; i++)
		{
			if ((object)array[i] == value)
			{
				return i;
			}
		}
		return -1;
	}

	public static int IndexOfValue<TValue>(this TValue[] array, TValue value, int startIndex = 0, int count = -1) where TValue : struct, IEquatable<TValue>
	{
		if (array == null)
		{
			return -1;
		}
		if (count < 0)
		{
			count = array.Length - startIndex;
		}
		for (int i = startIndex; i < startIndex + count; i++)
		{
			if (value.Equals(array[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public unsafe static void Resize<TValue>(ref NativeArray<TValue> array, int newSize, Allocator allocator) where TValue : struct
	{
		int length = array.Length;
		if (length == newSize)
		{
			return;
		}
		if (newSize == 0)
		{
			if (array.IsCreated)
			{
				array.Dispose();
			}
			array = default(NativeArray<TValue>);
			return;
		}
		NativeArray<TValue> nativeArray = new NativeArray<TValue>(newSize, allocator);
		if (length != 0)
		{
			UnsafeUtility.MemCpy(nativeArray.GetUnsafePtr(), array.GetUnsafeReadOnlyPtr(), UnsafeUtility.SizeOf<TValue>() * ((newSize < length) ? newSize : length));
			array.Dispose();
		}
		array = nativeArray;
	}

	public static int Append<TValue>(ref TValue[] array, TValue value)
	{
		if (array == null)
		{
			array = new TValue[1];
			array[0] = value;
			return 0;
		}
		int num = array.Length;
		Array.Resize(ref array, num + 1);
		array[num] = value;
		return num;
	}

	public static int Append<TValue>(ref TValue[] array, IEnumerable<TValue> values)
	{
		if (array == null)
		{
			array = values.ToArray();
			return 0;
		}
		int num = array.Length;
		int num2 = values.Count();
		Array.Resize(ref array, num + num2);
		int num3 = num;
		foreach (TValue value in values)
		{
			array[num3++] = value;
		}
		return num;
	}

	public static int AppendToImmutable<TValue>(ref TValue[] array, TValue[] values)
	{
		if (array == null)
		{
			array = values;
			return 0;
		}
		if (values != null && values.Length != 0)
		{
			int num = array.Length;
			int num2 = values.Length;
			Array.Resize(ref array, num + num2);
			Array.Copy(values, 0, array, num, num2);
			return num;
		}
		return array.Length;
	}

	public static int AppendWithCapacity<TValue>(ref TValue[] array, ref int count, TValue value, int capacityIncrement = 10)
	{
		if (array == null)
		{
			array = new TValue[capacityIncrement];
			array[0] = value;
			count++;
			return 0;
		}
		int num = array.Length;
		if (num == count)
		{
			num += capacityIncrement;
			Array.Resize(ref array, num);
		}
		int num2 = count;
		array[num2] = value;
		count++;
		return num2;
	}

	public static int AppendListWithCapacity<TValue, TValues>(ref TValue[] array, ref int length, TValues values, int capacityIncrement = 10) where TValues : IReadOnlyList<TValue>
	{
		int count = values.Count;
		if (array == null)
		{
			int num = Math.Max(count, capacityIncrement);
			array = new TValue[num];
			for (int i = 0; i < count; i++)
			{
				array[i] = values[i];
			}
			length += count;
			return 0;
		}
		int num2 = array.Length;
		if (num2 < length + count)
		{
			num2 += Math.Max(length + count, capacityIncrement);
			Array.Resize(ref array, num2);
		}
		int num3 = length;
		for (int j = 0; j < count; j++)
		{
			array[num3 + j] = values[j];
		}
		length += count;
		return num3;
	}

	public static int AppendWithCapacity<TValue>(ref NativeArray<TValue> array, ref int count, TValue value, int capacityIncrement = 10, Allocator allocator = Allocator.Persistent) where TValue : struct
	{
		if (array.Length == count)
		{
			GrowBy(ref array, (capacityIncrement <= 1) ? 1 : capacityIncrement, allocator);
		}
		int num = count;
		array[num] = value;
		count++;
		return num;
	}

	public static void InsertAt<TValue>(ref TValue[] array, int index, TValue value)
	{
		if (array == null)
		{
			if (index != 0)
			{
				throw new ArgumentOutOfRangeException("index");
			}
			array = new TValue[1];
			array[0] = value;
			return;
		}
		int num = array.Length;
		Array.Resize(ref array, num + 1);
		if (index != num)
		{
			Array.Copy(array, index, array, index + 1, num - index);
		}
		array[index] = value;
	}

	public static void InsertAtWithCapacity<TValue>(ref TValue[] array, ref int count, int index, TValue value, int capacityIncrement = 10)
	{
		EnsureCapacity(ref array, count, count + 1, capacityIncrement);
		if (index != count)
		{
			Array.Copy(array, index, array, index + 1, count - index);
		}
		array[index] = value;
		count++;
	}

	public static void PutAtIfNotSet<TValue>(ref TValue[] array, int index, Func<TValue> valueFn)
	{
		if (array.LengthSafe() < index + 1)
		{
			Array.Resize(ref array, index + 1);
		}
		if (EqualityComparer<TValue>.Default.Equals(array[index], default(TValue)))
		{
			array[index] = valueFn();
		}
	}

	public static int GrowBy<TValue>(ref TValue[] array, int count)
	{
		if (array == null)
		{
			array = new TValue[count];
			return 0;
		}
		int num = array.Length;
		Array.Resize(ref array, num + count);
		return num;
	}

	public unsafe static int GrowBy<TValue>(ref NativeArray<TValue> array, int count, Allocator allocator = Allocator.Persistent) where TValue : struct
	{
		int length = array.Length;
		if (length == 0)
		{
			array = new NativeArray<TValue>(count, allocator);
			return 0;
		}
		NativeArray<TValue> nativeArray = new NativeArray<TValue>(length + count, allocator);
		UnsafeUtility.MemCpy(nativeArray.GetUnsafePtr(), array.GetUnsafeReadOnlyPtr(), (long)length * (long)UnsafeUtility.SizeOf<TValue>());
		array.Dispose();
		array = nativeArray;
		return length;
	}

	public static int GrowWithCapacity<TValue>(ref TValue[] array, ref int count, int growBy, int capacityIncrement = 10)
	{
		if (((array != null) ? array.Length : 0) < count + growBy)
		{
			if (capacityIncrement < growBy)
			{
				capacityIncrement = growBy;
			}
			GrowBy(ref array, capacityIncrement);
		}
		int result = count;
		count += growBy;
		return result;
	}

	public static int GrowWithCapacity<TValue>(ref NativeArray<TValue> array, ref int count, int growBy, int capacityIncrement = 10, Allocator allocator = Allocator.Persistent) where TValue : struct
	{
		if (array.Length < count + growBy)
		{
			if (capacityIncrement < growBy)
			{
				capacityIncrement = growBy;
			}
			GrowBy(ref array, capacityIncrement, allocator);
		}
		int result = count;
		count += growBy;
		return result;
	}

	public static TValue[] Join<TValue>(TValue value, params TValue[] values)
	{
		int num = 0;
		if (value != null)
		{
			num++;
		}
		if (values != null)
		{
			num += values.Length;
		}
		if (num == 0)
		{
			return null;
		}
		TValue[] array = new TValue[num];
		int destinationIndex = 0;
		if (value != null)
		{
			array[destinationIndex++] = value;
		}
		if (values != null)
		{
			Array.Copy(values, 0, array, destinationIndex, values.Length);
		}
		return array;
	}

	public static TValue[] Merge<TValue>(TValue[] first, TValue[] second) where TValue : IEquatable<TValue>
	{
		if (first == null)
		{
			return second;
		}
		if (second == null)
		{
			return first;
		}
		List<TValue> list = new List<TValue>();
		list.AddRange(first);
		foreach (TValue secondValue in second)
		{
			if (!list.Exists((TValue x) => x.Equals(secondValue)))
			{
				list.Add(secondValue);
			}
		}
		return list.ToArray();
	}

	public static TValue[] Merge<TValue>(TValue[] first, TValue[] second, IEqualityComparer<TValue> comparer)
	{
		if (first == null)
		{
			return second;
		}
		if (second == null)
		{
			return null;
		}
		List<TValue> list = new List<TValue>();
		list.AddRange(first);
		foreach (TValue secondValue in second)
		{
			if (!list.Exists((TValue x) => comparer.Equals(secondValue)))
			{
				list.Add(secondValue);
			}
		}
		return list.ToArray();
	}

	public static void EraseAt<TValue>(ref TValue[] array, int index)
	{
		int num = array.Length;
		if (index == 0 && num == 1)
		{
			array = null;
			return;
		}
		if (index < num - 1)
		{
			Array.Copy(array, index + 1, array, index, num - index - 1);
		}
		Array.Resize(ref array, num - 1);
	}

	public static void EraseAtWithCapacity<TValue>(this TValue[] array, ref int count, int index)
	{
		if (index < count - 1)
		{
			Array.Copy(array, index + 1, array, index, count - index - 1);
		}
		array[count - 1] = default(TValue);
		count--;
	}

	public unsafe static void EraseAtWithCapacity<TValue>(NativeArray<TValue> array, ref int count, int index) where TValue : struct
	{
		if (index < count - 1)
		{
			int num = UnsafeUtility.SizeOf<TValue>();
			byte* unsafePtr = (byte*)array.GetUnsafePtr();
			UnsafeUtility.MemCpy(unsafePtr + num * index, unsafePtr + num * (index + 1), (count - index - 1) * num);
		}
		count--;
	}

	public static bool Erase<TValue>(ref TValue[] array, TValue value)
	{
		int num = IndexOf(array, value);
		if (num != -1)
		{
			EraseAt(ref array, num);
			return true;
		}
		return false;
	}

	public static void EraseAtByMovingTail<TValue>(TValue[] array, ref int count, int index)
	{
		if (index != count - 1)
		{
			array[index] = array[count - 1];
		}
		if (count >= 1)
		{
			array[count - 1] = default(TValue);
		}
		count--;
	}

	public static TValue[] Copy<TValue>(TValue[] array)
	{
		if (array == null)
		{
			return null;
		}
		int num = array.Length;
		TValue[] array2 = new TValue[num];
		Array.Copy(array, array2, num);
		return array2;
	}

	public static TValue[] Clone<TValue>(TValue[] array) where TValue : ICloneable
	{
		if (array == null)
		{
			return null;
		}
		int num = array.Length;
		TValue[] array2 = new TValue[num];
		for (int i = 0; i < num; i++)
		{
			array2[i] = (TValue)array[i].Clone();
		}
		return array2;
	}

	public static TNew[] Select<TOld, TNew>(TOld[] array, Func<TOld, TNew> converter)
	{
		if (array == null)
		{
			return null;
		}
		int num = array.Length;
		TNew[] array2 = new TNew[num];
		for (int i = 0; i < num; i++)
		{
			array2[i] = converter(array[i]);
		}
		return array2;
	}

	private static void Swap<TValue>(ref TValue first, ref TValue second)
	{
		TValue val = first;
		first = second;
		second = val;
	}

	public static void MoveSlice<TValue>(TValue[] array, int sourceIndex, int destinationIndex, int count)
	{
		if (count <= 0 || sourceIndex == destinationIndex)
		{
			return;
		}
		int num = ((destinationIndex <= sourceIndex) ? (sourceIndex + count - destinationIndex) : (destinationIndex + count - sourceIndex));
		if (num == count * 2)
		{
			for (int i = 0; i < count; i++)
			{
				Swap(ref array[sourceIndex + i], ref array[destinationIndex + i]);
			}
			return;
		}
		int num2 = num - 1;
		int num3 = destinationIndex;
		for (int j = 0; j < num2; j++)
		{
			Swap(ref array[num3], ref array[sourceIndex]);
			if (destinationIndex > sourceIndex)
			{
				num3 -= count;
				if (num3 < sourceIndex)
				{
					num3 = destinationIndex + count - Math.Abs(sourceIndex - num3);
				}
			}
			else
			{
				num3 += count;
				if (num3 >= sourceIndex + count)
				{
					num3 = destinationIndex + (num3 - (sourceIndex + count));
				}
			}
		}
	}

	public static void EraseSliceWithCapacity<TValue>(ref TValue[] array, ref int length, int index, int count)
	{
		if (count < length)
		{
			Array.Copy(array, index + count, array, index, length - index - count);
		}
		for (int i = 0; i < count; i++)
		{
			array[length - i - 1] = default(TValue);
		}
		length -= count;
	}

	public static void SwapElements<TValue>(this TValue[] array, int index1, int index2)
	{
		MemoryHelpers.Swap(ref array[index1], ref array[index2]);
	}

	public static void SwapElements<TValue>(this NativeArray<TValue> array, int index1, int index2) where TValue : struct
	{
		TValue value = array[index1];
		array[index1] = array[index2];
		array[index2] = value;
	}
}
