using System;
using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks;

public struct TriggerEvent<T>
{
	private ITriggerHandler<T> head;

	private ITriggerHandler<T> iteratingHead;

	private ITriggerHandler<T> iteratingNode;

	private void LogError(Exception ex)
	{
		Debug.LogException(ex);
	}

	public void SetResult(T value)
	{
		if (iteratingNode != null)
		{
			throw new InvalidOperationException("Can not trigger itself in iterating.");
		}
		for (ITriggerHandler<T> triggerHandler = head; triggerHandler != null; triggerHandler = ((triggerHandler == iteratingNode) ? triggerHandler.Next : iteratingNode))
		{
			iteratingNode = triggerHandler;
			try
			{
				triggerHandler.OnNext(value);
			}
			catch (Exception ex)
			{
				LogError(ex);
				Remove(triggerHandler);
			}
		}
		iteratingNode = null;
		if (iteratingHead != null)
		{
			Add(iteratingHead);
			iteratingHead = null;
		}
	}

	public void SetCanceled(CancellationToken cancellationToken)
	{
		if (iteratingNode != null)
		{
			throw new InvalidOperationException("Can not trigger itself in iterating.");
		}
		ITriggerHandler<T> triggerHandler = head;
		while (triggerHandler != null)
		{
			iteratingNode = triggerHandler;
			try
			{
				triggerHandler.OnCanceled(cancellationToken);
			}
			catch (Exception ex)
			{
				LogError(ex);
			}
			ITriggerHandler<T> obj = ((triggerHandler == iteratingNode) ? triggerHandler.Next : iteratingNode);
			iteratingNode = null;
			Remove(triggerHandler);
			triggerHandler = obj;
		}
		iteratingNode = null;
		if (iteratingHead != null)
		{
			Add(iteratingHead);
			iteratingHead = null;
		}
	}

	public void SetCompleted()
	{
		if (iteratingNode != null)
		{
			throw new InvalidOperationException("Can not trigger itself in iterating.");
		}
		ITriggerHandler<T> triggerHandler = head;
		while (triggerHandler != null)
		{
			iteratingNode = triggerHandler;
			try
			{
				triggerHandler.OnCompleted();
			}
			catch (Exception ex)
			{
				LogError(ex);
			}
			ITriggerHandler<T> obj = ((triggerHandler == iteratingNode) ? triggerHandler.Next : iteratingNode);
			iteratingNode = null;
			Remove(triggerHandler);
			triggerHandler = obj;
		}
		iteratingNode = null;
		if (iteratingHead != null)
		{
			Add(iteratingHead);
			iteratingHead = null;
		}
	}

	public void SetError(Exception exception)
	{
		if (iteratingNode != null)
		{
			throw new InvalidOperationException("Can not trigger itself in iterating.");
		}
		ITriggerHandler<T> triggerHandler = head;
		while (triggerHandler != null)
		{
			iteratingNode = triggerHandler;
			try
			{
				triggerHandler.OnError(exception);
			}
			catch (Exception ex)
			{
				LogError(ex);
			}
			ITriggerHandler<T> obj = ((triggerHandler == iteratingNode) ? triggerHandler.Next : iteratingNode);
			iteratingNode = null;
			Remove(triggerHandler);
			triggerHandler = obj;
		}
		iteratingNode = null;
		if (iteratingHead != null)
		{
			Add(iteratingHead);
			iteratingHead = null;
		}
	}

	public void Add(ITriggerHandler<T> handler)
	{
		if (handler == null)
		{
			throw new ArgumentNullException("handler");
		}
		if (head == null)
		{
			head = handler;
		}
		else if (iteratingNode != null)
		{
			if (iteratingHead == null)
			{
				iteratingHead = handler;
				return;
			}
			ITriggerHandler<T> prev = iteratingHead.Prev;
			if (prev == null)
			{
				iteratingHead.Prev = handler;
				iteratingHead.Next = handler;
				handler.Prev = iteratingHead;
			}
			else
			{
				iteratingHead.Prev = handler;
				prev.Next = handler;
				handler.Prev = prev;
			}
		}
		else
		{
			ITriggerHandler<T> prev2 = head.Prev;
			if (prev2 == null)
			{
				head.Prev = handler;
				head.Next = handler;
				handler.Prev = head;
			}
			else
			{
				head.Prev = handler;
				prev2.Next = handler;
				handler.Prev = prev2;
			}
		}
	}

	public void Remove(ITriggerHandler<T> handler)
	{
		if (handler == null)
		{
			throw new ArgumentNullException("handler");
		}
		ITriggerHandler<T> prev = handler.Prev;
		ITriggerHandler<T> next = handler.Next;
		if (next != null)
		{
			next.Prev = prev;
		}
		if (handler == head)
		{
			head = next;
		}
		else if (prev != null)
		{
			prev.Next = next;
		}
		if (handler == iteratingNode)
		{
			iteratingNode = next;
		}
		if (handler == iteratingHead)
		{
			iteratingHead = next;
		}
		if (head != null && head.Prev == handler)
		{
			if (prev != head)
			{
				head.Prev = prev;
			}
			else
			{
				head.Prev = null;
			}
		}
		if (iteratingHead != null && iteratingHead.Prev == handler)
		{
			if (prev != iteratingHead.Prev)
			{
				iteratingHead.Prev = prev;
			}
			else
			{
				iteratingHead.Prev = null;
			}
		}
		handler.Prev = null;
		handler.Next = null;
	}
}
