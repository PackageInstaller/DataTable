using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace UnityEngine.InputSystem.Utilities;

internal struct InlinedArray<TValue> : IEnumerable<TValue>, IEnumerable
{
	private struct Enumerator : IEnumerator<TValue>, IEnumerator, IDisposable
	{
		public InlinedArray<TValue> array;

		public int index;

		public TValue Current => array[index];

		object IEnumerator.Current => Current;

		public bool MoveNext()
		{
			if (index >= array.length)
			{
				return false;
			}
			index++;
			return index < array.length;
		}

		public void Reset()
		{
			index = -1;
		}

		public void Dispose()
		{
		}
	}

	public int length;

	public TValue firstValue;

	public TValue[] additionalValues;

	public int Capacity
	{
		get
		{
			TValue[] array = additionalValues;
			if (array == null)
			{
				return 1;
			}
			return array.Length + 1;
		}
	}

	public TValue this[int index]
	{
		get
		{
			if (index < 0 || index >= length)
			{
				throw new ArgumentOutOfRangeException("index");
			}
			if (index == 0)
			{
				return firstValue;
			}
			return additionalValues[index - 1];
		}
		set
		{
			if (index < 0 || index >= length)
			{
				throw new ArgumentOutOfRangeException("index");
			}
			if (index == 0)
			{
				firstValue = value;
			}
			else
			{
				additionalValues[index - 1] = value;
			}
		}
	}

	public InlinedArray(TValue value)
	{
		length = 1;
		firstValue = value;
		additionalValues = null;
	}

	public InlinedArray(TValue firstValue, params TValue[] additionalValues)
	{
		length = 1 + additionalValues.Length;
		this.firstValue = firstValue;
		this.additionalValues = additionalValues;
	}

	public InlinedArray(IEnumerable<TValue> values)
	{
		this = default(InlinedArray<TValue>);
		length = values.Count();
		if (length > 1)
		{
			additionalValues = new TValue[length - 1];
		}
		else
		{
			additionalValues = null;
		}
		int num = 0;
		foreach (TValue value in values)
		{
			if (num == 0)
			{
				firstValue = value;
			}
			else
			{
				additionalValues[num - 1] = value;
			}
			num++;
		}
	}

	public void Clear()
	{
		length = 0;
		firstValue = default(TValue);
		additionalValues = null;
	}

	public void ClearWithCapacity()
	{
		firstValue = default(TValue);
		for (int i = 0; i < length - 1; i++)
		{
			additionalValues[i] = default(TValue);
		}
		length = 0;
	}

	public InlinedArray<TValue> Clone()
	{
		return new InlinedArray<TValue>
		{
			length = length,
			firstValue = firstValue,
			additionalValues = ((additionalValues != null) ? ArrayHelpers.Copy(additionalValues) : null)
		};
	}

	public void SetLength(int size)
	{
		if (size < length)
		{
			for (int i = size; i < length; i++)
			{
				this[i] = default(TValue);
			}
		}
		length = size;
		if (size > 1 && (additionalValues == null || additionalValues.Length < size - 1))
		{
			Array.Resize(ref additionalValues, size - 1);
		}
	}

	public TValue[] ToArray()
	{
		return ArrayHelpers.Join(firstValue, additionalValues);
	}

	public TOther[] ToArray<TOther>(Func<TValue, TOther> mapFunction)
	{
		if (length == 0)
		{
			return null;
		}
		TOther[] array = new TOther[length];
		for (int i = 0; i < length; i++)
		{
			array[i] = mapFunction(this[i]);
		}
		return array;
	}

	public int IndexOf(TValue value)
	{
		EqualityComparer<TValue> equalityComparer = EqualityComparer<TValue>.Default;
		if (length > 0)
		{
			if (equalityComparer.Equals(firstValue, value))
			{
				return 0;
			}
			if (additionalValues != null)
			{
				for (int i = 0; i < length - 1; i++)
				{
					if (equalityComparer.Equals(additionalValues[i], value))
					{
						return i + 1;
					}
				}
			}
		}
		return -1;
	}

	public int Append(TValue value)
	{
		if (length == 0)
		{
			firstValue = value;
		}
		else if (additionalValues == null)
		{
			additionalValues = new TValue[1];
			additionalValues[0] = value;
		}
		else
		{
			Array.Resize(ref additionalValues, length);
			additionalValues[length - 1] = value;
		}
		int result = length;
		length++;
		return result;
	}

