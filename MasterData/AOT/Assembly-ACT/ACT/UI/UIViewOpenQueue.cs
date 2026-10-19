using System;
using System.Collections.Generic;
using System.Linq;

namespace ACT.UI;

public class UIViewOpenQueue
{
	private LinkedList<OpenQueueInfo> openInfoLinkedList = new LinkedList<OpenQueueInfo>();

	public bool pause;

	public int Count => openInfoLinkedList.Count;

	public void Enqueue(OpenQueueInfo info)
	{
		openInfoLinkedList.AddLast(info);
	}

	public OpenQueueInfo Dequeue()
	{
		if (openInfoLinkedList.Count == 0)
		{
			throw new InvalidOperationException("UIOpenQueue is empty.");
		}
		OpenQueueInfo value = openInfoLinkedList.First.Value;
		openInfoLinkedList.RemoveFirst();
		return value;
	}

	public OpenQueueInfo Peek()
	{
		if (openInfoLinkedList.Count == 0)
		{
			throw new InvalidOperationException("UIOpenQueue is empty.");
		}
		return openInfoLinkedList.First.Value;
	}

	public void Clear()
	{
		openInfoLinkedList.Clear();
	}

	public bool Contains(UI_TYPE uiType)
	{
		return openInfoLinkedList.Any((OpenQueueInfo info) => info.uiType == uiType);
	}
}
