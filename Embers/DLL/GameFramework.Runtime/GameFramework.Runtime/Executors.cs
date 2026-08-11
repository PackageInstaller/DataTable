#define ENABLE_DEBUG_AND_ABOVE_LOG
#define ENABLE_INFO_AND_ABOVE_LOG
#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;

namespace GameFramework.Runtime;

public class Executors
{
	private class MainThreadExecutor : MonoBehaviour
	{
		public bool useFixedUpdate = false;

		private List<object> pendingQueue = new List<object>();

		private List<object> stopingQueue = new List<object>();

		private List<object> runningQueue = new List<object>();

		private List<object> stopingTempQueue = new List<object>();

		private void OnApplicationQuit()
		{
			StopAllCoroutines();
			Executors.Destroy();
			if (base.gameObject != null)
			{
				UnityEngine.Object.Destroy(base.gameObject);
			}
		}

		private void Update()
		{
			if (!useFixedUpdate && (pendingQueue.Count > 0 || stopingQueue.Count > 0))
			{
				DoStopingQueue();
				DoPendingQueue();
			}
		}

		private void FixedUpdate()
		{
			if (useFixedUpdate && (pendingQueue.Count > 0 || stopingQueue.Count > 0))
			{
				DoStopingQueue();
				DoPendingQueue();
			}
		}

		protected void DoStopingQueue()
		{
			lock (stopingQueue)
			{
				if (stopingQueue.Count <= 0)
				{
					return;
				}
				stopingTempQueue.Clear();
				stopingTempQueue.AddRange(stopingQueue);
				stopingQueue.Clear();
			}
			for (int i = 0; i < stopingTempQueue.Count; i++)
			{
				try
				{
					object obj = stopingTempQueue[i];
					if (obj is IEnumerator)
					{
						StopCoroutine((IEnumerator)obj);
					}
					else if (obj is Coroutine)
					{
						StopCoroutine((Coroutine)obj);
					}
				}
				catch (Exception arg)
				{
					Log.Warning("Task stop exception! error:{0}", arg);
				}
			}
			stopingTempQueue.Clear();
		}

		protected void DoPendingQueue()
		{
			lock (pendingQueue)
			{
				if (pendingQueue.Count <= 0)
				{
					return;
				}
				runningQueue.Clear();
				runningQueue.AddRange(pendingQueue);
				pendingQueue.Clear();
			}
			float realtimeSinceStartup = Time.realtimeSinceStartup;
			for (int i = 0; i < runningQueue.Count; i++)
			{
				try
				{
					object obj = runningQueue[i];
					if (obj is Action)
					{
						((Action)obj)();
					}
					else if (obj is IEnumerator)
					{
						StartCoroutine((IEnumerator)obj);
					}
				}
				catch (Exception arg)
				{
					Log.Warning("Task execution exception! error:{0}", arg);
				}
			}
			runningQueue.Clear();
			float num = Time.realtimeSinceStartup - realtimeSinceStartup;
			if (!(num > 0.15f))
			{
			}
		}

		public void Execute(Action action)
		{
			if (action == null)
			{
				return;
			}
			lock (pendingQueue)
			{
				pendingQueue.Add(action);
			}
		}

		public void Execute(IEnumerator routine)
		{
			if (routine == null)
			{
				return;
			}
			lock (pendingQueue)
			{
				pendingQueue.Add(routine);
			}
		}

		public void Stop(IEnumerator routine)
		{
			if (routine == null)
			{
				return;
			}
			lock (pendingQueue)
			{
				if (pendingQueue.Contains(routine))
				{
					pendingQueue.Remove(routine);
					return;
				}
			}
			lock (stopingQueue)
			{
				stopingQueue.Add(routine);
			}
		}

		public void Stop(Coroutine routine)
		{
			if (routine == null)
			{
				return;
			}
			lock (stopingQueue)
			{
				stopingQueue.Add(routine);
			}
		}
	}

	private static readonly object syncLock = new object();

	private static bool disposed = false;

	private static MainThreadExecutor executor;

	private static SynchronizationContext context;

	private static int mainThreadId;

	private static Dictionary<int, Thread> threads = new Dictionary<int, Thread>();

