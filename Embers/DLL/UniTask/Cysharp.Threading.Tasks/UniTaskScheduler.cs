using System;
using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks;

public static class UniTaskScheduler
{
	public static bool PropagateOperationCanceledException = false;

	public static LogType UnobservedExceptionWriteLogType = LogType.Exception;

	public static bool DispatchUnityMainThread = true;

	private static readonly SendOrPostCallback handleExceptionInvoke = InvokeUnobservedTaskException;

	public static event Action<Exception> UnobservedTaskException;

	private static void InvokeUnobservedTaskException(object state)
	{
		UnobservedTaskException((Exception)state);
	}

	internal static void PublishUnobservedTaskException(Exception ex)
	{
		if (ex == null || (!PropagateOperationCanceledException && ex is OperationCanceledException))
		{
			return;
		}
		if (UnobservedTaskException != null)
		{
			if (!DispatchUnityMainThread || Thread.CurrentThread.ManagedThreadId == PlayerLoopHelper.MainThreadId)
			{
				UnobservedTaskException(ex);
			}
			else
			{
				PlayerLoopHelper.UnitySynchronizationContext.Post(handleExceptionInvoke, ex);
			}
			return;
		}
		string message = null;
		if (UnobservedExceptionWriteLogType != LogType.Exception)
		{
			message = "UnobservedTaskException: " + ex.ToString();
		}
		switch (UnobservedExceptionWriteLogType)
		{
		case LogType.Error:
			Debug.LogError(message);
			break;
		case LogType.Warning:
			Debug.LogWarning(message);
			break;
		case LogType.Log:
			Debug.Log(message);
			break;
		case LogType.Exception:
			Debug.LogException(ex);
			break;
		case LogType.Assert:
			break;
		}
	}
}
