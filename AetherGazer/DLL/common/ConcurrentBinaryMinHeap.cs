using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;

public class ConcurrentBinaryMinHeap<T> : ICollection<PriorityValuePair<T>>, IEnumerable<PriorityValuePair<T>>, IEnumerable
{
	private List<PriorityValuePair<T>> __data;

	public int Capacity
	{
		get
		{
			Monitor.Enter(__data);
			int num = 0;
			try
			{
				return __data.Capacity;
			}
			finally
			{
				Monitor.Exit(__data);
			}
		}
	}

	public int Count
	{
		get
		{
			Monitor.Enter(__data);
			int num = 0;
			try
			{
				return __data.Count;
			}
			finally
			{
				Monitor.Exit(__data);
			}
		}
	}

	public bool IsEmpty
	{
		get
		{
			Monitor.Enter(__data);
			bool flag = false;
			try
			{
				return __data.Count == 0;
			}
			finally
			{
				Monitor.Exit(__data);
			}
		}
	}

	public bool IsReadOnly => false;

	public ConcurrentBinaryMinHeap()
	{
		__data = new List<PriorityValuePair<T>>();
	}

	public ConcurrentBinaryMinHeap(int initialCapacity)
	{
		try
		{
			__data = new List<PriorityValuePair<T>>(initialCapacity);
		}
		catch (Exception ex)
		{
			throw ex;
		}
	}

	public void Add(PriorityValuePair<T> element)
	{
		Push(element);
	}

	public void Clear()
	{
		Monitor.Enter(__data);
		try
		{
			__data.Clear();
		}
		catch (Exception ex)
		{
			throw ex;
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}

	public bool Contains(PriorityValuePair<T> element)
	{
		Monitor.Enter(__data);
		bool flag = false;
		try
		{
			return __data.Contains(element);
		}
		catch (Exception ex)
		{
			throw ex;
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}

	public void CopyTo(PriorityValuePair<T>[] array, int arrayIndex)
	{
		Monitor.Enter(__data);
		try
		{
			__data.CopyTo(array, arrayIndex);
		}
		catch (Exception ex)
		{
			throw ex;
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}

	public IEnumerator<PriorityValuePair<T>> GetEnumerator()
	{
		Monitor.Enter(__data);
		IEnumerator<PriorityValuePair<T>> enumerator = null;
		try
		{
			return __data.GetEnumerator();
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		Monitor.Enter(__data);
		IEnumerator enumerator = null;
		try
		{
			return GetEnumerator();
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}

	public PriorityValuePair<T> Peek()
	{
		if (IsEmpty)
		{
			return null;
		}
		Monitor.Enter(__data);
		try
		{
			return __data[0];
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}

	public PriorityValuePair<T> Pop()
	{
		if (IsEmpty)
		{
			return null;
		}
		Monitor.Enter(__data);
		PriorityValuePair<T> result;
		try
		{
			result = __data[0];
			if (__data.Count <= 1)
			{
				__data.Clear();
			}
			else
			{
				__data[0] = __data[__data.Count - 1];
				__data.RemoveAt(__data.Count - 1);
				HeapifyTopDown(0);
			}
		}
		catch (Exception ex)
		{
			throw ex;
		}
		finally
		{
			Monitor.Exit(__data);
		}
		return result;
	}

	public void Push(PriorityValuePair<T> element)
	{
		Monitor.Enter(__data);
		try
		{
			__data.Add(element);
			HeapifyBottomUp(__data.Count - 1);
		}
		catch (Exception ex)
		{
			throw ex;
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}

	public void Push(double priority, T value)
	{
		Monitor.Enter(__data);
		try
		{
			__data.Add(new PriorityValuePair<T>(priority, value));
			HeapifyBottomUp(__data.Count - 1);
		}
		catch (Exception ex)
		{
			throw ex;
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}

	public bool Remove(PriorityValuePair<T> element)
	{
		if (IsEmpty)
		{
			return false;
		}
		Monitor.Enter(__data);
		bool result = false;
		try
		{
			int num = __data.IndexOf(element);
			if (num < 0)
			{
				result = false;
			}
			else if (num == __data.Count - 1)
			{
				__data.RemoveAt(num);
				result = true;
			}
			else
			{
				SwapElements(num, __data.Count - 1);
				__data.RemoveAt(__data.Count - 1);
				int num2 = HeapifyBottomUp(num);
				if (num2 == num)
				{
					HeapifyTopDown(num);
				}
				result = true;
			}
		}
		catch (Exception ex)
		{
			throw ex;
		}
		finally
		{
			Monitor.Exit(__data);
		}
		return result;
	}

	private void SwapElements(int index1, int index2)
	{
		if (__data.Count < 2)
		{
			throw new InvalidOperationException("The heap must contain at least 2 elements.");
		}
		if (index1 < 0 || index1 >= __data.Count)
		{
			throw new ArgumentOutOfRangeException("index1 must be within the range [0,Count-1].");
		}
		if (index2 < 0 || index2 >= __data.Count)
		{
			throw new ArgumentOutOfRangeException("index2 must be within the range [0,Count-1].");
		}
		Monitor.Enter(__data);
		try
		{
			PriorityValuePair<T> value = __data[index1];
			__data[index1] = __data[index2];
			__data[index2] = value;
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}

	private int HeapifyBottomUp(int index)
	{
		if (IsEmpty)
		{
			throw new InvalidOperationException("The heap is empty.");
		}
		if (index < 0 || index >= __data.Count)
		{
			throw new ArgumentOutOfRangeException("index must be within the range [0,Count-1].");
		}
		Monitor.Enter(__data);
		try
		{
			double num = 0.0;
			double num2 = 0.0;
			while (index > 0)
			{
				int num3 = (index - 1) / 2;
				num = __data[index].Priority;
				num2 = __data[num3].Priority;
				if (num > num2)
				{
					SwapElements(index, num3);
					index = num3;
					continue;
				}
				break;
			}
		}
		catch (Exception ex)
		{
			throw ex;
		}
		finally
		{
			Monitor.Exit(__data);
		}
		return index;
	}

	private void HeapifyTopDown(int index)
	{
		if (IsEmpty)
		{
			throw new InvalidOperationException("The heap is empty.");
		}
		if (index < 0 || index >= __data.Count)
		{
			throw new ArgumentOutOfRangeException("Index must be a valid index within the heap.");
		}
		Monitor.Enter(__data);
		try
		{
			while (true)
			{
				int num = index;
				double priority = __data[index].Priority;
				int num2 = 2 * index + 1;
				if (num2 < __data.Count)
				{
					double priority2 = __data[num2].Priority;
					if (priority < priority2)
					{
						num = num2;
						priority = __data[num2].Priority;
					}
				}
				int num3 = 2 * index + 2;
				if (num3 < __data.Count)
				{
					double priority3 = __data[num3].Priority;
					if (priority < priority3)
					{
						num = num3;
						priority = __data[num3].Priority;
					}
				}
				if (num != index)
				{
					SwapElements(num, index);
					index = num;
					continue;
				}
				break;
			}
		}
		finally
		{
			Monitor.Exit(__data);
		}
	}
}