	public static bool UseFixedUpdate
	{
		get
		{
			return executor.useFixedUpdate;
		}
		set
		{
			executor.useFixedUpdate = value;
		}
	}

	public static bool IsMainThread => Environment.CurrentManagedThreadId == mainThreadId;

	private static void Destroy()
	{
		disposed = true;
		lock (threads)
		{
			foreach (Thread value in threads.Values)
			{
				try
				{
					value.Abort();
				}
				catch (Exception)
				{
				}
			}
			threads.Clear();
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
	private static void OnRuntimeCreate()
	{
		disposed = false;
		executor = null;
		context = null;
		Create();
	}

	private static void CheckDisposed()
	{
		if (disposed)
		{
			throw new ObjectDisposedException("Executors");
		}
	}

	private static MainThreadExecutor CreateMainThreadExecutor(bool dontDestroy, bool useFixedUpdate)
	{
		GameObject gameObject = new GameObject("MainThreadExecutor");
		MainThreadExecutor mainThreadExecutor = gameObject.AddComponent<MainThreadExecutor>();
		gameObject.hideFlags = HideFlags.HideAndDontSave;
		if (dontDestroy)
		{
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
		}
		mainThreadExecutor.useFixedUpdate = useFixedUpdate;
		return mainThreadExecutor;
	}

	public static void Create(bool dontDestroy = true, bool useFixedUpdate = false)
	{
		lock (syncLock)
		{
			try
			{
				if (!(executor != null))
				{
					mainThreadId = Environment.CurrentManagedThreadId;
					executor = CreateMainThreadExecutor(dontDestroy, useFixedUpdate);
					context = SynchronizationContext.Current;
				}
			}
			catch (Exception arg)
			{
				Log.Error("Start Executors failure.Exception:{0}", arg);
			}
		}
	}

	public static void RunOnMainThread(Action action, bool waitForExecution = false)
	{
		if (!disposed)
		{
			if (waitForExecution)
			{
				AsyncResult asyncResult = new AsyncResult();
				RunOnMainThread(action, asyncResult);
				asyncResult.Synchronized().WaitForResult();
			}
			else if (IsMainThread)
			{
				action();
			}
			else
			{
				context.Post(DoAction, action);
			}
		}
	}

	private static void DoAction(object state)
	{
		((Action)state)?.Invoke();
	}

	public static TResult RunOnMainThread<TResult>(Func<TResult> func)
	{
		if (disposed)
		{
			return default(TResult);
		}
		AsyncResult<TResult> asyncResult = new AsyncResult<TResult>();
		RunOnMainThread(func, asyncResult);
		return asyncResult.Synchronized().WaitForResult();
	}

	public static void RunOnMainThread(Action action, IPromise promise)
	{
		try
		{
			CheckDisposed();
			if (IsMainThread)
			{
				action();
				promise.SetResult();
				return;
			}
			context.Post(delegate
			{
				try
				{
					action();
					promise.SetResult();
				}
				catch (Exception exception2)
				{
					promise.SetException(exception2);
				}
			}, null);
		}
		catch (Exception exception)
		{
			promise.SetException(exception);
		}
	}

	public static void RunOnMainThread<TResult>(Func<TResult> func, IPromise<TResult> promise)
	{
		try
		{
			CheckDisposed();
			if (IsMainThread)
			{
				promise.SetResult(func());
				return;
			}
			context.Post(delegate
			{
				try
				{
					promise.SetResult(func());
				}
				catch (Exception exception2)
				{
					promise.SetException(exception2);
				}
			}, null);
		}
		catch (Exception exception)
		{
			promise.SetException(exception);
		}
	}

	public static object WaitWhile(Func<bool> predicate)
	{
		if (executor != null && IsMainThread)
		{
			return new WaitWhile(predicate);
		}
		throw new NotSupportedException("The function must execute on main thread.");
	}

	protected static InterceptableEnumerator WrapEnumerator(IEnumerator routine, IPromise promise)
	{
		InterceptableEnumerator interceptableEnumerator = ((routine is InterceptableEnumerator) ? ((InterceptableEnumerator)routine) : InterceptableEnumerator.Create(routine));
		if (promise != null)
		{
			interceptableEnumerator.RegisterConditionBlock(() => !promise.IsCancellationRequested);
			interceptableEnumerator.RegisterCatchBlock(delegate(Exception e)
			{
				if (promise != null)
				{
					promise.SetException(e);
				}
				Log.Error(e);
			});
			interceptableEnumerator.RegisterFinallyBlock(delegate
			{
				if (promise != null && !promise.IsDone)
				{
					if (promise.GetType().IsSubclassOfGenericTypeDefinition(typeof(IPromise<>)))
					{
						promise.SetException(new Exception("No value given the Result"));
					}
					else
					{
						promise.SetResult();
					}
				}
			});
		}
		return interceptableEnumerator;
	}

	public static void RunOnCoroutineNoReturn(IEnumerator routine)
	{
		if (!disposed && !(executor == null))
		{
			if (IsMainThread)
			{
				executor.StartCoroutine(routine);
			}
			else
			{
				context.Post(DoStartCoroutine, routine);
			}
		}
	}

	private static void DoStartCoroutine(object state)
	{
		IEnumerator enumerator = (IEnumerator)state;
		if (enumerator != null)
		{
			executor.StartCoroutine(enumerator);
		}
	}

	public static Coroutine RunOnCoroutineReturn(IEnumerator routine)
	{
		if (disposed || executor == null)
		{
			return null;
		}
		if (IsMainThread)
		{
			return executor.StartCoroutine(routine);
		}
		AsyncResult<Coroutine> result = new AsyncResult<Coroutine>();
		executor.Execute(delegate
		{
			try
			{
				Coroutine result2 = executor.StartCoroutine(routine);
				result.SetResult(result2);
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return result.Synchronized().WaitForResult();
	}

	internal static void StopCoroutine(Coroutine routine)
	{
		if (!disposed && !(executor == null))
		{
			if (IsMainThread)
			{
				executor.StopCoroutine(routine);
			}
			else
			{
				executor.Stop(routine);
			}
		}
	}

	internal static void DoRunOnCoroutine(IEnumerator routine, ICoroutinePromise promise)
	{
		if (disposed)
		{
			promise.SetException(new ObjectDisposedException("Executors"));
			return;
		}
		if (executor == null)
		{
			promise.SetException(new ArgumentNullException("executor"));
			return;
		}
		if (IsMainThread)
		{
			Coroutine coroutine = executor.StartCoroutine(WrapEnumerator(routine, promise));
			promise.AddCoroutine(coroutine);
			return;
		}
		executor.Execute(delegate
		{
			try
			{
				Coroutine coroutine2 = executor.StartCoroutine(WrapEnumerator(routine, promise));
				promise.AddCoroutine(coroutine2);
			}
			catch (Exception exception)
			{
				promise.SetException(exception);
			}
		});
	}

	public static IAsyncResult RunOnCoroutine(IEnumerator routine)
	{
		CoroutineResult coroutineResult = new CoroutineResult();
		DoRunOnCoroutine(routine, coroutineResult);
		return coroutineResult;
	}

	public static IAsyncResult RunOnCoroutine(Func<IPromise, IEnumerator> func)
	{
		CoroutineResult coroutineResult = new CoroutineResult();
		DoRunOnCoroutine(func(coroutineResult), coroutineResult);
		return coroutineResult;
	}

	public static IAsyncResult RunOnCoroutine<TResult>(Func<IPromise<TResult>, IEnumerator> func)
	{
		CoroutineResult<TResult> coroutineResult = new CoroutineResult<TResult>();
		DoRunOnCoroutine(func(coroutineResult), coroutineResult);
		return coroutineResult;
	}

	public static IProgressResult<TProgress> RunOnCoroutine<TProgress>(Func<IProgressPromise<TProgress>, IEnumerator> func)
	{
		CoroutineProgressResult<TProgress> coroutineProgressResult = new CoroutineProgressResult<TProgress>();
		DoRunOnCoroutine(func(coroutineProgressResult), coroutineProgressResult);
		return coroutineProgressResult;
	}

	public static IProgressResult<TProgress, TResult> RunOnCoroutine<TProgress, TResult>(Func<IProgressPromise<TProgress, TResult>, IEnumerator> func)
	{
		CoroutineProgressResult<TProgress, TResult> coroutineProgressResult = new CoroutineProgressResult<TProgress, TResult>();
		DoRunOnCoroutine(func(coroutineProgressResult), coroutineProgressResult);
		return coroutineProgressResult;
	}

	public static void RunOnCoroutine(IEnumerator routine, IPromise promise)
	{
		if (disposed)
		{
			promise.SetException(new ObjectDisposedException("Executors"));
		}
		else if (executor == null)
		{
			promise.SetException(new ArgumentNullException("executor"));
		}
		else if (IsMainThread)
		{
			executor.StartCoroutine(WrapEnumerator(routine, promise));
		}
		else
		{
			executor.Execute(WrapEnumerator(routine, promise));
		}
	}

	private static void DoRunAsync(Action action)
	{
		ThreadPool.QueueUserWorkItem(delegate
		{
			Thread currentThread = Thread.CurrentThread;
			try
			{
				lock (threads)
				{
					threads[currentThread.ManagedThreadId] = currentThread;
				}
				action();
			}
			finally
			{
				lock (threads)
				{
					threads.Remove(currentThread.ManagedThreadId);
				}
			}
		});
	}

	public static void RunAsyncNoReturn(Action action)
	{
		DoRunAsync(action);
	}

	public static void RunAsyncNoReturn<T>(Action<T> action, T t)
	{
		DoRunAsync(delegate
		{
			action(t);
		});
	}

	public static IAsyncResult RunAsync(Action action)
	{
		AsyncResult result = new AsyncResult();
		DoRunAsync(delegate
		{
			try
			{
				CheckDisposed();
				action();
				result.SetResult();
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return result;
	}

	public static IAsyncResult RunAsync<TResult>(Func<TResult> func)
	{
		AsyncResult<TResult> result = new AsyncResult<TResult>();
		DoRunAsync(delegate
		{
			try
			{
				CheckDisposed();
				TResult result2 = func();
				result.SetResult(result2);
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return result;
	}

	public static IAsyncResult RunAsync(Action<IPromise> action)
	{
		AsyncResult result = new AsyncResult();
		DoRunAsync(delegate
		{
			try
			{
				CheckDisposed();
				action(result);
				if (!result.IsDone)
				{
					result.SetResult();
				}
			}
			catch (Exception exception)
			{
				if (!result.IsDone)
				{
					result.SetException(exception);
				}
			}
		});
		return result;
	}

	public static IProgressResult<TProgress> RunAsync<TProgress>(Action<IProgressPromise<TProgress>> action)
	{
		ProgressResult<TProgress> result = new ProgressResult<TProgress>();
		DoRunAsync(delegate
		{
			try
			{
				CheckDisposed();
				action(result);
				if (!result.IsDone)
				{
					result.SetResult();
				}
			}
			catch (Exception exception)
			{
				if (!result.IsDone)
				{
					result.SetException(exception);
				}
			}
		});
		return result;
	}

	public static IAsyncResult RunAsync<TResult>(Action<IPromise<TResult>> action)
	{
		AsyncResult<TResult> result = new AsyncResult<TResult>();
		DoRunAsync(delegate
		{
			try
			{
				CheckDisposed();
				action(result);
				if (!result.IsDone)
				{
					result.SetResult();
				}
			}
			catch (Exception exception)
			{
				if (!result.IsDone)
				{
					result.SetException(exception);
				}
			}
		});
		return result;
	}

	public static IProgressResult<TProgress, TResult> RunAsync<TProgress, TResult>(Action<IProgressPromise<TProgress, TResult>> action)
	{
		ProgressResult<TProgress, TResult> result = new ProgressResult<TProgress, TResult>();
		DoRunAsync(delegate
		{
			try
			{
				CheckDisposed();
				action(result);
				if (!result.IsDone)
				{
					result.SetResult();
				}
			}
			catch (Exception exception)
			{
				if (!result.IsDone)
				{
					result.SetException(exception);
				}
			}
		});
		return result;
	}
}
