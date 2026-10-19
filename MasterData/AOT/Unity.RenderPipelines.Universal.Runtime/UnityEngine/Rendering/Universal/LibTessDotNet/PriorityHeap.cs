using System;

namespace UnityEngine.Rendering.Universal.LibTessDotNet;

internal class PriorityHeap<TValue> where TValue : class
{
	public delegate bool LessOrEqual(TValue lhs, TValue rhs);

	protected class HandleElem
	{
		internal TValue _key;

		internal int _node;
	}

	private LessOrEqual _leq;

	private int[] _nodes;

	private HandleElem[] _handles;

	private int _size;

	private int _max;

	private int _freeList;

	private bool _initialized;

	public bool Empty => _size == 0;

	public PriorityHeap(int initialSize, LessOrEqual leq)
	{
		_leq = leq;
		_nodes = new int[initialSize + 1];
		_handles = new HandleElem[initialSize + 1];
		_size = 0;
		_max = initialSize;
		_freeList = 0;
		_initialized = false;
		_nodes[1] = 1;
		_handles[1] = new HandleElem
		{
			_key = null
		};
	}

	private void FloatDown(int curr)
	{
		int num = _nodes[curr];
		while (true)
		{
			int num2 = curr << 1;
			if (num2 < _size && _leq(_handles[_nodes[num2 + 1]]._key, _handles[_nodes[num2]]._key))
			{
				num2++;
			}
			int num3 = _nodes[num2];
			if (num2 > _size || _leq(_handles[num]._key, _handles[num3]._key))
			{
				break;
			}
			_nodes[curr] = num3;
			_handles[num3]._node = curr;
			curr = num2;
		}
		_nodes[curr] = num;
		_handles[num]._node = curr;
	}

	private void FloatUp(int curr)
	{
		int num = _nodes[curr];
		while (true)
		{
			int num2 = curr >> 1;
			int num3 = _nodes[num2];
			if (num2 == 0 || _leq(_handles[num3]._key, _handles[num]._key))
			{
				break;
			}
			_nodes[curr] = num3;
			_handles[num3]._node = curr;
			curr = num2;
		}
		_nodes[curr] = num;
		_handles[num]._node = curr;
	}

	public void Init()
	{
		for (int num = _size; num >= 1; num--)
		{
			FloatDown(num);
		}
		_initialized = true;
	}

	public PQHandle Insert(TValue value)
	{
		int num = ++_size;
		if (num * 2 > _max)
		{
			_max <<= 1;
			Array.Resize(ref _nodes, _max + 1);
			Array.Resize(ref _handles, _max + 1);
		}
		int num2;
		if (_freeList == 0)
		{
			num2 = num;
		}
		else
		{
			num2 = _freeList;
			_freeList = _handles[num2]._node;
		}
		_nodes[num] = num2;
		if (_handles[num2] == null)
		{
			_handles[num2] = new HandleElem
			{
				_key = value,
				_node = num
			};
		}
		else
		{
			_handles[num2]._node = num;
			_handles[num2]._key = value;
		}
		if (_initialized)
		{
			FloatUp(num);
		}
		return new PQHandle
		{
			_handle = num2
		};
	}

	public TValue ExtractMin()
	{
		int num = _nodes[1];
		TValue key = _handles[num]._key;
		if (_size > 0)
		{
			_nodes[1] = _nodes[_size];
			_handles[_nodes[1]]._node = 1;
			_handles[num]._key = null;
			_handles[num]._node = _freeList;
			_freeList = num;
			if (--_size > 0)
			{
				FloatDown(1);
			}
		}
		return key;
	}

	public TValue Minimum()
	{
		return _handles[_nodes[1]]._key;
	}

	public void Remove(PQHandle handle)
	{
		int handle2 = handle._handle;
		int node = _handles[handle2]._node;
		_nodes[node] = _nodes[_size];
		_handles[_nodes[node]]._node = node;
		if (node <= --_size)
		{
			if (node <= 1 || _leq(_handles[_nodes[node >> 1]]._key, _handles[_nodes[node]]._key))
			{
				FloatDown(node);
			}
			else
			{
				FloatUp(node);
			}
		}
		_handles[handle2]._key = null;
		_handles[handle2]._node = _freeList;
		_freeList = handle2;
	}
}
