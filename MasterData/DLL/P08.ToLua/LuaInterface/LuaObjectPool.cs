using System;
using System.Collections.Generic;

namespace LuaInterface;

public class LuaObjectPool
{
	private class PoolNode
	{
		public int index;

		public object obj;

		public PoolNode(int index, object obj)
		{
			this.index = index;
			this.obj = obj;
		}
	}

	private List<PoolNode> list;

	private PoolNode head;

	private int count;

	private int collectStep = 2;

	private int collectedIndex = -1;

	public object this[int i]
	{
		get
		{
			if (i > 0 && i < count)
			{
				return list[i].obj;
			}
			return null;
		}
	}

	public LuaObjectPool()
	{
		list = new List<PoolNode>(1024);
		head = new PoolNode(0, null);
		list.Add(head);
		list.Add(new PoolNode(1, null));
		count = list.Count;
	}

	public void Clear()
	{
		list.Clear();
		head = null;
		count = 0;
	}

	public int Add(object obj)
	{
		int num = -1;
		if (head.index != 0)
		{
			num = head.index;
			list[num].obj = obj;
			head.index = list[num].index;
		}
		else
		{
			num = list.Count;
			list.Add(new PoolNode(num, obj));
			count = num + 1;
		}
		return num;
	}

	public object TryGetValue(int index)
	{
		if (index > 0 && index < count)
		{
			return list[index].obj;
		}
		return null;
	}

	public object Remove(int pos)
	{
		if (pos > 0 && pos < count)
		{
			object obj = list[pos].obj;
			list[pos].obj = null;
			list[pos].index = head.index;
			head.index = pos;
			return obj;
		}
		return null;
	}

	public object Destroy(int pos)
	{
		if (pos > 0 && pos < count)
		{
			object obj = list[pos].obj;
			list[pos].obj = null;
			return obj;
		}
		return null;
	}

	public void StepCollect(Action<object, int> collectListener)
	{
		collectedIndex++;
		for (int i = 0; i < collectStep; i++)
		{
			collectedIndex += i;
			if (collectedIndex >= count)
			{
				collectedIndex = -1;
				break;
			}
			PoolNode poolNode = list[collectedIndex];
			object obj = poolNode.obj;
			if (obj != null && obj.Equals(null))
			{
				poolNode.obj = null;
				collectListener?.Invoke(obj, collectedIndex);
			}
		}
	}

	public object Replace(int pos, object o)
	{
		if (pos > 0 && pos < count)
		{
			object obj = list[pos].obj;
			list[pos].obj = o;
			return obj;
		}
		return null;
	}
}
