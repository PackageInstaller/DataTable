using System;
using System.Collections.Concurrent;
using System.Diagnostics;
using System.Threading;

namespace Unity.VisualScripting;

public static class UnityThread
{
	public static Thread thread = Thread.CurrentThread;

	public static Action<Action> editorAsync;

	public static ConcurrentQueue<Action> pendingQueue = new ConcurrentQueue<Action>();

	public static bool allowsAPI
	{
		get
		{
			if (!Serialization.isUnitySerializing)
			{
				return Thread.CurrentThread == thread;
			}
			return false;
		}
	}

	internal static void RuntimeInitialize()
	{
		thread = Thread.CurrentThread;
	}

	[Conditional("UNITY_EDITOR")]
	public static void EditorAsync(Action action)
	{
		if (editorAsync == null)
		{
			pendingQueue.Enqueue(action);
		}
		else
		{
			editorAsync(action);
		}
	}
}
