using System.Collections.Generic;

namespace System.Linq;

internal class Set<TElement>
{
	internal struct Slot
	{
		internal int hashCode;

		internal TElement value;

		internal int next;
	}

	private int[] buckets;

	private Slot[] slots;

	private int count;

	private int freeList;

	private IEqualityComparer<TElement> comparer;

	public Set(IEqualityComparer<TElement> comparer)
	{
		if (comparer == null)
		{
			comparer = EqualityComparer<TElement>.Default;
		}
		this.comparer = comparer;
		buckets = new int[7];
		slots = new Slot[7];
		freeList = -1;
	}

	public bool Add(TElement value)
	{
		return !Find(value, add: true);
	}

	public bool Remove(TElement value)
	{
		int num = InternalGetHashCode(value);
		int num2 = num % buckets.Length;
		int num3 = -1;
		for (int num4 = buckets[num2] - 1; num4 >= 0; num4 = slots[num4].next)
		{
			if (slots[num4].hashCode == num && comparer.Equals(slots[num4].value, value))
			{
				if (num3 < 0)
				{
					buckets[num2] = slots[num4].next + 1;
				}
				else
				{
					slots[num3].next = slots[num4].next;
				}
				slots[num4].hashCode = -1;
				slots[num4].value = default(TElement);
				slots[num4].next = freeList;
				freeList = num4;
				return true;
			}
			num3 = num4;
		}
		return false;
	}

	private bool Find(TElement value, bool add)
	{
		int num = InternalGetHashCode(value);
		for (int num2 = buckets[num % buckets.Length] - 1; num2 >= 0; num2 = slots[num2].next)
		{
			if (slots[num2].hashCode == num && comparer.Equals(slots[num2].value, value))
			{
				return true;
			}
		}
		if (add)
		{
			int num3;
			if (freeList >= 0)
			{
				num3 = freeList;
				freeList = slots[num3].next;
			}
			else
			{
				if (count == slots.Length)
				{
					Resize();
				}
				num3 = count;
				count++;
			}
			int num4 = num % buckets.Length;
			slots[num3].hashCode = num;
			slots[num3].value = value;
			slots[num3].next = buckets[num4] - 1;
			buckets[num4] = num3 + 1;
		}
		return false;
	}

	private void Resize()
	{
		int num = checked(count * 2 + 1);
		int[] array = new int[num];
		Slot[] array2 = new Slot[num];
		Array.Copy(slots, 0, array2, 0, count);
		for (int i = 0; i < count; i++)
		{
			int num2 = array2[i].hashCode % num;
			array2[i].next = array[num2] - 1;
			array[num2] = i + 1;
		}
		buckets = array;
		slots = array2;
	}

	internal int InternalGetHashCode(TElement value)
	{
		if (value != null)
		{
			return comparer.GetHashCode(value) & 0x7FFFFFFF;
		}
		return 0;
	}
}
