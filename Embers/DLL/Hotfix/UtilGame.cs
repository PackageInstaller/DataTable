using System;
using System.Collections.Generic;

public static class UtilGame
{
	public static void ForeachLinkList<T>(LinkedList<T> List, Action<LinkedListNode<T>> action)
	{
		LinkedListNode<T> linkedListNode = List.First;
		if (linkedListNode != null)
		{
			while (linkedListNode != null)
			{
				LinkedListNode<T> obj = linkedListNode;
				linkedListNode = linkedListNode.Next;
				action(obj);
			}
		}
	}
}
