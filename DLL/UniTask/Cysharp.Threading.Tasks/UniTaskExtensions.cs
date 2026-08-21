using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.ExceptionServices;
using System.Threading;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks;

public static class UniTaskExtensions
{
	private sealed class AttachExternalCancellationSource : IUniTaskSource
	{
		private static readonly Action<object> cancellationCallbackDelegate = CancellationCallback;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration tokenRegistration;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		public AttachExternalCancellationSource(UniTask task, CancellationToken cancellationToken)
		{
			this.cancellationToken = cancellationToken;
			tokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationCallbackDelegate, this);
			RunTask(task).Forget();
		}

		private async UniTaskVoid RunTask(UniTask task)
		{
			try
			{
				await task;
				core.TrySetResult(AsyncUnit.Default);
			}
			catch (Exception error)
			{
				core.TrySetException(error);
			}
			finally
			{
				tokenRegistration.Dispose();
			}
		}

		private static void CancellationCallback(object state)
		{
			AttachExternalCancellationSource attachExternalCancellationSource = (AttachExternalCancellationSource)state;
			attachExternalCancellationSource.core.TrySetCanceled(attachExternalCancellationSource.cancellationToken);
		}

		public void GetResult(short token)
		{
			core.GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}
	}

	private sealed class AttachExternalCancellationSource<T> : IUniTaskSource<T>, IUniTaskSource
	{
		private static readonly Action<object> cancellationCallbackDelegate = CancellationCallback;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration tokenRegistration;

		private UniTaskCompletionSourceCore<T> core;

		public AttachExternalCancellationSource(UniTask<T> task, CancellationToken cancellationToken)
		{
			this.cancellationToken = cancellationToken;
			tokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationCallbackDelegate, this);
			RunTask(task).Forget();
		}

		private async UniTaskVoid RunTask(UniTask<T> task)
		{
			try
			{
				T result = await task;
				core.TrySetResult(result);
			}
			catch (Exception error)
			{
				core.TrySetException(error);
			}
			finally
			{
				tokenRegistration.Dispose();
			}
		}

		private static void CancellationCallback(object state)
		{
			AttachExternalCancellationSource<T> attachExternalCancellationSource = (AttachExternalCancellationSource<T>)state;
			attachExternalCancellationSource.core.TrySetCanceled(attachExternalCancellationSource.cancellationToken);
		}

		void IUniTaskSource.GetResult(short token)
		{
			core.GetResult(token);
		}

		public T GetResult(short token)
		{
			return core.GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}
	}

	private sealed class ToCoroutineEnumerator : IEnumerator
	{
		private bool completed;

		private UniTask task;

		private Action<Exception> exceptionHandler;

		private bool isStarted;

		private ExceptionDispatchInfo exception;

		public object Current => null;

		public ToCoroutineEnumerator(UniTask task, Action<Exception> exceptionHandler)
		{
			completed = false;
			this.exceptionHandler = exceptionHandler;
			this.task = task;
		}

		private async UniTaskVoid RunTask(UniTask task)
		{
			try
			{
				await task;
			}
			catch (Exception ex)
			{
				if (exceptionHandler != null)
				{
					exceptionHandler(ex);
				}
				else
				{
					exception = ExceptionDispatchInfo.Capture(ex);
				}
			}
			finally
			{
				completed = true;
			}
		}

		public bool MoveNext()
		{
			if (!isStarted)
			{
				isStarted = true;
				RunTask(task).Forget();
			}
			if (exception != null)
			{
				exception.Throw();
				return false;
			}
			return !completed;
		}

		void IEnumerator.Reset()
		{
		}
	}

	private sealed class ToCoroutineEnumerator<T> : IEnumerator
	{
		private bool completed;

		private Action<T> resultHandler;

		private Action<Exception> exceptionHandler;

		private bool isStarted;

		private UniTask<T> task;

		private object current;

		private ExceptionDispatchInfo exception;

		public object Current => current;

		public ToCoroutineEnumerator(UniTask<T> task, Action<T> resultHandler, Action<Exception> exceptionHandler)
		{
			completed = false;
			this.task = task;
			this.resultHandler = resultHandler;
			this.exceptionHandler = exceptionHandler;
		}

		private async UniTaskVoid RunTask(UniTask<T> task)
		{
			try
			{
				T val = await task;
				current = val;
				if (resultHandler != null)
				{
					resultHandler(val);
				}
			}
			catch (Exception ex)
			{
				if (exceptionHandler != null)
				{
					exceptionHandler(ex);
				}
				else
				{
					exception = ExceptionDispatchInfo.Capture(ex);
				}
			}
			finally
			{
				completed = true;
			}
		}

		public bool MoveNext()
		{
			if (!isStarted)
			{
				isStarted = true;
				RunTask(task).Forget();
			}
			if (exception != null)
			{
				exception.Throw();
				return false;
			}
			return !completed;
		}

		void IEnumerator.Reset()
		{
		}
	}

	public static UniTask<T> AsUniTask<T>(this Task<T> task, bool useCurrentSynchronizationContext = true)
	{
		UniTaskCompletionSource<T> uniTaskCompletionSource = new UniTaskCompletionSource<T>();
		task.ContinueWith(delegate(Task<T> x, object state)
		{
			UniTaskCompletionSource<T> uniTaskCompletionSource2 = (UniTaskCompletionSource<T>)state;
			switch (x.Status)
			{
			case TaskStatus.Canceled:
				uniTaskCompletionSource2.TrySetCanceled();
				break;
			case TaskStatus.Faulted:
				uniTaskCompletionSource2.TrySetException(x.Exception.InnerException ?? x.Exception);
				break;
			case TaskStatus.RanToCompletion:
				uniTaskCompletionSource2.TrySetResult(x.Result);
				break;
			default:
				throw new NotSupportedException();
			}
		}, uniTaskCompletionSource, useCurrentSynchronizationContext ? TaskScheduler.FromCurrentSynchronizationContext() : TaskScheduler.Current);
		return uniTaskCompletionSource.Task;
	}

	public static UniTask AsUniTask(this Task task, bool useCurrentSynchronizationContext = true)
	{
		UniTaskCompletionSource uniTaskCompletionSource = new UniTaskCompletionSource();
		task.ContinueWith(delegate(Task x, object state)
		{
			UniTaskCompletionSource uniTaskCompletionSource2 = (UniTaskCompletionSource)state;
			switch (x.Status)
			{
			case TaskStatus.Canceled:
				uniTaskCompletionSource2.TrySetCanceled();
				break;
			case TaskStatus.Faulted:
				uniTaskCompletionSource2.TrySetException(x.Exception.InnerException ?? x.Exception);
				break;
			case TaskStatus.RanToCompletion:
				uniTaskCompletionSource2.TrySetResult();
				break;
			default:
				throw new NotSupportedException();
			}
		}, uniTaskCompletionSource, useCurrentSynchronizationContext ? TaskScheduler.FromCurrentSynchronizationContext() : TaskScheduler.Current);
		return uniTaskCompletionSource.Task;
	}

	public static Task<T> AsTask<T>(this UniTask<T> task)
	{
		try
		{
			UniTask<T>.Awaiter awaiter;
			try
			{
				awaiter = task.GetAwaiter();
			}
			catch (Exception exception)
			{
				return Task.FromException<T>(exception);
			}
			if (awaiter.IsCompleted)
			{
				try
				{
					return Task.FromResult(awaiter.GetResult());
				}
				catch (Exception exception2)
				{
					return Task.FromException<T>(exception2);
				}
			}
			TaskCompletionSource<T> taskCompletionSource = new TaskCompletionSource<T>();
			awaiter.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<TaskCompletionSource<T>, UniTask<T>.Awaiter> stateTuple = (StateTuple<TaskCompletionSource<T>, UniTask<T>.Awaiter>)state;
				var (taskCompletionSource3, awaiter3) = stateTuple;
				try
				{
					T result = awaiter3.GetResult();
					taskCompletionSource3.SetResult(result);
				}
				catch (Exception exception4)
				{
					taskCompletionSource3.SetException(exception4);
				}
			}, StateTuple.Create(taskCompletionSource, awaiter));
			return taskCompletionSource.Task;
		}
		catch (Exception exception3)
		{
			return Task.FromException<T>(exception3);
		}
	}

	public static Task AsTask(this UniTask task)
	{
		try
		{
			UniTask.Awaiter awaiter;
			try
			{
				awaiter = task.GetAwaiter();
			}
			catch (Exception exception)
			{
				return Task.FromException(exception);
			}
			if (awaiter.IsCompleted)
			{
				try
				{
					awaiter.GetResult();
					return Task.CompletedTask;
				}
				catch (Exception exception2)
				{
					return Task.FromException(exception2);
				}
			}
			TaskCompletionSource<object> taskCompletionSource = new TaskCompletionSource<object>();
			awaiter.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<TaskCompletionSource<object>, UniTask.Awaiter> stateTuple = (StateTuple<TaskCompletionSource<object>, UniTask.Awaiter>)state;
				var (taskCompletionSource3, awaiter3) = stateTuple;
				try
				{
					awaiter3.GetResult();
					taskCompletionSource3.SetResult(null);
				}
				catch (Exception exception4)
				{
					taskCompletionSource3.SetException(exception4);
				}
			}, StateTuple.Create(taskCompletionSource, awaiter));
			return taskCompletionSource.Task;
		}
		catch (Exception exception3)
		{
			return Task.FromException(exception3);
		}
	}

	public static AsyncLazy ToAsyncLazy(this UniTask task)
	{
		return new AsyncLazy(task);
	}

	public static AsyncLazy<T> ToAsyncLazy<T>(this UniTask<T> task)
	{
		return new AsyncLazy<T>(task);
	}

	public static UniTask AttachExternalCancellation(this UniTask task, CancellationToken cancellationToken)
	{
		if (!cancellationToken.CanBeCanceled)
		{
			return task;
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return UniTask.FromCanceled(cancellationToken);
		}
		if (task.Status.IsCompleted())
		{
			return task;
		}
		return new UniTask(new AttachExternalCancellationSource(task, cancellationToken), 0);
	}

	public static UniTask<T> AttachExternalCancellation<T>(this UniTask<T> task, CancellationToken cancellationToken)
	{
		if (!cancellationToken.CanBeCanceled)
		{
			return task;
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return UniTask.FromCanceled<T>(cancellationToken);
		}
		if (task.Status.IsCompleted())
		{
			return task;
		}
		return new UniTask<T>(new AttachExternalCancellationSource<T>(task, cancellationToken), 0);
	}

	public static IEnumerator ToCoroutine<T>(this UniTask<T> task, Action<T> resultHandler = null, Action<Exception> exceptionHandler = null)
	{
		return new ToCoroutineEnumerator<T>(task, resultHandler, exceptionHandler);
	}

	public static IEnumerator ToCoroutine(this UniTask task, Action<Exception> exceptionHandler = null)
	{
		return new ToCoroutineEnumerator(task, exceptionHandler);
	}

	public static async UniTask Timeout(this UniTask task, TimeSpan timeout, DelayType delayType = DelayType.DeltaTime, PlayerLoopTiming timeoutCheckTiming = PlayerLoopTiming.Update, CancellationTokenSource taskCancellationTokenSource = null)
	{
		CancellationTokenSource delayCancellationTokenSource = new CancellationTokenSource();
		UniTask<bool> task2 = UniTask.Delay(timeout, delayType, timeoutCheckTiming, delayCancellationTokenSource.Token).SuppressCancellationThrow();
		int num;
		bool flag;
		try
		{
			(num, flag, _) = await UniTask.WhenAny(task.SuppressCancellationThrow(), task2);
		}
		catch
		{
			delayCancellationTokenSource.Cancel();
			delayCancellationTokenSource.Dispose();
			throw;
		}
		if (num == 1)
		{
			if (taskCancellationTokenSource != null)
			{
				taskCancellationTokenSource.Cancel();
				taskCancellationTokenSource.Dispose();
			}
			TimeSpan timeSpan = timeout;
			throw new TimeoutException("Exceed Timeout:" + timeSpan);
		}
		delayCancellationTokenSource.Cancel();
		delayCancellationTokenSource.Dispose();
		if (flag)
		{
			Error.ThrowOperationCanceledException();
		}
	}

	public static async UniTask<T> Timeout<T>(this UniTask<T> task, TimeSpan timeout, DelayType delayType = DelayType.DeltaTime, PlayerLoopTiming timeoutCheckTiming = PlayerLoopTiming.Update, CancellationTokenSource taskCancellationTokenSource = null)
	{
		CancellationTokenSource delayCancellationTokenSource = new CancellationTokenSource();
		UniTask<bool> task2 = UniTask.Delay(timeout, delayType, timeoutCheckTiming, delayCancellationTokenSource.Token).SuppressCancellationThrow();
		int num;
		(bool, T) tuple2;
		try
		{
			(num, tuple2, _) = await UniTask.WhenAny(task.SuppressCancellationThrow(), task2);
		}
		catch
		{
			delayCancellationTokenSource.Cancel();
			delayCancellationTokenSource.Dispose();
			throw;
		}
		if (num == 1)
		{
			if (taskCancellationTokenSource != null)
			{
				taskCancellationTokenSource.Cancel();
				taskCancellationTokenSource.Dispose();
			}
			TimeSpan timeSpan = timeout;
			throw new TimeoutException("Exceed Timeout:" + timeSpan);
		}
		delayCancellationTokenSource.Cancel();
		delayCancellationTokenSource.Dispose();
		if (tuple2.Item1)
		{
			Error.ThrowOperationCanceledException();
		}
		return tuple2.Item2;
	}

	public static async UniTask<bool> TimeoutWithoutException(this UniTask task, TimeSpan timeout, DelayType delayType = DelayType.DeltaTime, PlayerLoopTiming timeoutCheckTiming = PlayerLoopTiming.Update, CancellationTokenSource taskCancellationTokenSource = null)
	{
		CancellationTokenSource delayCancellationTokenSource = new CancellationTokenSource();
		UniTask<bool> task2 = UniTask.Delay(timeout, delayType, timeoutCheckTiming, delayCancellationTokenSource.Token).SuppressCancellationThrow();
		int num;
		bool flag;
		try
		{
			(num, flag, _) = await UniTask.WhenAny(task.SuppressCancellationThrow(), task2);
		}
		catch
		{
			delayCancellationTokenSource.Cancel();
			delayCancellationTokenSource.Dispose();
			return true;
		}
		if (num == 1)
		{
			if (taskCancellationTokenSource != null)
			{
				taskCancellationTokenSource.Cancel();
				taskCancellationTokenSource.Dispose();
			}
			return true;
		}
		delayCancellationTokenSource.Cancel();
		delayCancellationTokenSource.Dispose();
		if (flag)
		{
			return true;
		}
		return false;
	}

	public static async UniTask<(bool IsTimeout, T Result)> TimeoutWithoutException<T>(this UniTask<T> task, TimeSpan timeout, DelayType delayType = DelayType.DeltaTime, PlayerLoopTiming timeoutCheckTiming = PlayerLoopTiming.Update, CancellationTokenSource taskCancellationTokenSource = null)
	{
		CancellationTokenSource delayCancellationTokenSource = new CancellationTokenSource();
		UniTask<bool> task2 = UniTask.Delay(timeout, delayType, timeoutCheckTiming, delayCancellationTokenSource.Token).SuppressCancellationThrow();
		int num;
		(bool, T) tuple2;
		try
		{
			(num, tuple2, _) = await UniTask.WhenAny(task.SuppressCancellationThrow(), task2);
		}
		catch
		{
			delayCancellationTokenSource.Cancel();
			delayCancellationTokenSource.Dispose();
			return (true, default(T));
		}
		if (num == 1)
		{
			if (taskCancellationTokenSource != null)
			{
				taskCancellationTokenSource.Cancel();
				taskCancellationTokenSource.Dispose();
			}
			return (true, default(T));
		}
		delayCancellationTokenSource.Cancel();
		delayCancellationTokenSource.Dispose();
		if (tuple2.Item1)
		{
			return (true, default(T));
		}
		return (false, tuple2.Item2);
	}

	public static void Forget(this UniTask task)
	{
		UniTask.Awaiter awaiter = task.GetAwaiter();
		if (awaiter.IsCompleted)
		{
			try
			{
				awaiter.GetResult();
				return;
			}
			catch (Exception ex)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex);
				return;
			}
		}
		awaiter.SourceOnCompleted(delegate(object state)
		{
			using StateTuple<UniTask.Awaiter> stateTuple = (StateTuple<UniTask.Awaiter>)state;
			try
			{
				stateTuple.Item1.GetResult();
			}
			catch (Exception ex2)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex2);
			}
		}, StateTuple.Create(awaiter));
	}

	public static void Forget(this UniTask task, Action<Exception> exceptionHandler, bool handleExceptionOnMainThread = true)
	{
		if (exceptionHandler == null)
		{
			task.Forget();
		}
		else
		{
			ForgetCoreWithCatch(task, exceptionHandler, handleExceptionOnMainThread).Forget();
		}
	}

	private static async UniTaskVoid ForgetCoreWithCatch(UniTask task, Action<Exception> exceptionHandler, bool handleExceptionOnMainThread)
	{
		try
		{
			await task;
		}
		catch (Exception obj)
		{
			try
			{
				if (handleExceptionOnMainThread)
				{
					await UniTask.SwitchToMainThread();
				}
				exceptionHandler(obj);
			}
			catch (Exception ex)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex);
			}
		}
	}

	public static void Forget<T>(this UniTask<T> task)
	{
		UniTask<T>.Awaiter awaiter = task.GetAwaiter();
		if (awaiter.IsCompleted)
		{
			try
			{
				awaiter.GetResult();
				return;
			}
			catch (Exception ex)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex);
				return;
			}
		}
		awaiter.SourceOnCompleted(delegate(object state)
		{
			using StateTuple<UniTask<T>.Awaiter> stateTuple = (StateTuple<UniTask<T>.Awaiter>)state;
			try
			{
				stateTuple.Item1.GetResult();
			}
			catch (Exception ex2)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex2);
			}
		}, StateTuple.Create(awaiter));
	}

	public static void Forget<T>(this UniTask<T> task, Action<Exception> exceptionHandler, bool handleExceptionOnMainThread = true)
	{
		if (exceptionHandler == null)
		{
			task.Forget();
		}
		else
		{
			ForgetCoreWithCatch(task, exceptionHandler, handleExceptionOnMainThread).Forget();
		}
	}

	private static async UniTaskVoid ForgetCoreWithCatch<T>(UniTask<T> task, Action<Exception> exceptionHandler, bool handleExceptionOnMainThread)
	{
		try
		{
			await task;
		}
		catch (Exception obj)
		{
			try
			{
				if (handleExceptionOnMainThread)
				{
					await UniTask.SwitchToMainThread();
				}
				exceptionHandler(obj);
			}
			catch (Exception ex)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex);
			}
		}
	}

	public static async UniTask ContinueWith<T>(this UniTask<T> task, Action<T> continuationFunction)
	{
		continuationFunction(await task);
	}

	public static async UniTask ContinueWith<T>(this UniTask<T> task, Func<T, UniTask> continuationFunction)
	{
		await continuationFunction(await task);
	}

	public static async UniTask<TR> ContinueWith<T, TR>(this UniTask<T> task, Func<T, TR> continuationFunction)
	{
		return continuationFunction(await task);
	}

	public static async UniTask<TR> ContinueWith<T, TR>(this UniTask<T> task, Func<T, UniTask<TR>> continuationFunction)
	{
		return await continuationFunction(await task);
	}

	public static async UniTask ContinueWith(this UniTask task, Action continuationFunction)
	{
		await task;
		continuationFunction();
	}

	public static async UniTask ContinueWith(this UniTask task, Func<UniTask> continuationFunction)
	{
		await task;
		await continuationFunction();
	}

	public static async UniTask<T> ContinueWith<T>(this UniTask task, Func<T> continuationFunction)
	{
		await task;
		return continuationFunction();
	}

	public static async UniTask<T> ContinueWith<T>(this UniTask task, Func<UniTask<T>> continuationFunction)
	{
		await task;
		return await continuationFunction();
	}

	public static async UniTask<T> Unwrap<T>(this UniTask<UniTask<T>> task)
	{
		return await (await task);
	}

	public static async UniTask Unwrap(this UniTask<UniTask> task)
	{
		await (await task);
	}

	public static async UniTask<T> Unwrap<T>(this Task<UniTask<T>> task)
	{
		return await (await task);
	}

	public static async UniTask<T> Unwrap<T>(this Task<UniTask<T>> task, bool continueOnCapturedContext)
	{
		return await (await task.ConfigureAwait(continueOnCapturedContext));
	}

	public static async UniTask Unwrap(this Task<UniTask> task)
	{
		await (await task);
	}

	public static async UniTask Unwrap(this Task<UniTask> task, bool continueOnCapturedContext)
	{
		await (await task.ConfigureAwait(continueOnCapturedContext));
	}

	public static async UniTask<T> Unwrap<T>(this UniTask<Task<T>> task)
	{
		return await (await task);
	}

	public static async UniTask<T> Unwrap<T>(this UniTask<Task<T>> task, bool continueOnCapturedContext)
	{
		return await (await task).ConfigureAwait(continueOnCapturedContext);
	}

	public static async UniTask Unwrap(this UniTask<Task> task)
	{
		await (await task);
	}

	public static async UniTask Unwrap(this UniTask<Task> task, bool continueOnCapturedContext)
	{
		await (await task).ConfigureAwait(continueOnCapturedContext);
	}

	public static UniTask.Awaiter GetAwaiter(this UniTask[] tasks)
	{
		return UniTask.WhenAll(tasks).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this IEnumerable<UniTask> tasks)
	{
		return UniTask.WhenAll(tasks).GetAwaiter();
	}

	public static UniTask<T[]>.Awaiter GetAwaiter<T>(this UniTask<T>[] tasks)
	{
		return UniTask.WhenAll(tasks).GetAwaiter();
	}

	public static UniTask<T[]>.Awaiter GetAwaiter<T>(this IEnumerable<UniTask<T>> tasks)
	{
		return UniTask.WhenAll(tasks).GetAwaiter();
	}

	public static UniTask<(T1, T2)>.Awaiter GetAwaiter<T1, T2>(this (UniTask<T1> task1, UniTask<T2> task2) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3)>.Awaiter GetAwaiter<T1, T2, T3>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4)>.Awaiter GetAwaiter<T1, T2, T3, T4>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6, T7>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6, T7, T8>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6, T7, T8, T9>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4, tasks.Rest.Item5).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4, tasks.Rest.Item5, tasks.Rest.Item6).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4, tasks.Rest.Item5, tasks.Rest.Item6, tasks.Rest.Item7).GetAwaiter();
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)>.Awaiter GetAwaiter<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(this (UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14, UniTask<T15> task15) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4, tasks.Rest.Item5, tasks.Rest.Item6, tasks.Rest.Item7, tasks.Rest.Rest.Item1).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6, UniTask task7) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6, UniTask task7, UniTask task8) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6, UniTask task7, UniTask task8, UniTask task9) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6, UniTask task7, UniTask task8, UniTask task9, UniTask task10) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6, UniTask task7, UniTask task8, UniTask task9, UniTask task10, UniTask task11) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6, UniTask task7, UniTask task8, UniTask task9, UniTask task10, UniTask task11, UniTask task12) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4, tasks.Rest.Item5).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6, UniTask task7, UniTask task8, UniTask task9, UniTask task10, UniTask task11, UniTask task12, UniTask task13) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4, tasks.Rest.Item5, tasks.Rest.Item6).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6, UniTask task7, UniTask task8, UniTask task9, UniTask task10, UniTask task11, UniTask task12, UniTask task13, UniTask task14) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4, tasks.Rest.Item5, tasks.Rest.Item6, tasks.Rest.Item7).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this (UniTask task1, UniTask task2, UniTask task3, UniTask task4, UniTask task5, UniTask task6, UniTask task7, UniTask task8, UniTask task9, UniTask task10, UniTask task11, UniTask task12, UniTask task13, UniTask task14, UniTask task15) tasks)
	{
		return UniTask.WhenAll(tasks.task1, tasks.task2, tasks.task3, tasks.task4, tasks.task5, tasks.task6, tasks.task7, tasks.Rest.Item1, tasks.Rest.Item2, tasks.Rest.Item3, tasks.Rest.Item4, tasks.Rest.Item5, tasks.Rest.Item6, tasks.Rest.Item7, tasks.Rest.Rest.Item1).GetAwaiter();
	}
}
