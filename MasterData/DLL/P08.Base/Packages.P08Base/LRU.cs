using System;
using System.Collections.Generic;

namespace Packages.P08Base;

public class LRU
{
	private Dictionary<Type, Stack<CommonData>> dataPool;

	private Stack<Node<CommonData>> nodePool;

	private int max = 30;

	private NodeList list;

	private Dictionary<string, CommonData> table;

	private int count;

	private Node<CommonData> AllocNode()
	{
		if (nodePool == null)
		{
			nodePool = new Stack<Node<CommonData>>();
		}
		if (nodePool.Count <= 0)
		{
			return new Node<CommonData>();
		}
		return nodePool.Pop();
	}

	private bool ReleaseNode(Node<CommonData> node)
	{
		if (nodePool == null)
		{
			nodePool = new Stack<Node<CommonData>>();
		}
		bool result = true;
		if (node.before != null || node.next != null || node.data != null)
		{
			Log.LogError("节点不干净, 虽然在回收的时候清理了, 但是回收函数会返回失败");
			result = false;
		}
		node.before = null;
		node.next = null;
		node.data = null;
		node.count = 0;
		nodePool.Push(node);
		return result;
	}

	private Data<T> AllocData<T>() where T : class
	{
		if (dataPool == null)
		{
			dataPool = new Dictionary<Type, Stack<CommonData>>();
		}
		if (!dataPool.TryGetValue(typeof(T), out var value))
		{
			value = new Stack<CommonData>();
			dataPool[typeof(T)] = value;
		}
		if (value.Count <= 0)
		{
			return new Data<T>();
		}
		return (Data<T>)value.Pop();
	}

	private bool ReleaseData(CommonData data, Type type)
	{
		if (dataPool == null)
		{
			dataPool = new Dictionary<Type, Stack<CommonData>>();
		}
		if (!dataPool.TryGetValue(type, out var value))
		{
			value = new Stack<CommonData>();
			dataPool[type] = value;
		}
		bool result = true;
		if (data.node != null || data.target != null || data.destroyAction != null)
		{
			Log.LogError("data不干净, 虽然在回收的时候清理了, 但是回收函数会返回失败");
			result = false;
		}
		data.node = null;
		data.target = null;
		value.Push(data);
		return result;
	}

	public LRU(int maxListLength)
	{
		max = maxListLength;
		count = 0;
		nodePool = new Stack<Node<CommonData>>();
		dataPool = new Dictionary<Type, Stack<CommonData>>();
		table = new Dictionary<string, CommonData>();
		list = new NodeList();
	}

	public void SetMaxLength(int maxListLength)
	{
		if (maxListLength < 0)
		{
			Log.LogError("maxListLength, 不能小于0");
		}
		else
		{
			max = maxListLength;
		}
	}

	public T Get<T>(string key) where T : class
	{
		T val = null;
		Data<T> data = null;
		if (table.TryGetValue(key, out var value))
		{
			if (value == null)
			{
				Log.LogError("key存在但是data为空");
				val = null;
			}
			else
			{
				data = value as Data<T>;
				if (data == null)
				{
					Log.LogError("key存在但是类型不对");
					val = null;
				}
				else
				{
					val = data.target;
				}
			}
		}
		if (val != null)
		{
			list.MoveToFront(data.node);
		}
		return val;
	}

	public bool Put<T>(string key, T data, Action<string, T> actionDestroy) where T : class
	{
		if (table.ContainsKey(key))
		{
			Log.LogError("key 已经存在了 " + key);
			return false;
		}
		Data<T> data2 = AllocData<T>();
		Node<CommonData> node = AllocNode();
		node.data = data2;
		data2.key = key;
		data2.node = node;
		data2.target = data;
		data2.destroyAction = actionDestroy;
		table[key] = data2;
		list.AddToFront(node);
		count++;
		return true;
	}

	public bool LimitSize()
	{
		while (count > max)
		{
			CommonNode commonNode = list.RemoveLast();
			if (commonNode == null)
			{
				Log.LogError("节点为空了, 怎么回事");
				return false;
			}
			if (!(commonNode is Node<CommonData> { data: var data } node))
			{
				Log.LogError("节点类型不一样, 怎么回事");
				return false;
			}
			if (data == null)
			{
				Log.LogError("node 的 data 为空, 怎么回事");
				return false;
			}
			if (!table.TryGetValue(data.key, out var value))
			{
				Log.LogError("nodelist 里面存在但是table里面不存在, 怎么回事");
				return false;
			}
			if (data != value)
			{
				Log.LogError("nodelist 里面存的和table里面存的不一样, 怎么回事");
				return false;
			}
			if (!table.Remove(data.key))
			{
				Log.LogError("table移除失败, 怎么回事");
				return false;
			}
			count--;
			node.data = null;
			Type type = value.type;
			value.Reset();
			ReleaseNode(node);
			ReleaseData(value, type);
		}
		return true;
	}

	public override string ToString()
	{
		int num = 0;
		foreach (KeyValuePair<Type, Stack<CommonData>> item in dataPool)
		{
			num += item.Value.Count;
		}
		string text = "nodePoolCount = " + nodePool.Count + ", table.Count = " + table.Count + ", dataPool.Count = " + num;
		return list.ToString() + "\n" + text;
	}
}
