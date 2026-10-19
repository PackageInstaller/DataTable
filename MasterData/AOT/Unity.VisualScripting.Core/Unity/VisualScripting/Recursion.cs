using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

public class Recursion<T> : IPoolable, IDisposable
{
	private readonly Stack<T> traversedOrder;

	private readonly Dictionary<T, int> traversedCount;

	private bool disposed;

	protected int maxDepth;

	protected Recursion()
	{
		traversedOrder = new Stack<T>();
		traversedCount = new Dictionary<T, int>();
	}

	public void Enter(T o)
	{
		if (!TryEnter(o))
		{
			throw new StackOverflowException(string.Format("Max recursion depth of {0} has been exceeded. Consider increasing '{1}.{2}'.", maxDepth, "Recursion", "defaultMaxDepth"));
		}
	}

	public bool TryEnter(T o)
	{
		if (disposed)
		{
			throw new ObjectDisposedException(ToString());
		}
		if (traversedCount.TryGetValue(o, out var value))
		{
			if (value < maxDepth)
			{
				traversedOrder.Push(o);
				traversedCount[o]++;
				return true;
			}
			return false;
		}
		traversedOrder.Push(o);
		traversedCount.Add(o, 1);
		return true;
	}

	public void Exit(T o)
	{
		if (traversedOrder.Count == 0)
		{
			throw new InvalidOperationException("Trying to exit an empty recursion stack.");
		}
		T val = traversedOrder.Peek();
		if (!EqualityComparer<T>.Default.Equals(o, val))
		{
			throw new InvalidOperationException($"Exiting recursion stack in a non-consecutive order:\nProvided: {o} / Expected: {val}");
		}
		traversedOrder.Pop();
		if (traversedCount[val]-- == 0)
		{
			traversedCount.Remove(val);
		}
	}

	public void Dispose()
	{
		if (disposed)
		{
			throw new ObjectDisposedException(ToString());
		}
		Free();
	}

	protected virtual void Free()
	{
		GenericPool<Recursion<T>>.Free(this);
	}

	void IPoolable.New()
	{
		disposed = false;
	}

	void IPoolable.Free()
	{
		disposed = true;
		traversedCount.Clear();
		traversedOrder.Clear();
	}

	public static Recursion<T> New()
	{
		return New(Recursion.defaultMaxDepth);
	}

	public static Recursion<T> New(int maxDepth)
	{
		if (!Recursion.safeMode)
		{
			return null;
		}
		if (maxDepth < 1)
		{
			throw new ArgumentException("Max recursion depth must be at least one.", "maxDepth");
		}
		Recursion<T> recursion = GenericPool<Recursion<T>>.New(() => new Recursion<T>());
		recursion.maxDepth = maxDepth;
		return recursion;
	}
}
public sealed class Recursion : Recursion<object>
{
	public static int defaultMaxDepth { get; set; } = 100;

	public static bool safeMode { get; set; }

	private Recursion()
	{
	}

	internal static void OnRuntimeMethodLoad()
	{
		safeMode = Application.isEditor || Debug.isDebugBuild;
	}

	protected override void Free()
	{
		GenericPool<Recursion>.Free(this);
	}

	public new static Recursion New()
	{
		return New(defaultMaxDepth);
	}

	public new static Recursion New(int maxDepth)
	{
		if (!safeMode)
		{
			return null;
		}
		if (maxDepth < 1)
		{
			throw new ArgumentException("Max recursion depth must be at least one.", "maxDepth");
		}
		Recursion recursion = GenericPool<Recursion>.New(() => new Recursion());
		recursion.maxDepth = maxDepth;
		return recursion;
	}
}
