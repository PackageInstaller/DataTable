using System;
using System.Collections.Generic;
using System.Threading;

namespace Pathfinding.Util;

public class ParallelWorkQueue<T>
{
	public Action<T, int> action;

	public readonly int threadCount;

	private readonly Queue<T> queue;

	private readonly int initialCount;

	private ManualResetEvent[] waitEvents;

	private Exception innerException;

	public ParallelWorkQueue(Queue<T> queue)
	{
		this.queue = queue;
		initialCount = queue.Count;
		threadCount = Math.Min(initialCount, Math.Max(1, AstarPath.CalculateThreadCount(ThreadCount.AutomaticHighLoad)));
	}

	public IEnumerable<int> Run(int progressTimeoutMillis)
	{
		if (initialCount != queue.Count)
		{
			throw new InvalidOperationException("Queue has been modified since the constructor");
		}
		if (initialCount == 0)
		{
			yield break;
		}
		waitEvents = new ManualResetEvent[threadCount];
		for (int i = 0; i < waitEvents.Length; i++)
		{
			waitEvents[i] = new ManualResetEvent(initialState: false);
			ThreadPool.QueueUserWorkItem(delegate(object threadIndex)
			{
				RunTask((int)threadIndex);
			}, i);
		}
		while (true)
		{
			WaitHandle[] waitHandles = waitEvents;
			if (WaitHandle.WaitAll(waitHandles, progressTimeoutMillis))
			{
				break;
			}
			int count;
			lock (queue)
			{
				count = queue.Count;
			}
			yield return initialCount - count;
		}
		if (innerException == null)
		{
			yield break;
		}
		throw innerException;
	}

	private void RunTask(int threadIndex)
	{
		try
		{
			while (true)
			{
				T arg;
				lock (queue)
				{
					if (queue.Count == 0)
					{
						break;
					}
					arg = queue.Dequeue();
				}
				action(arg, threadIndex);
			}
		}
		catch (Exception ex)
		{
			innerException = ex;
			lock (queue)
			{
				queue.Clear();
			}
		}
		finally
		{
			waitEvents[threadIndex].Set();
		}
	}
}
