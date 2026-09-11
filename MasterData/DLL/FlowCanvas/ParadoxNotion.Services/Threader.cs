using System;
using System.Collections;
using System.Threading;

namespace ParadoxNotion.Services;

public static class Threader
{
	public static Thread StartAction(Action function, Action callback = null)
	{
		Thread thread = new Thread(function.Invoke);
		Begin(thread, callback);
		return thread;
	}

	public static Thread StartAction<T1>(Action<T1> function, T1 parameter1, Action callback = null)
	{
		Thread thread = new Thread((ThreadStart)delegate
		{
			function(parameter1);
		});
		Begin(thread, callback);
		return thread;
	}

	public static Thread StartAction<T1, T2>(Action<T1, T2> function, T1 parameter1, T2 parameter2, Action callback = null)
	{
		Thread thread = new Thread((ThreadStart)delegate
		{
			function(parameter1, parameter2);
		});
		Begin(thread, callback);
		return thread;
	}

	public static Thread StartAction<T1, T2, T3>(Action<T1, T2, T3> function, T1 parameter1, T2 parameter2, T3 parameter3, Action callback = null)
	{
		Thread thread = new Thread((ThreadStart)delegate
		{
			function(parameter1, parameter2, parameter3);
		});
		Begin(thread, callback);
		return thread;
	}

	public static Thread StartFunction<TResult>(Func<TResult> function, Action<TResult> callback = null)
	{
		TResult result = default(TResult);
		Thread thread = new Thread((ThreadStart)delegate
		{
			result = function();
		});
		Begin(thread, delegate
		{
			callback(result);
		});
		return thread;
	}

	public static Thread StartFunction<TResult, T1>(Func<T1, TResult> function, T1 parameter1, Action<TResult> callback = null)
	{
		TResult result = default(TResult);
		Thread thread = new Thread((ThreadStart)delegate
		{
			result = function(parameter1);
		});
		Begin(thread, delegate
		{
			callback(result);
		});
		return thread;
	}

	public static Thread StartFunction<TResult, T1, T2>(Func<T1, T2, TResult> function, T1 parameter1, T2 parameter2, Action<TResult> callback = null)
	{
		TResult result = default(TResult);
		Thread thread = new Thread((ThreadStart)delegate
		{
			result = function(parameter1, parameter2);
		});
		Begin(thread, delegate
		{
			callback(result);
		});
		return thread;
	}

	public static Thread StartFunction<TResult, T1, T2, T3>(Func<T1, T2, T3, TResult> function, T1 parameter1, T2 parameter2, T3 parameter3, Action<TResult> callback = null)
	{
		TResult result = default(TResult);
		Thread thread = new Thread((ThreadStart)delegate
		{
			result = function(parameter1, parameter2, parameter3);
		});
		Begin(thread, delegate
		{
			callback(result);
		});
		return thread;
	}

	private static void Begin(Thread thread, Action callback)
	{
		thread.Start();
		MonoManager.current.StartCoroutine(ThreadUpdater(thread, callback));
	}

	private static IEnumerator ThreadUpdater(Thread thread, Action callback)
	{
		while (thread.IsAlive)
		{
			yield return null;
		}
		yield return null;
		if ((thread.ThreadState & ThreadState.AbortRequested) != ThreadState.AbortRequested)
		{
			callback?.Invoke();
		}
	}
}
