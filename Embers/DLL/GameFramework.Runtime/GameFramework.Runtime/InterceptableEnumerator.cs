#define ENABLE_WARNING_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using UnityEngine;

namespace GameFramework.Runtime;

public class InterceptableEnumerator : IEnumerator
{
	private const int CAPACITY = 100;

	private static readonly ConcurrentQueue<InterceptableEnumerator> pools = new ConcurrentQueue<InterceptableEnumerator>();

	private object current;

	private Stack<IEnumerator> stack = new Stack<IEnumerator>();

	private List<Func<bool>> hasNext = new List<Func<bool>>();

	private Action<Exception> onException;

	private Action onFinally;

	public object Current => current;

	public static InterceptableEnumerator Create(IEnumerator routine)
	{
		if (pools.TryDequeue(out var result))
		{
			result.stack.Push(routine);
			return result;
		}
		return new InterceptableEnumerator(routine);
	}

	private static void Free(InterceptableEnumerator enumerator)
	{
		if (pools.Count <= 100)
		{
			enumerator.Clear();
			pools.Enqueue(enumerator);
		}
	}

	public InterceptableEnumerator(IEnumerator routine)
	{
		stack.Push(routine);
	}

	public bool MoveNext()
	{
		try
		{
			if (!HasNext())
			{
				OnFinally();
				return false;
			}
			if (stack.Count <= 0)
			{
				OnFinally();
				return false;
			}
			IEnumerator enumerator = stack.Peek();
			if (!enumerator.MoveNext())
			{
				stack.Pop();
				return MoveNext();
			}
			current = enumerator.Current;
			if (current is IEnumerator)
			{
				stack.Push(current as IEnumerator);
				return MoveNext();
			}
			if (current is Coroutine)
			{
				Log.Warning("The Enumerator's results contains the 'UnityEngine.Coroutine' type,If occurs an exception,it can't be catched.It is recommended to use 'yield return routine',rather than 'yield return StartCoroutine(routine)'.");
			}
			return true;
		}
		catch (Exception e)
		{
			OnException(e);
			OnFinally();
			return false;
		}
	}

	public void Reset()
	{
		throw new NotSupportedException();
	}

	private void OnException(Exception e)
	{
		try
		{
			if (onException != null)
			{
				onException(e);
			}
		}
		catch (Exception)
		{
		}
	}

	private void OnFinally()
	{
		try
		{
			if (onFinally != null)
			{
				onFinally();
			}
		}
		catch (Exception)
		{
		}
		finally
		{
			Free(this);
		}
	}

	private void Clear()
	{
		current = null;
		onException = null;
		onFinally = null;
		hasNext.Clear();
		stack.Clear();
	}

	private bool HasNext()
	{
		if (hasNext.Count > 0)
		{
			foreach (Func<bool> item in hasNext)
			{
				if (!item())
				{
					return false;
				}
			}
		}
		return true;
	}

	public virtual void RegisterConditionBlock(Func<bool> hasNext)
	{
		if (hasNext != null)
		{
			this.hasNext.Add(hasNext);
		}
	}

	public virtual void RegisterCatchBlock(Action<Exception> onException)
	{
		if (onException != null)
		{
			this.onException = (Action<Exception>)Delegate.Combine(this.onException, onException);
		}
	}

	public virtual void RegisterFinallyBlock(Action onFinally)
	{
		if (onFinally != null)
		{
			this.onFinally = (Action)Delegate.Combine(this.onFinally, onFinally);
		}
	}
}