	public int AppendWithCapacity(TValue value, int capacityIncrement = 10)
	{
		if (length == 0)
		{
			firstValue = value;
		}
		else
		{
			int count = length - 1;
			ArrayHelpers.AppendWithCapacity(ref additionalValues, ref count, value, capacityIncrement);
		}
		int result = length;
		length++;
		return result;
	}

	public void AssignWithCapacity(InlinedArray<TValue> values)
	{
		if (Capacity < values.length && values.length > 1)
		{
			additionalValues = new TValue[values.length - 1];
		}
		length = values.length;
		if (length > 0)
		{
			firstValue = values.firstValue;
		}
		if (length > 1)
		{
			Array.Copy(values.additionalValues, additionalValues, length - 1);
		}
	}

	public void Append(IEnumerable<TValue> values)
	{
		foreach (TValue value in values)
		{
			Append(value);
		}
	}

	public void Remove(TValue value)
	{
		if (length < 1)
		{
			return;
		}
		if (EqualityComparer<TValue>.Default.Equals(firstValue, value))
		{
			RemoveAt(0);
		}
		else
		{
			if (additionalValues == null)
			{
				return;
			}
			for (int i = 0; i < length - 1; i++)
			{
				if (EqualityComparer<TValue>.Default.Equals(additionalValues[i], value))
				{
					RemoveAt(i + 1);
					break;
				}
			}
		}
	}

	public void RemoveAtWithCapacity(int index)
	{
		if (index < 0 || index >= length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		if (index == 0)
		{
			if (length == 1)
			{
				firstValue = default(TValue);
			}
			else if (length == 2)
			{
				firstValue = additionalValues[0];
				additionalValues[0] = default(TValue);
			}
			else
			{
				firstValue = additionalValues[0];
				int count = length - 1;
				additionalValues.EraseAtWithCapacity(ref count, 0);
			}
		}
		else
		{
			int count2 = length - 1;
			additionalValues.EraseAtWithCapacity(ref count2, index - 1);
		}
		length--;
	}

	public void RemoveAt(int index)
	{
		if (index < 0 || index >= length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		if (index == 0)
		{
			if (additionalValues != null)
			{
				firstValue = additionalValues[0];
				if (additionalValues.Length == 1)
				{
					additionalValues = null;
				}
				else
				{
					Array.Copy(additionalValues, 1, additionalValues, 0, additionalValues.Length - 1);
					Array.Resize(ref additionalValues, additionalValues.Length - 1);
				}
			}
			else
			{
				firstValue = default(TValue);
			}
		}
		else
		{
			int num = length - 1;
			if (num == 1)
			{
				additionalValues = null;
			}
			else if (index == length - 1)
			{
				Array.Resize(ref additionalValues, num - 1);
			}
			else
			{
				TValue[] destinationArray = new TValue[num - 1];
				if (index >= 2)
				{
					Array.Copy(additionalValues, 0, destinationArray, 0, index - 1);
				}
				Array.Copy(additionalValues, index + 1 - 1, destinationArray, index - 1, length - index - 1);
				additionalValues = destinationArray;
			}
		}
		length--;
	}

	public void RemoveAtByMovingTailWithCapacity(int index)
	{
		if (index < 0 || index >= length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		int count = length - 1;
		if (index == 0)
		{
			if (length > 1)
			{
				firstValue = additionalValues[count - 1];
				additionalValues[count - 1] = default(TValue);
			}
			else
			{
				firstValue = default(TValue);
			}
		}
		else
		{
			ArrayHelpers.EraseAtByMovingTail(additionalValues, ref count, index - 1);
		}
		length--;
	}

	public bool RemoveByMovingTailWithCapacity(TValue value)
	{
		int num = IndexOf(value);
		if (num == -1)
		{
			return false;
		}
		RemoveAtByMovingTailWithCapacity(num);
		return true;
	}

	public bool Contains(TValue value, IEqualityComparer<TValue> comparer)
	{
		for (int i = 0; i < length; i++)
		{
			if (comparer.Equals(this[i], value))
			{
				return true;
			}
		}
		return false;
	}

	public void Merge(InlinedArray<TValue> other)
	{
		EqualityComparer<TValue> comparer = EqualityComparer<TValue>.Default;
		for (int i = 0; i < other.length; i++)
		{
			TValue value = other[i];
			if (!Contains(value, comparer))
			{
				Append(value);
			}
		}
	}

	public IEnumerator<TValue> GetEnumerator()
	{
		return new Enumerator
		{
			array = this,
			index = -1
		};
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
