using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal.LibTessDotNet;

internal class PriorityQueue<TValue> where TValue : class
{
	private class StackItem
	{
		internal int p;

		internal int r;
	}

	private PriorityHeap<TValue>.LessOrEqual _leq;

	private PriorityHeap<TValue> _heap;

	private TValue[] _keys;

	private int[] _order;

	private int _size;

	private int _max;

	private bool _initialized;

	public bool Empty
	{
		get
		{
			if (_size == 0)
			{
				return _heap.Empty;
			}
			return false;
		}
	}

	public PriorityQueue(int initialSize, PriorityHeap<TValue>.LessOrEqual leq)
	{
		_leq = leq;
		_heap = new PriorityHeap<TValue>(initialSize, leq);
		_keys = new TValue[initialSize];
		_size = 0;
		_max = initialSize;
		_initialized = false;
	}

	private static void Swap(ref int a, ref int b)
	{
		int num = a;
		a = b;
		b = num;
	}

	public void Init()
	{
		Stack<StackItem> stack = new Stack<StackItem>();
		uint num = 2016473283u;
		int num2 = 0;
		int num3 = _size - 1;
		_order = new int[_size + 1];
		int num4 = 0;
		for (int i = num2; i <= num3; i++)
		{
			_order[i] = num4;
			num4++;
		}
		stack.Push(new StackItem
		{
			p = num2,
			r = num3
		});
		while (stack.Count > 0)
		{
			StackItem stackItem = stack.Pop();
			num2 = stackItem.p;
			num3 = stackItem.r;
			while (num3 > num2 + 10)
			{
				num = num * 1539415821 + 1;
				int i = num2 + (int)(num % (num3 - num2 + 1));
				num4 = _order[i];
				_order[i] = _order[num2];
				_order[num2] = num4;
				i = num2 - 1;
				int num5 = num3 + 1;
				while (true)
				{
					i++;
					if (_leq(_keys[_order[i]], _keys[num4]))
					{
						do
						{
							num5--;
						}
						while (!_leq(_keys[num4], _keys[_order[num5]]));
						Swap(ref _order[i], ref _order[num5]);
						if (i >= num5)
						{
							break;
						}
					}
				}
				Swap(ref _order[i], ref _order[num5]);
				if (i - num2 < num3 - num5)
				{
					stack.Push(new StackItem
					{
						p = num5 + 1,
						r = num3
					});
					num3 = i - 1;
				}
				else
				{
					stack.Push(new StackItem
					{
						p = num2,
						r = i - 1
					});
					num2 = num5 + 1;
				}
			}
			for (int i = num2 + 1; i <= num3; i++)
			{
				num4 = _order[i];
				int num5 = i;
				while (num5 > num2 && !_leq(_keys[num4], _keys[_order[num5 - 1]]))
				{
					_order[num5] = _order[num5 - 1];
					num5--;
				}
				_order[num5] = num4;
			}
		}
		_max = _size;
		_initialized = true;
		_heap.Init();
	}

	public PQHandle Insert(TValue value)
	{
		if (_initialized)
		{
			return _heap.Insert(value);
		}
		int size = _size;
		if (++_size >= _max)
		{
			_max <<= 1;
			Array.Resize(ref _keys, _max);
		}
		_keys[size] = value;
		return new PQHandle
		{
			_handle = -(size + 1)
		};
	}

	public TValue ExtractMin()
	{
		if (_size == 0)
		{
			return _heap.ExtractMin();
		}
		TValue val = _keys[_order[_size - 1]];
		if (!_heap.Empty)
		{
			TValue lhs = _heap.Minimum();
			if (_leq(lhs, val))
			{
				return _heap.ExtractMin();
			}
		}
		do
		{
			_size--;
		}
		while (_size > 0 && _keys[_order[_size - 1]] == null);
		return val;
	}

	public TValue Minimum()
	{
		if (_size == 0)
		{
			return _heap.Minimum();
		}
		TValue val = _keys[_order[_size - 1]];
		if (!_heap.Empty)
		{
			TValue val2 = _heap.Minimum();
			if (_leq(val2, val))
			{
				return val2;
			}
		}
		return val;
	}

	public void Remove(PQHandle handle)
	{
		int handle2 = handle._handle;
		if (handle2 >= 0)
		{
			_heap.Remove(handle);
			return;
		}
		handle2 = -(handle2 + 1);
		_keys[handle2] = null;
		while (_size > 0 && _keys[_order[_size - 1]] == null)
		{
			_size--;
		}
	}
}
