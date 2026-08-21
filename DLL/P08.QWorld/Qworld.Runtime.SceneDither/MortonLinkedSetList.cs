using System.Collections.Generic;

namespace Qworld.Runtime.SceneDither;

public class MortonLinkedSetList
{
	public IMortonTreeObject head;

	public IMortonTreeObject tail;

	public int Count;

	private Dictionary<uint, bool> alreadExist;

	public static MortonLinkedSetList GetList()
	{
		return new MortonLinkedSetList
		{
			Count = 0,
			alreadExist = new Dictionary<uint, bool>(10)
		};
	}

	public void AddLast(IMortonTreeObject node)
	{
		if (node.GetComponentVersion() != 0 && !alreadExist.ContainsKey(node.GetComponentVersion()))
		{
			alreadExist.Add(node.GetComponentVersion(), value: true);
			if (head == null)
			{
				head = node;
				tail = node;
			}
			else
			{
				node.preEntity = tail;
				tail.nextEntity = node;
				tail = node;
			}
			Count++;
		}
	}

	public void Remove(IMortonTreeObject node)
	{
		if (node == null || node.GetComponentVersion() == 0 || !alreadExist.ContainsKey(node.GetComponentVersion()))
		{
			return;
		}
		alreadExist.Remove(node.GetComponentVersion());
		if (node.preEntity != null)
		{
			if (tail == node)
			{
				tail = node.preEntity;
			}
			else
			{
				node.nextEntity.preEntity = node.preEntity;
				node.preEntity.nextEntity = node.nextEntity;
			}
		}
		else if (Count <= 1)
		{
			head = null;
			tail = null;
		}
		else
		{
			head = node.nextEntity;
			if (head != null)
			{
				head.preEntity = null;
			}
		}
		node.preEntity = null;
		node.nextEntity = null;
		Count--;
	}

	public bool Contains(IMortonTreeObject node)
	{
		return alreadExist.ContainsKey(node.GetComponentVersion());
	}

	public void Dispose()
	{
	}
}
