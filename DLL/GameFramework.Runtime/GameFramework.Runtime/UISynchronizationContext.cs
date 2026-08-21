using System.Threading;
using UnityEngine;

namespace GameFramework.Runtime;

public class UISynchronizationContext
{
	private static int threadId;

	private static SynchronizationContext content;

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
	private static void OnInitialize()
	{
		content = SynchronizationContext.Current;
		threadId = Thread.CurrentThread.ManagedThreadId;
	}

	public static void Post(SendOrPostCallback callback, object state)
	{
		if (threadId == Thread.CurrentThread.ManagedThreadId)
		{
			callback(state);
		}
		else
		{
			content.Post(callback, state);
		}
	}

	public static void Send(SendOrPostCallback callback, object state)
	{
		if (threadId == Thread.CurrentThread.ManagedThreadId)
		{
			callback(state);
		}
		else
		{
			content.Send(callback, state);
		}
	}
}
