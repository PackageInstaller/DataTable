using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.ExceptionServices;
using System.Runtime.InteropServices;
using System.Threading;
using Cysharp.Threading.Tasks.CompilerServices;
using Cysharp.Threading.Tasks.Internal;
using UnityEngine;
using UnityEngine.Events;

namespace Cysharp.Threading.Tasks;

[StructLayout(LayoutKind.Auto)]
[AsyncMethodBuilder(typeof(AsyncUniTaskMethodBuilder))]
public readonly struct UniTask
{
	private sealed class AsyncUnitSource : IUniTaskSource<AsyncUnit>, IUniTaskSource
	{
		private readonly IUniTaskSource source;

		public AsyncUnitSource(IUniTaskSource source)
		{
			this.source = source;
		}

		public AsyncUnit GetResult(short token)
		{
			source.GetResult(token);
			return AsyncUnit.Default;
		}

		public UniTaskStatus GetStatus(short token)
		{
			return source.GetStatus(token);
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			source.OnCompleted(continuation, state, token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return source.UnsafeGetStatus();
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class IsCanceledSource : IUniTaskSource<bool>, IUniTaskSource
	{
		private readonly IUniTaskSource source;

		public IsCanceledSource(IUniTaskSource source)
		{
			this.source = source;
		}

		public bool GetResult(short token)
		{
			if (source.GetStatus(token) == UniTaskStatus.Canceled)
			{
				return true;
			}
			source.GetResult(token);
			return false;
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return source.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return source.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			source.OnCompleted(continuation, state, token);
		}
	}

	private sealed class MemoizeSource : IUniTaskSource
	{
		private IUniTaskSource source;

		private ExceptionDispatchInfo exception;

		private UniTaskStatus status;

		public MemoizeSource(IUniTaskSource source)
		{
			this.source = source;
		}

		public void GetResult(short token)
		{
			if (source == null)
			{
				if (exception != null)
				{
					exception.Throw();
				}
				return;
			}
			try
			{
				source.GetResult(token);
				status = UniTaskStatus.Succeeded;
			}
			catch (Exception ex)
			{
				exception = ExceptionDispatchInfo.Capture(ex);
				if (ex is OperationCanceledException)
				{
					status = UniTaskStatus.Canceled;
				}
				else
				{
					status = UniTaskStatus.Faulted;
				}
				throw;
			}
			finally
			{
				source = null;
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			if (source == null)
			{
				return status;
			}
			return source.GetStatus(token);
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			if (source == null)
			{
				continuation(state);
			}
			else
			{
				source.OnCompleted(continuation, state, token);
			}
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			if (source == null)
			{
				return status;
			}
			return source.UnsafeGetStatus();
		}
	}

	public readonly struct Awaiter(in UniTask task) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private readonly UniTask task = task;

		public bool IsCompleted
		{
			[MethodImpl((MethodImplOptions)256)]
			[DebuggerHidden]
			get
			{
				return task.Status.IsCompleted();
			}
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public void GetResult()
		{
			if (task.source != null)
			{
				task.source.GetResult(task.token);
			}
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public void OnCompleted(Action continuation)
		{
			if (task.source == null)
			{
				continuation();
			}
			else
			{
				task.source.OnCompleted(AwaiterActions.InvokeContinuationDelegate, continuation, task.token);
			}
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public void UnsafeOnCompleted(Action continuation)
		{
			if (task.source == null)
			{
				continuation();
			}
			else
			{
				task.source.OnCompleted(AwaiterActions.InvokeContinuationDelegate, continuation, task.token);
			}
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public void SourceOnCompleted(Action<object> continuation, object state)
		{
			if (task.source == null)
			{
				continuation(state);
			}
			else
			{
				task.source.OnCompleted(continuation, state, task.token);
			}
		}
	}

	private sealed class YieldPromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<YieldPromise>
	{
		private static TaskPool<YieldPromise> pool;

		private YieldPromise nextNode;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<object> core;

		public ref YieldPromise NextNode => ref nextNode;

		static YieldPromise()
		{
			TaskPool.RegisterSizeGetter(typeof(YieldPromise), () => pool.Size);
		}

		private YieldPromise()
		{
		}

		public static IUniTaskSource Create(PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new YieldPromise();
			}
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					YieldPromise yieldPromise = (YieldPromise)state;
					yieldPromise.core.TrySetCanceled(yieldPromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			core.TrySetResult(null);
			return false;
		}

		private bool TryReturn()
		{
			core.Reset();
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class NextFramePromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<NextFramePromise>
	{
		private static TaskPool<NextFramePromise> pool;

		private NextFramePromise nextNode;

		private int frameCount;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		public ref NextFramePromise NextNode => ref nextNode;

		static NextFramePromise()
		{
			TaskPool.RegisterSizeGetter(typeof(NextFramePromise), () => pool.Size);
		}

		private NextFramePromise()
		{
		}

		public static IUniTaskSource Create(PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new NextFramePromise();
			}
			result.frameCount = (PlayerLoopHelper.IsMainThread ? Time.frameCount : (-1));
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					NextFramePromise nextFramePromise = (NextFramePromise)state;
					nextFramePromise.core.TrySetCanceled(nextFramePromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (frameCount == Time.frameCount)
			{
				return true;
			}
			core.TrySetResult(AsyncUnit.Default);
			return false;
		}

		private bool TryReturn()
		{
			core.Reset();
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class WaitForEndOfFramePromise : IUniTaskSource, ITaskPoolNode<WaitForEndOfFramePromise>, IEnumerator
	{
		private static TaskPool<WaitForEndOfFramePromise> pool;

		private WaitForEndOfFramePromise nextNode;

		private UniTaskCompletionSourceCore<object> core;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private static readonly WaitForEndOfFrame waitForEndOfFrameYieldInstruction;

		private bool isFirst = true;

		public ref WaitForEndOfFramePromise NextNode => ref nextNode;

		object IEnumerator.Current => waitForEndOfFrameYieldInstruction;

		static WaitForEndOfFramePromise()
		{
			waitForEndOfFrameYieldInstruction = new WaitForEndOfFrame();
			TaskPool.RegisterSizeGetter(typeof(WaitForEndOfFramePromise), () => pool.Size);
		}

		private WaitForEndOfFramePromise()
		{
		}

		public static IUniTaskSource Create(MonoBehaviour coroutineRunner, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new WaitForEndOfFramePromise();
			}
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					WaitForEndOfFramePromise waitForEndOfFramePromise = (WaitForEndOfFramePromise)state;
					waitForEndOfFramePromise.core.TrySetCanceled(waitForEndOfFramePromise.cancellationToken);
				}, result);
			}
			coroutineRunner.StartCoroutine(result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		private bool TryReturn()
		{
			core.Reset();
			Reset();
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}

		bool IEnumerator.MoveNext()
		{
			if (isFirst)
			{
				isFirst = false;
				return true;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			core.TrySetResult(null);
			return false;
		}

		public void Reset()
		{
			isFirst = true;
		}
	}

	private sealed class DelayFramePromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<DelayFramePromise>
	{
		private static TaskPool<DelayFramePromise> pool;

		private DelayFramePromise nextNode;

		private int initialFrame;

		private int delayFrameCount;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private int currentFrameCount;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		public ref DelayFramePromise NextNode => ref nextNode;

		static DelayFramePromise()
		{
			TaskPool.RegisterSizeGetter(typeof(DelayFramePromise), () => pool.Size);
		}

		private DelayFramePromise()
		{
		}

		public static IUniTaskSource Create(int delayFrameCount, PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new DelayFramePromise();
			}
			result.delayFrameCount = delayFrameCount;
			result.cancellationToken = cancellationToken;
			result.initialFrame = (PlayerLoopHelper.IsMainThread ? Time.frameCount : (-1));
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					DelayFramePromise delayFramePromise = (DelayFramePromise)state;
					delayFramePromise.core.TrySetCanceled(delayFramePromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (currentFrameCount == 0)
			{
				if (delayFrameCount == 0)
				{
					core.TrySetResult(AsyncUnit.Default);
					return false;
				}
				if (initialFrame == Time.frameCount)
				{
					return true;
				}
			}
			if (++currentFrameCount >= delayFrameCount)
			{
				core.TrySetResult(AsyncUnit.Default);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			currentFrameCount = 0;
			delayFrameCount = 0;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class DelayPromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<DelayPromise>
	{
		private static TaskPool<DelayPromise> pool;

		private DelayPromise nextNode;

		private int initialFrame;

		private float delayTimeSpan;

		private float elapsed;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<object> core;

		public ref DelayPromise NextNode => ref nextNode;

		static DelayPromise()
		{
			TaskPool.RegisterSizeGetter(typeof(DelayPromise), () => pool.Size);
		}

		private DelayPromise()
		{
		}

		public static IUniTaskSource Create(TimeSpan delayTimeSpan, PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new DelayPromise();
			}
			result.elapsed = 0f;
			result.delayTimeSpan = (float)delayTimeSpan.TotalSeconds;
			result.cancellationToken = cancellationToken;
			result.initialFrame = (PlayerLoopHelper.IsMainThread ? Time.frameCount : (-1));
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					DelayPromise delayPromise = (DelayPromise)state;
					delayPromise.core.TrySetCanceled(delayPromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (elapsed == 0f && initialFrame == Time.frameCount)
			{
				return true;
			}
			elapsed += Time.deltaTime;
			if (elapsed >= delayTimeSpan)
			{
				core.TrySetResult(null);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			delayTimeSpan = 0f;
			elapsed = 0f;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class DelayIgnoreTimeScalePromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<DelayIgnoreTimeScalePromise>
	{
		private static TaskPool<DelayIgnoreTimeScalePromise> pool;

		private DelayIgnoreTimeScalePromise nextNode;

		private float delayFrameTimeSpan;

		private float elapsed;

		private int initialFrame;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<object> core;

		public ref DelayIgnoreTimeScalePromise NextNode => ref nextNode;

		static DelayIgnoreTimeScalePromise()
		{
			TaskPool.RegisterSizeGetter(typeof(DelayIgnoreTimeScalePromise), () => pool.Size);
		}

		private DelayIgnoreTimeScalePromise()
		{
		}

		public static IUniTaskSource Create(TimeSpan delayFrameTimeSpan, PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new DelayIgnoreTimeScalePromise();
			}
			result.elapsed = 0f;
			result.delayFrameTimeSpan = (float)delayFrameTimeSpan.TotalSeconds;
			result.initialFrame = (PlayerLoopHelper.IsMainThread ? Time.frameCount : (-1));
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					DelayIgnoreTimeScalePromise delayIgnoreTimeScalePromise = (DelayIgnoreTimeScalePromise)state;
					delayIgnoreTimeScalePromise.core.TrySetCanceled(delayIgnoreTimeScalePromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (elapsed == 0f && initialFrame == Time.frameCount)
			{
				return true;
			}
			elapsed += Time.unscaledDeltaTime;
			if (elapsed >= delayFrameTimeSpan)
			{
				core.TrySetResult(null);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			delayFrameTimeSpan = 0f;
			elapsed = 0f;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class DelayRealtimePromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<DelayRealtimePromise>
	{
		private static TaskPool<DelayRealtimePromise> pool;

		private DelayRealtimePromise nextNode;

		private long delayTimeSpanTicks;

		private ValueStopwatch stopwatch;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		public ref DelayRealtimePromise NextNode => ref nextNode;

		static DelayRealtimePromise()
		{
			TaskPool.RegisterSizeGetter(typeof(DelayRealtimePromise), () => pool.Size);
		}

		private DelayRealtimePromise()
		{
		}

		public static IUniTaskSource Create(TimeSpan delayTimeSpan, PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new DelayRealtimePromise();
			}
			result.stopwatch = ValueStopwatch.StartNew();
			result.delayTimeSpanTicks = delayTimeSpan.Ticks;
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					DelayRealtimePromise delayRealtimePromise = (DelayRealtimePromise)state;
					delayRealtimePromise.core.TrySetCanceled(delayRealtimePromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (stopwatch.IsInvalid)
			{
				core.TrySetResult(AsyncUnit.Default);
				return false;
			}
			if (stopwatch.ElapsedTicks >= delayTimeSpanTicks)
			{
				core.TrySetResult(AsyncUnit.Default);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			stopwatch = default(ValueStopwatch);
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private static class CanceledUniTaskCache<T>
	{
		public static readonly UniTask<T> Task;

		static CanceledUniTaskCache()
		{
			Task = new UniTask<T>(new CanceledResultSource<T>(CancellationToken.None), 0);
		}
	}

	private sealed class ExceptionResultSource : IUniTaskSource
	{
		private readonly ExceptionDispatchInfo exception;

		private bool calledGet;

		public ExceptionResultSource(Exception exception)
		{
			this.exception = ExceptionDispatchInfo.Capture(exception);
		}

		public void GetResult(short token)
		{
			if (!calledGet)
			{
				calledGet = true;
				GC.SuppressFinalize(this);
			}
			exception.Throw();
		}

		public UniTaskStatus GetStatus(short token)
		{
			return UniTaskStatus.Faulted;
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return UniTaskStatus.Faulted;
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			continuation(state);
		}

		~ExceptionResultSource()
		{
			if (!calledGet)
			{
				UniTaskScheduler.PublishUnobservedTaskException(exception.SourceException);
			}
		}
	}

	private sealed class ExceptionResultSource<T> : IUniTaskSource<T>, IUniTaskSource
	{
		private readonly ExceptionDispatchInfo exception;

		private bool calledGet;

		public ExceptionResultSource(Exception exception)
		{
			this.exception = ExceptionDispatchInfo.Capture(exception);
		}

		public T GetResult(short token)
		{
			if (!calledGet)
			{
				calledGet = true;
				GC.SuppressFinalize(this);
			}
			exception.Throw();
			return default(T);
		}

		void IUniTaskSource.GetResult(short token)
		{
			if (!calledGet)
			{
				calledGet = true;
				GC.SuppressFinalize(this);
			}
			exception.Throw();
		}

		public UniTaskStatus GetStatus(short token)
		{
			return UniTaskStatus.Faulted;
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return UniTaskStatus.Faulted;
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			continuation(state);
		}

		~ExceptionResultSource()
		{
			if (!calledGet)
			{
				UniTaskScheduler.PublishUnobservedTaskException(exception.SourceException);
			}
		}
	}

	private sealed class CanceledResultSource : IUniTaskSource
	{
		private readonly CancellationToken cancellationToken;

		public CanceledResultSource(CancellationToken cancellationToken)
		{
			this.cancellationToken = cancellationToken;
		}

		public void GetResult(short token)
		{
			throw new OperationCanceledException(cancellationToken);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return UniTaskStatus.Canceled;
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return UniTaskStatus.Canceled;
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			continuation(state);
		}
	}

	private sealed class CanceledResultSource<T> : IUniTaskSource<T>, IUniTaskSource
	{
		private readonly CancellationToken cancellationToken;

		public CanceledResultSource(CancellationToken cancellationToken)
		{
			this.cancellationToken = cancellationToken;
		}

		public T GetResult(short token)
		{
			throw new OperationCanceledException(cancellationToken);
		}

		void IUniTaskSource.GetResult(short token)
		{
			throw new OperationCanceledException(cancellationToken);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return UniTaskStatus.Canceled;
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return UniTaskStatus.Canceled;
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			continuation(state);
		}
	}

	private sealed class DeferPromise : IUniTaskSource
	{
		private Func<UniTask> factory;

		private UniTask task;

		private Awaiter awaiter;

		public DeferPromise(Func<UniTask> factory)
		{
			this.factory = factory;
		}

		public void GetResult(short token)
		{
			awaiter.GetResult();
		}

		public UniTaskStatus GetStatus(short token)
		{
			Func<UniTask> func = Interlocked.Exchange(ref factory, null);
			if (func != null)
			{
				task = func();
				awaiter = task.GetAwaiter();
			}
			return task.Status;
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			awaiter.SourceOnCompleted(continuation, state);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return task.Status;
		}
	}

	private sealed class DeferPromise<T> : IUniTaskSource<T>, IUniTaskSource
	{
		private Func<UniTask<T>> factory;

		private UniTask<T> task;

		private UniTask<T>.Awaiter awaiter;

		public DeferPromise(Func<UniTask<T>> factory)
		{
			this.factory = factory;
		}

		public T GetResult(short token)
		{
			return awaiter.GetResult();
		}

		void IUniTaskSource.GetResult(short token)
		{
			awaiter.GetResult();
		}

		public UniTaskStatus GetStatus(short token)
		{
			Func<UniTask<T>> func = Interlocked.Exchange(ref factory, null);
			if (func != null)
			{
				task = func();
				awaiter = task.GetAwaiter();
			}
			return task.Status;
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			awaiter.SourceOnCompleted(continuation, state);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return task.Status;
		}
	}

	private sealed class NeverPromise<T> : IUniTaskSource<T>, IUniTaskSource
	{
		private static readonly Action<object> cancellationCallback = CancellationCallback;

		private CancellationToken cancellationToken;

		private UniTaskCompletionSourceCore<T> core;

		public NeverPromise(CancellationToken cancellationToken)
		{
			this.cancellationToken = cancellationToken;
			if (this.cancellationToken.CanBeCanceled)
			{
				this.cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationCallback, this);
			}
		}

		private static void CancellationCallback(object state)
		{
			NeverPromise<T> neverPromise = (NeverPromise<T>)state;
			neverPromise.core.TrySetCanceled(neverPromise.cancellationToken);
		}

		public T GetResult(short token)
		{
			return core.GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			core.GetResult(token);
		}
	}

	private sealed class WaitUntilPromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<WaitUntilPromise>
	{
		private static TaskPool<WaitUntilPromise> pool;

		private WaitUntilPromise nextNode;

		private Func<bool> predicate;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<object> core;

		public ref WaitUntilPromise NextNode => ref nextNode;

		static WaitUntilPromise()
		{
			TaskPool.RegisterSizeGetter(typeof(WaitUntilPromise), () => pool.Size);
		}

		private WaitUntilPromise()
		{
		}

		public static IUniTaskSource Create(Func<bool> predicate, PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new WaitUntilPromise();
			}
			result.predicate = predicate;
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					WaitUntilPromise waitUntilPromise = (WaitUntilPromise)state;
					waitUntilPromise.core.TrySetCanceled(waitUntilPromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			try
			{
				if (!predicate())
				{
					return true;
				}
			}
			catch (Exception error)
			{
				core.TrySetException(error);
				return false;
			}
			core.TrySetResult(null);
			return false;
		}

		private bool TryReturn()
		{
			core.Reset();
			predicate = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class WaitWhilePromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<WaitWhilePromise>
	{
		private static TaskPool<WaitWhilePromise> pool;

		private WaitWhilePromise nextNode;

		private Func<bool> predicate;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<object> core;

		public ref WaitWhilePromise NextNode => ref nextNode;

		static WaitWhilePromise()
		{
			TaskPool.RegisterSizeGetter(typeof(WaitWhilePromise), () => pool.Size);
		}

		private WaitWhilePromise()
		{
		}

		public static IUniTaskSource Create(Func<bool> predicate, PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new WaitWhilePromise();
			}
			result.predicate = predicate;
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					WaitWhilePromise waitWhilePromise = (WaitWhilePromise)state;
					waitWhilePromise.core.TrySetCanceled(waitWhilePromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			try
			{
				if (predicate())
				{
					return true;
				}
			}
			catch (Exception error)
			{
				core.TrySetException(error);
				return false;
			}
			core.TrySetResult(null);
			return false;
		}

		private bool TryReturn()
		{
			core.Reset();
			predicate = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class WaitUntilCanceledPromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<WaitUntilCanceledPromise>
	{
		private static TaskPool<WaitUntilCanceledPromise> pool;

		private WaitUntilCanceledPromise nextNode;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<object> core;

		public ref WaitUntilCanceledPromise NextNode => ref nextNode;

		static WaitUntilCanceledPromise()
		{
			TaskPool.RegisterSizeGetter(typeof(WaitUntilCanceledPromise), () => pool.Size);
		}

		private WaitUntilCanceledPromise()
		{
		}

		public static IUniTaskSource Create(CancellationToken cancellationToken, PlayerLoopTiming timing, bool completeImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new WaitUntilCanceledPromise();
			}
			result.cancellationToken = cancellationToken;
			if (completeImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					((WaitUntilCanceledPromise)state).core.TrySetResult(null);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetResult(null);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class WaitUntilValueChangedUnityObjectPromise<T, U> : IUniTaskSource<U>, IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<WaitUntilValueChangedUnityObjectPromise<T, U>>
	{
		private static TaskPool<WaitUntilValueChangedUnityObjectPromise<T, U>> pool;

		private WaitUntilValueChangedUnityObjectPromise<T, U> nextNode;

		private T target;

		private UnityEngine.Object targetAsUnityObject;

		private U currentValue;

		private Func<T, U> monitorFunction;

		private IEqualityComparer<U> equalityComparer;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<U> core;

		public ref WaitUntilValueChangedUnityObjectPromise<T, U> NextNode => ref nextNode;

		static WaitUntilValueChangedUnityObjectPromise()
		{
			TaskPool.RegisterSizeGetter(typeof(WaitUntilValueChangedUnityObjectPromise<T, U>), () => pool.Size);
		}

		private WaitUntilValueChangedUnityObjectPromise()
		{
		}

		public static IUniTaskSource<U> Create(T target, Func<T, U> monitorFunction, IEqualityComparer<U> equalityComparer, PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource<U>.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new WaitUntilValueChangedUnityObjectPromise<T, U>();
			}
			result.target = target;
			result.targetAsUnityObject = target as UnityEngine.Object;
			result.monitorFunction = monitorFunction;
			result.currentValue = monitorFunction(target);
			result.equalityComparer = equalityComparer ?? UnityEqualityComparer.GetDefault<U>();
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					WaitUntilValueChangedUnityObjectPromise<T, U> waitUntilValueChangedUnityObjectPromise = (WaitUntilValueChangedUnityObjectPromise<T, U>)state;
					waitUntilValueChangedUnityObjectPromise.core.TrySetCanceled(waitUntilValueChangedUnityObjectPromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public U GetResult(short token)
		{
			try
			{
				return core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested || targetAsUnityObject == null)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			U val = default(U);
			try
			{
				val = monitorFunction(target);
				if (equalityComparer.Equals(currentValue, val))
				{
					return true;
				}
			}
			catch (Exception error)
			{
				core.TrySetException(error);
				return false;
			}
			core.TrySetResult(val);
			return false;
		}

		private bool TryReturn()
		{
			core.Reset();
			target = default(T);
			currentValue = default(U);
			monitorFunction = null;
			equalityComparer = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class WaitUntilValueChangedStandardObjectPromise<T, U> : IUniTaskSource<U>, IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<WaitUntilValueChangedStandardObjectPromise<T, U>> where T : class
	{
		private static TaskPool<WaitUntilValueChangedStandardObjectPromise<T, U>> pool;

		private WaitUntilValueChangedStandardObjectPromise<T, U> nextNode;

		private WeakReference<T> target;

		private U currentValue;

		private Func<T, U> monitorFunction;

		private IEqualityComparer<U> equalityComparer;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<U> core;

		public ref WaitUntilValueChangedStandardObjectPromise<T, U> NextNode => ref nextNode;

		static WaitUntilValueChangedStandardObjectPromise()
		{
			TaskPool.RegisterSizeGetter(typeof(WaitUntilValueChangedStandardObjectPromise<T, U>), () => pool.Size);
		}

		private WaitUntilValueChangedStandardObjectPromise()
		{
		}

		public static IUniTaskSource<U> Create(T target, Func<T, U> monitorFunction, IEqualityComparer<U> equalityComparer, PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource<U>.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new WaitUntilValueChangedStandardObjectPromise<T, U>();
			}
			result.target = new WeakReference<T>(target, trackResurrection: false);
			result.monitorFunction = monitorFunction;
			result.currentValue = monitorFunction(target);
			result.equalityComparer = equalityComparer ?? UnityEqualityComparer.GetDefault<U>();
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					WaitUntilValueChangedStandardObjectPromise<T, U> waitUntilValueChangedStandardObjectPromise = (WaitUntilValueChangedStandardObjectPromise<T, U>)state;
					waitUntilValueChangedStandardObjectPromise.core.TrySetCanceled(waitUntilValueChangedStandardObjectPromise.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public U GetResult(short token)
		{
			try
			{
				return core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public bool MoveNext()
		{
			if (cancellationToken.IsCancellationRequested || !target.TryGetTarget(out var arg))
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			U val = default(U);
			try
			{
				val = monitorFunction(arg);
				if (equalityComparer.Equals(currentValue, val))
				{
					return true;
				}
			}
			catch (Exception error)
			{
				core.TrySetException(error);
				return false;
			}
			core.TrySetResult(val);
			return false;
		}

		private bool TryReturn()
		{
			core.Reset();
			target = null;
			currentValue = default(U);
			monitorFunction = null;
			equalityComparer = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	private sealed class WhenAllPromise<T> : IUniTaskSource<T[]>, IUniTaskSource
	{
		private T[] result;

		private int completeCount;

		private UniTaskCompletionSourceCore<T[]> core;

		public WhenAllPromise(UniTask<T>[] tasks, int tasksLength)
		{
			completeCount = 0;
			if (tasksLength == 0)
			{
				result = Array.Empty<T>();
				core.TrySetResult(result);
				return;
			}
			result = new T[tasksLength];
			for (int i = 0; i < tasksLength; i++)
			{
				UniTask<T>.Awaiter awaiter;
				try
				{
					awaiter = tasks[i].GetAwaiter();
				}
				catch (Exception error)
				{
					core.TrySetException(error);
					continue;
				}
				if (awaiter.IsCompleted)
				{
					TryInvokeContinuation(this, in awaiter, i);
					continue;
				}
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T>, UniTask<T>.Awaiter, int> stateTuple = (StateTuple<WhenAllPromise<T>, UniTask<T>.Awaiter, int>)state;
					TryInvokeContinuation(stateTuple.Item1, in stateTuple.Item2, stateTuple.Item3);
				}, StateTuple.Create(this, awaiter, i));
			}
		}

		private static void TryInvokeContinuation(WhenAllPromise<T> self, in UniTask<T>.Awaiter awaiter, int i)
		{
			try
			{
				self.result[i] = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completeCount) == self.result.Length)
			{
				self.core.TrySetResult(self.result);
			}
		}

		public T[] GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise : IUniTaskSource
	{
		private int completeCount;

		private int tasksLength;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		public WhenAllPromise(UniTask[] tasks, int tasksLength)
		{
			this.tasksLength = tasksLength;
			completeCount = 0;
			if (tasksLength == 0)
			{
				core.TrySetResult(AsyncUnit.Default);
				return;
			}
			for (int i = 0; i < tasksLength; i++)
			{
				Awaiter awaiter;
				try
				{
					awaiter = tasks[i].GetAwaiter();
				}
				catch (Exception error)
				{
					core.TrySetException(error);
					continue;
				}
				if (awaiter.IsCompleted)
				{
					TryInvokeContinuation(this, in awaiter);
					continue;
				}
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise, Awaiter> stateTuple = (StateTuple<WhenAllPromise, Awaiter>)state;
					TryInvokeContinuation(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
		}

		private static void TryInvokeContinuation(WhenAllPromise self, in Awaiter awaiter)
		{
			try
			{
				awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completeCount) == self.tasksLength)
			{
				self.core.TrySetResult(AsyncUnit.Default);
			}
		}

		public void GetResult(short token)
		{
			GC.SuppressFinalize(this);
			core.GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2> : IUniTaskSource<(T1, T2)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
				return;
			}
			awaiter2.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2>, UniTask<T2>.Awaiter>)state;
				TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter2));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 2)
			{
				self.core.TrySetResult((self.t1, self.t2));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 2)
			{
				self.core.TrySetResult((self.t1, self.t2));
			}
		}

		public (T1, T2) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3> : IUniTaskSource<(T1, T2, T3)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
				return;
			}
			awaiter3.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3>, UniTask<T3>.Awaiter>)state;
				TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter3));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 3)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 3)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 3)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3));
			}
		}

		public (T1, T2, T3) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4> : IUniTaskSource<(T1, T2, T3, T4)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
				return;
			}
			awaiter4.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4>, UniTask<T4>.Awaiter>)state;
				TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter4));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 4)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 4)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 4)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 4)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4));
			}
		}

		public (T1, T2, T3, T4) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5> : IUniTaskSource<(T1, T2, T3, T4, T5)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
				return;
			}
			awaiter5.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5>, UniTask<T5>.Awaiter>)state;
				TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter5));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 5)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 5)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 5)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 5)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 5)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5));
			}
		}

		public (T1, T2, T3, T4, T5) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6> : IUniTaskSource<(T1, T2, T3, T4, T5, T6)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
				return;
			}
			awaiter6.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6>, UniTask<T6>.Awaiter>)state;
				TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter6));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 6)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 6)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 6)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 6)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 6)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 6)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6));
			}
		}

		public (T1, T2, T3, T4, T5, T6) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6, T7> : IUniTaskSource<(T1, T2, T3, T4, T5, T6, T7)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private T7 t7;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6, T7)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
				return;
			}
			awaiter7.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T7>.Awaiter>)state;
				TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter7));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 7)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 7)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 7)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 7)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 7)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 7)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7));
			}
		}

		private static void TryInvokeContinuationT7(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T7>.Awaiter awaiter)
		{
			try
			{
				self.t7 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 7)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7));
			}
		}

		public (T1, T2, T3, T4, T5, T6, T7) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8> : IUniTaskSource<(T1, T2, T3, T4, T5, T6, T7, T8)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private T7 t7;

		private T8 t8;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6, T7, T8)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
				return;
			}
			awaiter8.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T8>.Awaiter>)state;
				TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter8));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 8)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 8)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 8)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 8)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 8)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 8)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8));
			}
		}

		private static void TryInvokeContinuationT7(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T7>.Awaiter awaiter)
		{
			try
			{
				self.t7 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 8)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8));
			}
		}

		private static void TryInvokeContinuationT8(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T8>.Awaiter awaiter)
		{
			try
			{
				self.t8 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 8)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8));
			}
		}

		public (T1, T2, T3, T4, T5, T6, T7, T8) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> : IUniTaskSource<(T1, T2, T3, T4, T5, T6, T7, T8, T9)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private T7 t7;

		private T8 t8;

		private T9 t9;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6, T7, T8, T9)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
				return;
			}
			awaiter9.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T9>.Awaiter>)state;
				TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter9));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 9)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 9)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 9)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 9)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 9)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 9)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9));
			}
		}

		private static void TryInvokeContinuationT7(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T7>.Awaiter awaiter)
		{
			try
			{
				self.t7 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 9)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9));
			}
		}

		private static void TryInvokeContinuationT8(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T8>.Awaiter awaiter)
		{
			try
			{
				self.t8 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 9)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9));
			}
		}

		private static void TryInvokeContinuationT9(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T9>.Awaiter awaiter)
		{
			try
			{
				self.t9 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 9)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9));
			}
		}

		public (T1, T2, T3, T4, T5, T6, T7, T8, T9) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> : IUniTaskSource<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private T7 t7;

		private T8 t8;

		private T9 t9;

		private T10 t10;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
				return;
			}
			awaiter10.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T10>.Awaiter>)state;
				TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter10));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		private static void TryInvokeContinuationT7(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T7>.Awaiter awaiter)
		{
			try
			{
				self.t7 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		private static void TryInvokeContinuationT8(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T8>.Awaiter awaiter)
		{
			try
			{
				self.t8 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		private static void TryInvokeContinuationT9(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T9>.Awaiter awaiter)
		{
			try
			{
				self.t9 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		private static void TryInvokeContinuationT10(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T10>.Awaiter awaiter)
		{
			try
			{
				self.t10 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 10)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10));
			}
		}

		public (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> : IUniTaskSource<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private T7 t7;

		private T8 t8;

		private T9 t9;

		private T10 t10;

		private T11 t11;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
				return;
			}
			awaiter11.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T11>.Awaiter>)state;
				TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter11));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT7(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T7>.Awaiter awaiter)
		{
			try
			{
				self.t7 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT8(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T8>.Awaiter awaiter)
		{
			try
			{
				self.t8 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT9(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T9>.Awaiter awaiter)
		{
			try
			{
				self.t9 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT10(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T10>.Awaiter awaiter)
		{
			try
			{
				self.t10 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		private static void TryInvokeContinuationT11(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T11>.Awaiter awaiter)
		{
			try
			{
				self.t11 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 11)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11));
			}
		}

		public (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> : IUniTaskSource<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private T7 t7;

		private T8 t8;

		private T9 t9;

		private T10 t10;

		private T11 t11;

		private T12 t12;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
			}
			else
			{
				awaiter11.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T11>.Awaiter>)state;
					TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter11));
			}
			UniTask<T12>.Awaiter awaiter12 = task12.GetAwaiter();
			if (awaiter12.IsCompleted)
			{
				TryInvokeContinuationT12(this, in awaiter12);
				return;
			}
			awaiter12.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T12>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T12>.Awaiter>)state;
				TryInvokeContinuationT12(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter12));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT7(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T7>.Awaiter awaiter)
		{
			try
			{
				self.t7 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT8(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T8>.Awaiter awaiter)
		{
			try
			{
				self.t8 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT9(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T9>.Awaiter awaiter)
		{
			try
			{
				self.t9 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT10(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T10>.Awaiter awaiter)
		{
			try
			{
				self.t10 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT11(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T11>.Awaiter awaiter)
		{
			try
			{
				self.t11 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		private static void TryInvokeContinuationT12(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T12>.Awaiter awaiter)
		{
			try
			{
				self.t12 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 12)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12));
			}
		}

		public (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> : IUniTaskSource<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private T7 t7;

		private T8 t8;

		private T9 t9;

		private T10 t10;

		private T11 t11;

		private T12 t12;

		private T13 t13;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
			}
			else
			{
				awaiter11.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T11>.Awaiter>)state;
					TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter11));
			}
			UniTask<T12>.Awaiter awaiter12 = task12.GetAwaiter();
			if (awaiter12.IsCompleted)
			{
				TryInvokeContinuationT12(this, in awaiter12);
			}
			else
			{
				awaiter12.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T12>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T12>.Awaiter>)state;
					TryInvokeContinuationT12(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter12));
			}
			UniTask<T13>.Awaiter awaiter13 = task13.GetAwaiter();
			if (awaiter13.IsCompleted)
			{
				TryInvokeContinuationT13(this, in awaiter13);
				return;
			}
			awaiter13.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T13>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T13>.Awaiter>)state;
				TryInvokeContinuationT13(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter13));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT7(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T7>.Awaiter awaiter)
		{
			try
			{
				self.t7 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT8(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T8>.Awaiter awaiter)
		{
			try
			{
				self.t8 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT9(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T9>.Awaiter awaiter)
		{
			try
			{
				self.t9 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT10(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T10>.Awaiter awaiter)
		{
			try
			{
				self.t10 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT11(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T11>.Awaiter awaiter)
		{
			try
			{
				self.t11 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT12(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T12>.Awaiter awaiter)
		{
			try
			{
				self.t12 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		private static void TryInvokeContinuationT13(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T13>.Awaiter awaiter)
		{
			try
			{
				self.t13 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 13)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13));
			}
		}

		public (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> : IUniTaskSource<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private T7 t7;

		private T8 t8;

		private T9 t9;

		private T10 t10;

		private T11 t11;

		private T12 t12;

		private T13 t13;

		private T14 t14;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
			}
			else
			{
				awaiter11.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T11>.Awaiter>)state;
					TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter11));
			}
			UniTask<T12>.Awaiter awaiter12 = task12.GetAwaiter();
			if (awaiter12.IsCompleted)
			{
				TryInvokeContinuationT12(this, in awaiter12);
			}
			else
			{
				awaiter12.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T12>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T12>.Awaiter>)state;
					TryInvokeContinuationT12(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter12));
			}
			UniTask<T13>.Awaiter awaiter13 = task13.GetAwaiter();
			if (awaiter13.IsCompleted)
			{
				TryInvokeContinuationT13(this, in awaiter13);
			}
			else
			{
				awaiter13.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T13>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T13>.Awaiter>)state;
					TryInvokeContinuationT13(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter13));
			}
			UniTask<T14>.Awaiter awaiter14 = task14.GetAwaiter();
			if (awaiter14.IsCompleted)
			{
				TryInvokeContinuationT14(this, in awaiter14);
				return;
			}
			awaiter14.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T14>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T14>.Awaiter>)state;
				TryInvokeContinuationT14(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter14));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT7(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T7>.Awaiter awaiter)
		{
			try
			{
				self.t7 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT8(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T8>.Awaiter awaiter)
		{
			try
			{
				self.t8 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT9(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T9>.Awaiter awaiter)
		{
			try
			{
				self.t9 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT10(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T10>.Awaiter awaiter)
		{
			try
			{
				self.t10 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT11(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T11>.Awaiter awaiter)
		{
			try
			{
				self.t11 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT12(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T12>.Awaiter awaiter)
		{
			try
			{
				self.t12 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT13(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T13>.Awaiter awaiter)
		{
			try
			{
				self.t13 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		private static void TryInvokeContinuationT14(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T14>.Awaiter awaiter)
		{
			try
			{
				self.t14 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 14)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14));
			}
		}

		public (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> : IUniTaskSource<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)>, IUniTaskSource
	{
		private T1 t1;

		private T2 t2;

		private T3 t3;

		private T4 t4;

		private T5 t5;

		private T6 t6;

		private T7 t7;

		private T8 t8;

		private T9 t9;

		private T10 t10;

		private T11 t11;

		private T12 t12;

		private T13 t13;

		private T14 t14;

		private T15 t15;

		private int completedCount;

		private UniTaskCompletionSourceCore<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)> core;

		public WhenAllPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14, UniTask<T15> task15)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
			}
			else
			{
				awaiter11.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T11>.Awaiter>)state;
					TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter11));
			}
			UniTask<T12>.Awaiter awaiter12 = task12.GetAwaiter();
			if (awaiter12.IsCompleted)
			{
				TryInvokeContinuationT12(this, in awaiter12);
			}
			else
			{
				awaiter12.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T12>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T12>.Awaiter>)state;
					TryInvokeContinuationT12(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter12));
			}
			UniTask<T13>.Awaiter awaiter13 = task13.GetAwaiter();
			if (awaiter13.IsCompleted)
			{
				TryInvokeContinuationT13(this, in awaiter13);
			}
			else
			{
				awaiter13.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T13>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T13>.Awaiter>)state;
					TryInvokeContinuationT13(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter13));
			}
			UniTask<T14>.Awaiter awaiter14 = task14.GetAwaiter();
			if (awaiter14.IsCompleted)
			{
				TryInvokeContinuationT14(this, in awaiter14);
			}
			else
			{
				awaiter14.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T14>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T14>.Awaiter>)state;
					TryInvokeContinuationT14(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter14));
			}
			UniTask<T15>.Awaiter awaiter15 = task15.GetAwaiter();
			if (awaiter15.IsCompleted)
			{
				TryInvokeContinuationT15(this, in awaiter15);
				return;
			}
			awaiter15.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T15>.Awaiter> stateTuple = (StateTuple<WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T15>.Awaiter>)state;
				TryInvokeContinuationT15(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter15));
		}

		private static void TryInvokeContinuationT1(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T1>.Awaiter awaiter)
		{
			try
			{
				self.t1 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT2(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T2>.Awaiter awaiter)
		{
			try
			{
				self.t2 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT3(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T3>.Awaiter awaiter)
		{
			try
			{
				self.t3 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT4(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T4>.Awaiter awaiter)
		{
			try
			{
				self.t4 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT5(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T5>.Awaiter awaiter)
		{
			try
			{
				self.t5 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT6(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T6>.Awaiter awaiter)
		{
			try
			{
				self.t6 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT7(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T7>.Awaiter awaiter)
		{
			try
			{
				self.t7 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT8(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T8>.Awaiter awaiter)
		{
			try
			{
				self.t8 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT9(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T9>.Awaiter awaiter)
		{
			try
			{
				self.t9 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT10(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T10>.Awaiter awaiter)
		{
			try
			{
				self.t10 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT11(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T11>.Awaiter awaiter)
		{
			try
			{
				self.t11 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT12(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T12>.Awaiter awaiter)
		{
			try
			{
				self.t12 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT13(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T13>.Awaiter awaiter)
		{
			try
			{
				self.t13 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT14(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T14>.Awaiter awaiter)
		{
			try
			{
				self.t14 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		private static void TryInvokeContinuationT15(WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T15>.Awaiter awaiter)
		{
			try
			{
				self.t15 = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 15)
			{
				self.core.TrySetResult((self.t1, self.t2, self.t3, self.t4, self.t5, self.t6, self.t7, self.t8, self.t9, self.t10, self.t11, self.t12, self.t13, self.t14, self.t15));
			}
		}

		public (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15) GetResult(short token)
		{
			GC.SuppressFinalize(this);
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}
	}

	private sealed class WhenAnyLRPromise<T> : IUniTaskSource<(bool, T)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(bool, T)> core;

		public WhenAnyLRPromise(UniTask<T> leftTask, UniTask rightTask)
		{
			UniTask<T>.Awaiter awaiter;
			try
			{
				awaiter = leftTask.GetAwaiter();
			}
			catch (Exception error)
			{
				core.TrySetException(error);
				goto IL_0061;
			}
			if (awaiter.IsCompleted)
			{
				TryLeftInvokeContinuation(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyLRPromise<T>, UniTask<T>.Awaiter> stateTuple = (StateTuple<WhenAnyLRPromise<T>, UniTask<T>.Awaiter>)state;
					TryLeftInvokeContinuation(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			goto IL_0061;
			IL_0061:
			Awaiter awaiter2;
			try
			{
				awaiter2 = rightTask.GetAwaiter();
			}
			catch (Exception error2)
			{
				core.TrySetException(error2);
				return;
			}
			if (awaiter2.IsCompleted)
			{
				TryRightInvokeContinuation(this, in awaiter2);
				return;
			}
			awaiter2.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyLRPromise<T>, Awaiter> stateTuple = (StateTuple<WhenAnyLRPromise<T>, Awaiter>)state;
				TryRightInvokeContinuation(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter2));
		}

		private static void TryLeftInvokeContinuation(WhenAnyLRPromise<T> self, in UniTask<T>.Awaiter awaiter)
		{
			T result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((true, result));
			}
		}

		private static void TryRightInvokeContinuation(WhenAnyLRPromise<T> self, in Awaiter awaiter)
		{
			try
			{
				awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((false, default(T)));
			}
		}

		public (bool, T) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T> : IUniTaskSource<(int, T)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T)> core;

		public WhenAnyPromise(UniTask<T>[] tasks, int tasksLength)
		{
			if (tasksLength == 0)
			{
				throw new ArgumentException("The tasks argument contains no tasks.");
			}
			for (int i = 0; i < tasksLength; i++)
			{
				UniTask<T>.Awaiter awaiter;
				try
				{
					awaiter = tasks[i].GetAwaiter();
				}
				catch (Exception error)
				{
					core.TrySetException(error);
					continue;
				}
				if (awaiter.IsCompleted)
				{
					TryInvokeContinuation(this, in awaiter, i);
					continue;
				}
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T>, UniTask<T>.Awaiter, int> stateTuple = (StateTuple<WhenAnyPromise<T>, UniTask<T>.Awaiter, int>)state;
					TryInvokeContinuation(stateTuple.Item1, in stateTuple.Item2, stateTuple.Item3);
				}, StateTuple.Create(this, awaiter, i));
			}
		}

		private static void TryInvokeContinuation(WhenAnyPromise<T> self, in UniTask<T>.Awaiter awaiter, int i)
		{
			T result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((i, result));
			}
		}

		public (int, T) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise : IUniTaskSource<int>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<int> core;

		public WhenAnyPromise(UniTask[] tasks, int tasksLength)
		{
			if (tasksLength == 0)
			{
				throw new ArgumentException("The tasks argument contains no tasks.");
			}
			for (int i = 0; i < tasksLength; i++)
			{
				Awaiter awaiter;
				try
				{
					awaiter = tasks[i].GetAwaiter();
				}
				catch (Exception error)
				{
					core.TrySetException(error);
					continue;
				}
				if (awaiter.IsCompleted)
				{
					TryInvokeContinuation(this, in awaiter, i);
					continue;
				}
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise, Awaiter, int> stateTuple = (StateTuple<WhenAnyPromise, Awaiter, int>)state;
					TryInvokeContinuation(stateTuple.Item1, in stateTuple.Item2, stateTuple.Item3);
				}, StateTuple.Create(this, awaiter, i));
			}
		}

		private static void TryInvokeContinuation(WhenAnyPromise self, in Awaiter awaiter, int i)
		{
			try
			{
				awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult(i);
			}
		}

		public int GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2> : IUniTaskSource<(int, T1 result1, T2 result2)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
				return;
			}
			awaiter2.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2>, UniTask<T2>.Awaiter>)state;
				TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter2));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result));
			}
		}

		public (int, T1 result1, T2 result2) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
				return;
			}
			awaiter3.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3>, UniTask<T3>.Awaiter>)state;
				TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter3));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
				return;
			}
			awaiter4.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4>, UniTask<T4>.Awaiter>)state;
				TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter4));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
				return;
			}
			awaiter5.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5>, UniTask<T5>.Awaiter>)state;
				TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter5));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
				return;
			}
			awaiter6.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6>, UniTask<T6>.Awaiter>)state;
				TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter6));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
				return;
			}
			awaiter7.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>, UniTask<T7>.Awaiter>)state;
				TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter7));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6), default(T7)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6), default(T7)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6), default(T7)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6), default(T7)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6), default(T7)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result, default(T7)));
			}
		}

		private static void TryInvokeContinuationT7(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7> self, in UniTask<T7>.Awaiter awaiter)
		{
			T7 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((6, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
				return;
			}
			awaiter8.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>, UniTask<T8>.Awaiter>)state;
				TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter8));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6), default(T7), default(T8)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6), default(T7), default(T8)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6), default(T7), default(T8)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6), default(T7), default(T8)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result, default(T7), default(T8)));
			}
		}

		private static void TryInvokeContinuationT7(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T7>.Awaiter awaiter)
		{
			T7 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((6, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), result, default(T8)));
			}
		}

		private static void TryInvokeContinuationT8(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8> self, in UniTask<T8>.Awaiter awaiter)
		{
			T8 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((7, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
				return;
			}
			awaiter9.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>, UniTask<T9>.Awaiter>)state;
				TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter9));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6), default(T7), default(T8), default(T9)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6), default(T7), default(T8), default(T9)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6), default(T7), default(T8), default(T9)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result, default(T7), default(T8), default(T9)));
			}
		}

		private static void TryInvokeContinuationT7(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T7>.Awaiter awaiter)
		{
			T7 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((6, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), result, default(T8), default(T9)));
			}
		}

		private static void TryInvokeContinuationT8(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T8>.Awaiter awaiter)
		{
			T8 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((7, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), result, default(T9)));
			}
		}

		private static void TryInvokeContinuationT9(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9> self, in UniTask<T9>.Awaiter awaiter)
		{
			T9 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((8, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
				return;
			}
			awaiter10.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>, UniTask<T10>.Awaiter>)state;
				TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter10));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6), default(T7), default(T8), default(T9), default(T10)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6), default(T7), default(T8), default(T9), default(T10)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result, default(T7), default(T8), default(T9), default(T10)));
			}
		}

		private static void TryInvokeContinuationT7(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T7>.Awaiter awaiter)
		{
			T7 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((6, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), result, default(T8), default(T9), default(T10)));
			}
		}

		private static void TryInvokeContinuationT8(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T8>.Awaiter awaiter)
		{
			T8 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((7, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), result, default(T9), default(T10)));
			}
		}

		private static void TryInvokeContinuationT9(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T9>.Awaiter awaiter)
		{
			T9 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((8, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), result, default(T10)));
			}
		}

		private static void TryInvokeContinuationT10(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> self, in UniTask<T10>.Awaiter awaiter)
		{
			T10 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((9, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
				return;
			}
			awaiter11.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>, UniTask<T11>.Awaiter>)state;
				TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter11));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6), default(T7), default(T8), default(T9), default(T10), default(T11)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result, default(T7), default(T8), default(T9), default(T10), default(T11)));
			}
		}

		private static void TryInvokeContinuationT7(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T7>.Awaiter awaiter)
		{
			T7 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((6, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), result, default(T8), default(T9), default(T10), default(T11)));
			}
		}

		private static void TryInvokeContinuationT8(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T8>.Awaiter awaiter)
		{
			T8 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((7, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), result, default(T9), default(T10), default(T11)));
			}
		}

		private static void TryInvokeContinuationT9(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T9>.Awaiter awaiter)
		{
			T9 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((8, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), result, default(T10), default(T11)));
			}
		}

		private static void TryInvokeContinuationT10(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T10>.Awaiter awaiter)
		{
			T10 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((9, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), result, default(T11)));
			}
		}

		private static void TryInvokeContinuationT11(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> self, in UniTask<T11>.Awaiter awaiter)
		{
			T11 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((10, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
			}
			else
			{
				awaiter11.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T11>.Awaiter>)state;
					TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter11));
			}
			UniTask<T12>.Awaiter awaiter12 = task12.GetAwaiter();
			if (awaiter12.IsCompleted)
			{
				TryInvokeContinuationT12(this, in awaiter12);
				return;
			}
			awaiter12.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T12>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>, UniTask<T12>.Awaiter>)state;
				TryInvokeContinuationT12(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter12));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result, default(T7), default(T8), default(T9), default(T10), default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT7(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T7>.Awaiter awaiter)
		{
			T7 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((6, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), result, default(T8), default(T9), default(T10), default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT8(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T8>.Awaiter awaiter)
		{
			T8 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((7, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), result, default(T9), default(T10), default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT9(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T9>.Awaiter awaiter)
		{
			T9 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((8, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), result, default(T10), default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT10(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T10>.Awaiter awaiter)
		{
			T10 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((9, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), result, default(T11), default(T12)));
			}
		}

		private static void TryInvokeContinuationT11(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T11>.Awaiter awaiter)
		{
			T11 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((10, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), result, default(T12)));
			}
		}

		private static void TryInvokeContinuationT12(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> self, in UniTask<T12>.Awaiter awaiter)
		{
			T12 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((11, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
			}
			else
			{
				awaiter11.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T11>.Awaiter>)state;
					TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter11));
			}
			UniTask<T12>.Awaiter awaiter12 = task12.GetAwaiter();
			if (awaiter12.IsCompleted)
			{
				TryInvokeContinuationT12(this, in awaiter12);
			}
			else
			{
				awaiter12.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T12>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T12>.Awaiter>)state;
					TryInvokeContinuationT12(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter12));
			}
			UniTask<T13>.Awaiter awaiter13 = task13.GetAwaiter();
			if (awaiter13.IsCompleted)
			{
				TryInvokeContinuationT13(this, in awaiter13);
				return;
			}
			awaiter13.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T13>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>, UniTask<T13>.Awaiter>)state;
				TryInvokeContinuationT13(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter13));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result, default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT7(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T7>.Awaiter awaiter)
		{
			T7 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((6, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), result, default(T8), default(T9), default(T10), default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT8(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T8>.Awaiter awaiter)
		{
			T8 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((7, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), result, default(T9), default(T10), default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT9(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T9>.Awaiter awaiter)
		{
			T9 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((8, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), result, default(T10), default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT10(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T10>.Awaiter awaiter)
		{
			T10 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((9, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), result, default(T11), default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT11(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T11>.Awaiter awaiter)
		{
			T11 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((10, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), result, default(T12), default(T13)));
			}
		}

		private static void TryInvokeContinuationT12(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T12>.Awaiter awaiter)
		{
			T12 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((11, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), result, default(T13)));
			}
		}

		private static void TryInvokeContinuationT13(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> self, in UniTask<T13>.Awaiter awaiter)
		{
			T13 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((12, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13, T14 result14)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13, T14 result14)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
			}
			else
			{
				awaiter11.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T11>.Awaiter>)state;
					TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter11));
			}
			UniTask<T12>.Awaiter awaiter12 = task12.GetAwaiter();
			if (awaiter12.IsCompleted)
			{
				TryInvokeContinuationT12(this, in awaiter12);
			}
			else
			{
				awaiter12.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T12>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T12>.Awaiter>)state;
					TryInvokeContinuationT12(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter12));
			}
			UniTask<T13>.Awaiter awaiter13 = task13.GetAwaiter();
			if (awaiter13.IsCompleted)
			{
				TryInvokeContinuationT13(this, in awaiter13);
			}
			else
			{
				awaiter13.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T13>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T13>.Awaiter>)state;
					TryInvokeContinuationT13(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter13));
			}
			UniTask<T14>.Awaiter awaiter14 = task14.GetAwaiter();
			if (awaiter14.IsCompleted)
			{
				TryInvokeContinuationT14(this, in awaiter14);
				return;
			}
			awaiter14.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T14>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>, UniTask<T14>.Awaiter>)state;
				TryInvokeContinuationT14(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter14));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result, default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT7(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T7>.Awaiter awaiter)
		{
			T7 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((6, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), result, default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT8(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T8>.Awaiter awaiter)
		{
			T8 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((7, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), result, default(T9), default(T10), default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT9(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T9>.Awaiter awaiter)
		{
			T9 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((8, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), result, default(T10), default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT10(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T10>.Awaiter awaiter)
		{
			T10 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((9, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), result, default(T11), default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT11(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T11>.Awaiter awaiter)
		{
			T11 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((10, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), result, default(T12), default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT12(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T12>.Awaiter awaiter)
		{
			T12 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((11, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), result, default(T13), default(T14)));
			}
		}

		private static void TryInvokeContinuationT13(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T13>.Awaiter awaiter)
		{
			T13 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((12, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), result, default(T14)));
			}
		}

		private static void TryInvokeContinuationT14(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> self, in UniTask<T14>.Awaiter awaiter)
		{
			T14 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((13, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13, T14 result14) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private sealed class WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> : IUniTaskSource<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13, T14 result14, T15 result15)>, IUniTaskSource
	{
		private int completedCount;

		private UniTaskCompletionSourceCore<(int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13, T14 result14, T15 result15)> core;

		public WhenAnyPromise(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14, UniTask<T15> task15)
		{
			completedCount = 0;
			UniTask<T1>.Awaiter awaiter = task1.GetAwaiter();
			if (awaiter.IsCompleted)
			{
				TryInvokeContinuationT1(this, in awaiter);
			}
			else
			{
				awaiter.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T1>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T1>.Awaiter>)state;
					TryInvokeContinuationT1(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter));
			}
			UniTask<T2>.Awaiter awaiter2 = task2.GetAwaiter();
			if (awaiter2.IsCompleted)
			{
				TryInvokeContinuationT2(this, in awaiter2);
			}
			else
			{
				awaiter2.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T2>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T2>.Awaiter>)state;
					TryInvokeContinuationT2(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter2));
			}
			UniTask<T3>.Awaiter awaiter3 = task3.GetAwaiter();
			if (awaiter3.IsCompleted)
			{
				TryInvokeContinuationT3(this, in awaiter3);
			}
			else
			{
				awaiter3.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T3>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T3>.Awaiter>)state;
					TryInvokeContinuationT3(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter3));
			}
			UniTask<T4>.Awaiter awaiter4 = task4.GetAwaiter();
			if (awaiter4.IsCompleted)
			{
				TryInvokeContinuationT4(this, in awaiter4);
			}
			else
			{
				awaiter4.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T4>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T4>.Awaiter>)state;
					TryInvokeContinuationT4(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter4));
			}
			UniTask<T5>.Awaiter awaiter5 = task5.GetAwaiter();
			if (awaiter5.IsCompleted)
			{
				TryInvokeContinuationT5(this, in awaiter5);
			}
			else
			{
				awaiter5.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T5>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T5>.Awaiter>)state;
					TryInvokeContinuationT5(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter5));
			}
			UniTask<T6>.Awaiter awaiter6 = task6.GetAwaiter();
			if (awaiter6.IsCompleted)
			{
				TryInvokeContinuationT6(this, in awaiter6);
			}
			else
			{
				awaiter6.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T6>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T6>.Awaiter>)state;
					TryInvokeContinuationT6(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter6));
			}
			UniTask<T7>.Awaiter awaiter7 = task7.GetAwaiter();
			if (awaiter7.IsCompleted)
			{
				TryInvokeContinuationT7(this, in awaiter7);
			}
			else
			{
				awaiter7.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T7>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T7>.Awaiter>)state;
					TryInvokeContinuationT7(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter7));
			}
			UniTask<T8>.Awaiter awaiter8 = task8.GetAwaiter();
			if (awaiter8.IsCompleted)
			{
				TryInvokeContinuationT8(this, in awaiter8);
			}
			else
			{
				awaiter8.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T8>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T8>.Awaiter>)state;
					TryInvokeContinuationT8(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter8));
			}
			UniTask<T9>.Awaiter awaiter9 = task9.GetAwaiter();
			if (awaiter9.IsCompleted)
			{
				TryInvokeContinuationT9(this, in awaiter9);
			}
			else
			{
				awaiter9.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T9>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T9>.Awaiter>)state;
					TryInvokeContinuationT9(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter9));
			}
			UniTask<T10>.Awaiter awaiter10 = task10.GetAwaiter();
			if (awaiter10.IsCompleted)
			{
				TryInvokeContinuationT10(this, in awaiter10);
			}
			else
			{
				awaiter10.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T10>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T10>.Awaiter>)state;
					TryInvokeContinuationT10(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter10));
			}
			UniTask<T11>.Awaiter awaiter11 = task11.GetAwaiter();
			if (awaiter11.IsCompleted)
			{
				TryInvokeContinuationT11(this, in awaiter11);
			}
			else
			{
				awaiter11.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T11>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T11>.Awaiter>)state;
					TryInvokeContinuationT11(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter11));
			}
			UniTask<T12>.Awaiter awaiter12 = task12.GetAwaiter();
			if (awaiter12.IsCompleted)
			{
				TryInvokeContinuationT12(this, in awaiter12);
			}
			else
			{
				awaiter12.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T12>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T12>.Awaiter>)state;
					TryInvokeContinuationT12(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter12));
			}
			UniTask<T13>.Awaiter awaiter13 = task13.GetAwaiter();
			if (awaiter13.IsCompleted)
			{
				TryInvokeContinuationT13(this, in awaiter13);
			}
			else
			{
				awaiter13.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T13>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T13>.Awaiter>)state;
					TryInvokeContinuationT13(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter13));
			}
			UniTask<T14>.Awaiter awaiter14 = task14.GetAwaiter();
			if (awaiter14.IsCompleted)
			{
				TryInvokeContinuationT14(this, in awaiter14);
			}
			else
			{
				awaiter14.SourceOnCompleted(delegate(object state)
				{
					using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T14>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T14>.Awaiter>)state;
					TryInvokeContinuationT14(stateTuple.Item1, in stateTuple.Item2);
				}, StateTuple.Create(this, awaiter14));
			}
			UniTask<T15>.Awaiter awaiter15 = task15.GetAwaiter();
			if (awaiter15.IsCompleted)
			{
				TryInvokeContinuationT15(this, in awaiter15);
				return;
			}
			awaiter15.SourceOnCompleted(delegate(object state)
			{
				using StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T15>.Awaiter> stateTuple = (StateTuple<WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>, UniTask<T15>.Awaiter>)state;
				TryInvokeContinuationT15(stateTuple.Item1, in stateTuple.Item2);
			}, StateTuple.Create(this, awaiter15));
		}

		private static void TryInvokeContinuationT1(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T1>.Awaiter awaiter)
		{
			T1 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((0, result, default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT2(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T2>.Awaiter awaiter)
		{
			T2 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((1, default(T1), result, default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT3(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T3>.Awaiter awaiter)
		{
			T3 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((2, default(T1), default(T2), result, default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT4(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T4>.Awaiter awaiter)
		{
			T4 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((3, default(T1), default(T2), default(T3), result, default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT5(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T5>.Awaiter awaiter)
		{
			T5 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((4, default(T1), default(T2), default(T3), default(T4), result, default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT6(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T6>.Awaiter awaiter)
		{
			T6 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((5, default(T1), default(T2), default(T3), default(T4), default(T5), result, default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT7(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T7>.Awaiter awaiter)
		{
			T7 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((6, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), result, default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT8(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T8>.Awaiter awaiter)
		{
			T8 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((7, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), result, default(T9), default(T10), default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT9(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T9>.Awaiter awaiter)
		{
			T9 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((8, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), result, default(T10), default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT10(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T10>.Awaiter awaiter)
		{
			T10 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((9, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), result, default(T11), default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT11(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T11>.Awaiter awaiter)
		{
			T11 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((10, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), result, default(T12), default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT12(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T12>.Awaiter awaiter)
		{
			T12 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((11, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), result, default(T13), default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT13(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T13>.Awaiter awaiter)
		{
			T13 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((12, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), result, default(T14), default(T15)));
			}
		}

		private static void TryInvokeContinuationT14(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T14>.Awaiter awaiter)
		{
			T14 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((13, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), result, default(T15)));
			}
		}

		private static void TryInvokeContinuationT15(WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> self, in UniTask<T15>.Awaiter awaiter)
		{
			T15 result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception error)
			{
				self.core.TrySetException(error);
				return;
			}
			if (Interlocked.Increment(ref self.completedCount) == 1)
			{
				self.core.TrySetResult((14, default(T1), default(T2), default(T3), default(T4), default(T5), default(T6), default(T7), default(T8), default(T9), default(T10), default(T11), default(T12), default(T13), default(T14), result));
			}
		}

		public (int, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13, T14 result14, T15 result15) GetResult(short token)
		{
			GC.SuppressFinalize(this);
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

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}
	}

	private readonly IUniTaskSource source;

	private readonly short token;

	private static readonly UniTask CanceledUniTask = ((Func<UniTask>)(() => new UniTask(new CanceledResultSource(CancellationToken.None), 0)))();

	public static readonly UniTask CompletedTask = default(UniTask);

	public UniTaskStatus Status
	{
		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		get
		{
			if (source == null)
			{
				return UniTaskStatus.Succeeded;
			}
			return source.GetStatus(token);
		}
	}

	public static IEnumerator ToCoroutine(Func<UniTask> taskFactory)
	{
		return taskFactory().ToCoroutine();
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public UniTask(IUniTaskSource source, short token)
	{
		this.source = source;
		this.token = token;
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public Awaiter GetAwaiter()
	{
		return new Awaiter(this);
	}

	public UniTask<bool> SuppressCancellationThrow()
	{
		return Status switch
		{
			UniTaskStatus.Succeeded => CompletedTasks.False, 
			UniTaskStatus.Canceled => CompletedTasks.True, 
			_ => new UniTask<bool>(new IsCanceledSource(source), token), 
		};
	}

	public override string ToString()
	{
		if (source == null)
		{
			return "()";
		}
		return "(" + source.UnsafeGetStatus().ToString() + ")";
	}

	public UniTask Preserve()
	{
		if (source == null)
		{
			return this;
		}
		return new UniTask(new MemoizeSource(source), token);
	}

	public UniTask<AsyncUnit> AsAsyncUnitUniTask()
	{
		if (source == null)
		{
			return CompletedTasks.AsyncUnit;
		}
		if (source.GetStatus(token).IsCompletedSuccessfully())
		{
			source.GetResult(token);
			return CompletedTasks.AsyncUnit;
		}
		if (source is IUniTaskSource<AsyncUnit> uniTaskSource)
		{
			return new UniTask<AsyncUnit>(uniTaskSource, token);
		}
		return new UniTask<AsyncUnit>(new AsyncUnitSource(source), token);
	}

	public static YieldAwaitable Yield()
	{
		return new YieldAwaitable(PlayerLoopTiming.Update);
	}

	public static YieldAwaitable Yield(PlayerLoopTiming timing)
	{
		return new YieldAwaitable(timing);
	}

	public static UniTask Yield(CancellationToken cancellationToken, bool cancelImmediately = false)
	{
		short num;
		return new UniTask(YieldPromise.Create(PlayerLoopTiming.Update, cancellationToken, cancelImmediately, out num), num);
	}

	public static UniTask Yield(PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately = false)
	{
		short num;
		return new UniTask(YieldPromise.Create(timing, cancellationToken, cancelImmediately, out num), num);
	}

	public static UniTask NextFrame()
	{
		short num;
		return new UniTask(NextFramePromise.Create(PlayerLoopTiming.Update, CancellationToken.None, cancelImmediately: false, out num), num);
	}

	public static UniTask NextFrame(PlayerLoopTiming timing)
	{
		short num;
		return new UniTask(NextFramePromise.Create(timing, CancellationToken.None, cancelImmediately: false, out num), num);
	}

	public static UniTask NextFrame(CancellationToken cancellationToken, bool cancelImmediately = false)
	{
		short num;
		return new UniTask(NextFramePromise.Create(PlayerLoopTiming.Update, cancellationToken, cancelImmediately, out num), num);
	}

	public static UniTask NextFrame(PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately = false)
	{
		short num;
		return new UniTask(NextFramePromise.Create(timing, cancellationToken, cancelImmediately, out num), num);
	}

	[Obsolete("Use WaitForEndOfFrame(MonoBehaviour) instead or UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate). Equivalent for coroutine's WaitForEndOfFrame requires MonoBehaviour(runner of Coroutine).")]
	public static YieldAwaitable WaitForEndOfFrame()
	{
		return Yield(PlayerLoopTiming.LastPostLateUpdate);
	}

	[Obsolete("Use WaitForEndOfFrame(MonoBehaviour) instead or UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate). Equivalent for coroutine's WaitForEndOfFrame requires MonoBehaviour(runner of Coroutine).")]
	public static UniTask WaitForEndOfFrame(CancellationToken cancellationToken, bool cancelImmediately = false)
	{
		return Yield(PlayerLoopTiming.LastPostLateUpdate, cancellationToken, cancelImmediately);
	}

	public static UniTask WaitForEndOfFrame(MonoBehaviour coroutineRunner)
	{
		short num;
		return new UniTask(WaitForEndOfFramePromise.Create(coroutineRunner, CancellationToken.None, cancelImmediately: false, out num), num);
	}

	public static UniTask WaitForEndOfFrame(MonoBehaviour coroutineRunner, CancellationToken cancellationToken, bool cancelImmediately = false)
	{
		short num;
		return new UniTask(WaitForEndOfFramePromise.Create(coroutineRunner, cancellationToken, cancelImmediately, out num), num);
	}

	public static YieldAwaitable WaitForFixedUpdate()
	{
		return Yield(PlayerLoopTiming.LastFixedUpdate);
	}

	public static UniTask WaitForFixedUpdate(CancellationToken cancellationToken, bool cancelImmediately = false)
	{
		return Yield(PlayerLoopTiming.LastFixedUpdate, cancellationToken, cancelImmediately);
	}

	public static UniTask WaitForSeconds(float duration, bool ignoreTimeScale = false, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		return Delay(Mathf.RoundToInt(1000f * duration), ignoreTimeScale, delayTiming, cancellationToken, cancelImmediately);
	}

	public static UniTask WaitForSeconds(int duration, bool ignoreTimeScale = false, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		return Delay(1000 * duration, ignoreTimeScale, delayTiming, cancellationToken, cancelImmediately);
	}

	public static UniTask DelayFrame(int delayFrameCount, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		if (delayFrameCount < 0)
		{
			throw new ArgumentOutOfRangeException("Delay does not allow minus delayFrameCount. delayFrameCount:" + delayFrameCount);
		}
		short num;
		return new UniTask(DelayFramePromise.Create(delayFrameCount, delayTiming, cancellationToken, cancelImmediately, out num), num);
	}

	public static UniTask Delay(int millisecondsDelay, bool ignoreTimeScale = false, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		return Delay(TimeSpan.FromMilliseconds(millisecondsDelay), ignoreTimeScale, delayTiming, cancellationToken, cancelImmediately);
	}

	public static UniTask Delay(TimeSpan delayTimeSpan, bool ignoreTimeScale = false, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		DelayType delayType = (ignoreTimeScale ? DelayType.UnscaledDeltaTime : DelayType.DeltaTime);
		return Delay(delayTimeSpan, delayType, delayTiming, cancellationToken, cancelImmediately);
	}

	public static UniTask Delay(int millisecondsDelay, DelayType delayType, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		return Delay(TimeSpan.FromMilliseconds(millisecondsDelay), delayType, delayTiming, cancellationToken, cancelImmediately);
	}

	public static UniTask Delay(TimeSpan delayTimeSpan, DelayType delayType, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		if (delayTimeSpan < TimeSpan.Zero)
		{
			TimeSpan timeSpan = delayTimeSpan;
			throw new ArgumentOutOfRangeException("Delay does not allow minus delayTimeSpan. delayTimeSpan:" + timeSpan);
		}
		short num;
		short num2;
		short num3;
		return delayType switch
		{
			DelayType.UnscaledDeltaTime => new UniTask(DelayIgnoreTimeScalePromise.Create(delayTimeSpan, delayTiming, cancellationToken, cancelImmediately, out num), num), 
			DelayType.Realtime => new UniTask(DelayRealtimePromise.Create(delayTimeSpan, delayTiming, cancellationToken, cancelImmediately, out num2), num2), 
			_ => new UniTask(DelayPromise.Create(delayTimeSpan, delayTiming, cancellationToken, cancelImmediately, out num3), num3), 
		};
	}

	public static UniTask FromException(Exception ex)
	{
		if (ex is OperationCanceledException ex2)
		{
			return FromCanceled(ex2.CancellationToken);
		}
		return new UniTask(new ExceptionResultSource(ex), 0);
	}

	public static UniTask<T> FromException<T>(Exception ex)
	{
		if (ex is OperationCanceledException ex2)
		{
			return FromCanceled<T>(ex2.CancellationToken);
		}
		return new UniTask<T>(new ExceptionResultSource<T>(ex), 0);
	}

	public static UniTask<T> FromResult<T>(T value)
	{
		return new UniTask<T>(value);
	}

	public static UniTask FromCanceled(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (cancellationToken == CancellationToken.None)
		{
			return CanceledUniTask;
		}
		return new UniTask(new CanceledResultSource(cancellationToken), 0);
	}

	public static UniTask<T> FromCanceled<T>(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (cancellationToken == CancellationToken.None)
		{
			return CanceledUniTaskCache<T>.Task;
		}
		return new UniTask<T>(new CanceledResultSource<T>(cancellationToken), 0);
	}

	public static UniTask Create(Func<UniTask> factory)
	{
		return factory();
	}

	public static UniTask<T> Create<T>(Func<UniTask<T>> factory)
	{
		return factory();
	}

	public static AsyncLazy Lazy(Func<UniTask> factory)
	{
		return new AsyncLazy(factory);
	}

	public static AsyncLazy<T> Lazy<T>(Func<UniTask<T>> factory)
	{
		return new AsyncLazy<T>(factory);
	}

	public static void Void(Func<UniTaskVoid> asyncAction)
	{
		asyncAction().Forget();
	}

	public static void Void(Func<CancellationToken, UniTaskVoid> asyncAction, CancellationToken cancellationToken)
	{
		asyncAction(cancellationToken).Forget();
	}

	public static void Void<T>(Func<T, UniTaskVoid> asyncAction, T state)
	{
		asyncAction(state).Forget();
	}

	public static Action Action(Func<UniTaskVoid> asyncAction)
	{
		return delegate
		{
			asyncAction().Forget();
		};
	}

	public static Action Action(Func<CancellationToken, UniTaskVoid> asyncAction, CancellationToken cancellationToken)
	{
		return delegate
		{
			asyncAction(cancellationToken).Forget();
		};
	}

	public static UnityAction UnityAction(Func<UniTaskVoid> asyncAction)
	{
		return delegate
		{
			asyncAction().Forget();
		};
	}

	public static UnityAction UnityAction(Func<CancellationToken, UniTaskVoid> asyncAction, CancellationToken cancellationToken)
	{
		return delegate
		{
			asyncAction(cancellationToken).Forget();
		};
	}

	public static UniTask Defer(Func<UniTask> factory)
	{
		return new UniTask(new DeferPromise(factory), 0);
	}

	public static UniTask<T> Defer<T>(Func<UniTask<T>> factory)
	{
		return new UniTask<T>(new DeferPromise<T>(factory), 0);
	}

	public static UniTask Never(CancellationToken cancellationToken)
	{
		return new UniTask<AsyncUnit>(new NeverPromise<AsyncUnit>(cancellationToken), 0);
	}

	public static UniTask<T> Never<T>(CancellationToken cancellationToken)
	{
		return new UniTask<T>(new NeverPromise<T>(cancellationToken), 0);
	}

	[Obsolete("UniTask.Run is similar as Task.Run, it uses ThreadPool. For equivalent behaviour, use UniTask.RunOnThreadPool instead. If you don't want to use ThreadPool, you can use UniTask.Void(async void) or UniTask.Create(async UniTask) too.")]
	public static UniTask Run(Action action, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		return RunOnThreadPool(action, configureAwait, cancellationToken);
	}

	[Obsolete("UniTask.Run is similar as Task.Run, it uses ThreadPool. For equivalent behaviour, use UniTask.RunOnThreadPool instead. If you don't want to use ThreadPool, you can use UniTask.Void(async void) or UniTask.Create(async UniTask) too.")]
	public static UniTask Run(Action<object> action, object state, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		return RunOnThreadPool(action, state, configureAwait, cancellationToken);
	}

	[Obsolete("UniTask.Run is similar as Task.Run, it uses ThreadPool. For equivalent behaviour, use UniTask.RunOnThreadPool instead. If you don't want to use ThreadPool, you can use UniTask.Void(async void) or UniTask.Create(async UniTask) too.")]
	public static UniTask Run(Func<UniTask> action, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		return RunOnThreadPool(action, configureAwait, cancellationToken);
	}

	[Obsolete("UniTask.Run is similar as Task.Run, it uses ThreadPool. For equivalent behaviour, use UniTask.RunOnThreadPool instead. If you don't want to use ThreadPool, you can use UniTask.Void(async void) or UniTask.Create(async UniTask) too.")]
	public static UniTask Run(Func<object, UniTask> action, object state, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		return RunOnThreadPool(action, state, configureAwait, cancellationToken);
	}

	[Obsolete("UniTask.Run is similar as Task.Run, it uses ThreadPool. For equivalent behaviour, use UniTask.RunOnThreadPool instead. If you don't want to use ThreadPool, you can use UniTask.Void(async void) or UniTask.Create(async UniTask) too.")]
	public static UniTask<T> Run<T>(Func<T> func, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		return RunOnThreadPool(func, configureAwait, cancellationToken);
	}

	[Obsolete("UniTask.Run is similar as Task.Run, it uses ThreadPool. For equivalent behaviour, use UniTask.RunOnThreadPool instead. If you don't want to use ThreadPool, you can use UniTask.Void(async void) or UniTask.Create(async UniTask) too.")]
	public static UniTask<T> Run<T>(Func<UniTask<T>> func, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		return RunOnThreadPool(func, configureAwait, cancellationToken);
	}

	[Obsolete("UniTask.Run is similar as Task.Run, it uses ThreadPool. For equivalent behaviour, use UniTask.RunOnThreadPool instead. If you don't want to use ThreadPool, you can use UniTask.Void(async void) or UniTask.Create(async UniTask) too.")]
	public static UniTask<T> Run<T>(Func<object, T> func, object state, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		return RunOnThreadPool(func, state, configureAwait, cancellationToken);
	}

	[Obsolete("UniTask.Run is similar as Task.Run, it uses ThreadPool. For equivalent behaviour, use UniTask.RunOnThreadPool instead. If you don't want to use ThreadPool, you can use UniTask.Void(async void) or UniTask.Create(async UniTask) too.")]
	public static UniTask<T> Run<T>(Func<object, UniTask<T>> func, object state, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		return RunOnThreadPool(func, state, configureAwait, cancellationToken);
	}

	public static async UniTask RunOnThreadPool(Action action, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		cancellationToken.ThrowIfCancellationRequested();
		await SwitchToThreadPool();
		cancellationToken.ThrowIfCancellationRequested();
		if (configureAwait)
		{
			try
			{
				action();
			}
			finally
			{
				await Yield();
			}
		}
		else
		{
			action();
		}
		cancellationToken.ThrowIfCancellationRequested();
	}

	public static async UniTask RunOnThreadPool(Action<object> action, object state, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		cancellationToken.ThrowIfCancellationRequested();
		await SwitchToThreadPool();
		cancellationToken.ThrowIfCancellationRequested();
		if (configureAwait)
		{
			try
			{
				action(state);
			}
			finally
			{
				await Yield();
			}
		}
		else
		{
			action(state);
		}
		cancellationToken.ThrowIfCancellationRequested();
	}

	public static async UniTask RunOnThreadPool(Func<UniTask> action, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		cancellationToken.ThrowIfCancellationRequested();
		await SwitchToThreadPool();
		cancellationToken.ThrowIfCancellationRequested();
		if (!configureAwait)
		{
			await action();
		}
		else
		{
			try
			{
				await action();
			}
			finally
			{
				await Yield();
			}
		}
		cancellationToken.ThrowIfCancellationRequested();
	}

	public static async UniTask RunOnThreadPool(Func<object, UniTask> action, object state, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		cancellationToken.ThrowIfCancellationRequested();
		await SwitchToThreadPool();
		cancellationToken.ThrowIfCancellationRequested();
		if (!configureAwait)
		{
			await action(state);
		}
		else
		{
			try
			{
				await action(state);
			}
			finally
			{
				await Yield();
			}
		}
		cancellationToken.ThrowIfCancellationRequested();
	}

	public static async UniTask<T> RunOnThreadPool<T>(Func<T> func, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		cancellationToken.ThrowIfCancellationRequested();
		await SwitchToThreadPool();
		cancellationToken.ThrowIfCancellationRequested();
		if (configureAwait)
		{
			T result;
			try
			{
				result = func();
			}
			finally
			{
				await Yield();
				cancellationToken.ThrowIfCancellationRequested();
			}
			return result;
		}
		return func();
	}

	public static async UniTask<T> RunOnThreadPool<T>(Func<UniTask<T>> func, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		cancellationToken.ThrowIfCancellationRequested();
		await SwitchToThreadPool();
		cancellationToken.ThrowIfCancellationRequested();
		if (configureAwait)
		{
			T result;
			try
			{
				result = await func();
			}
			finally
			{
				cancellationToken.ThrowIfCancellationRequested();
				await Yield();
				cancellationToken.ThrowIfCancellationRequested();
			}
			return result;
		}
		T result2 = await func();
		cancellationToken.ThrowIfCancellationRequested();
		return result2;
	}

	public static async UniTask<T> RunOnThreadPool<T>(Func<object, T> func, object state, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		cancellationToken.ThrowIfCancellationRequested();
		await SwitchToThreadPool();
		cancellationToken.ThrowIfCancellationRequested();
		if (configureAwait)
		{
			T result;
			try
			{
				result = func(state);
			}
			finally
			{
				await Yield();
				cancellationToken.ThrowIfCancellationRequested();
			}
			return result;
		}
		return func(state);
	}

	public static async UniTask<T> RunOnThreadPool<T>(Func<object, UniTask<T>> func, object state, bool configureAwait = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		cancellationToken.ThrowIfCancellationRequested();
		await SwitchToThreadPool();
		cancellationToken.ThrowIfCancellationRequested();
		if (configureAwait)
		{
			T result;
			try
			{
				result = await func(state);
			}
			finally
			{
				cancellationToken.ThrowIfCancellationRequested();
				await Yield();
				cancellationToken.ThrowIfCancellationRequested();
			}
			return result;
		}
		T result2 = await func(state);
		cancellationToken.ThrowIfCancellationRequested();
		return result2;
	}

	public static SwitchToMainThreadAwaitable SwitchToMainThread(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new SwitchToMainThreadAwaitable(PlayerLoopTiming.Update, cancellationToken);
	}

	public static SwitchToMainThreadAwaitable SwitchToMainThread(PlayerLoopTiming timing, CancellationToken cancellationToken = default(CancellationToken))
	{
		return new SwitchToMainThreadAwaitable(timing, cancellationToken);
	}

	public static ReturnToMainThread ReturnToMainThread(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new ReturnToMainThread(PlayerLoopTiming.Update, cancellationToken);
	}

	public static ReturnToMainThread ReturnToMainThread(PlayerLoopTiming timing, CancellationToken cancellationToken = default(CancellationToken))
	{
		return new ReturnToMainThread(timing, cancellationToken);
	}

	public static void Post(Action action, PlayerLoopTiming timing = PlayerLoopTiming.Update)
	{
		PlayerLoopHelper.AddContinuation(timing, action);
	}

	public static SwitchToThreadPoolAwaitable SwitchToThreadPool()
	{
		return default(SwitchToThreadPoolAwaitable);
	}

	public static SwitchToTaskPoolAwaitable SwitchToTaskPool()
	{
		return default(SwitchToTaskPoolAwaitable);
	}

	public static SwitchToSynchronizationContextAwaitable SwitchToSynchronizationContext(SynchronizationContext synchronizationContext, CancellationToken cancellationToken = default(CancellationToken))
	{
		Error.ThrowArgumentNullException(synchronizationContext, "synchronizationContext");
		return new SwitchToSynchronizationContextAwaitable(synchronizationContext, cancellationToken);
	}

	public static ReturnToSynchronizationContext ReturnToSynchronizationContext(SynchronizationContext synchronizationContext, CancellationToken cancellationToken = default(CancellationToken))
	{
		return new ReturnToSynchronizationContext(synchronizationContext, dontPostWhenSameContext: false, cancellationToken);
	}

	public static ReturnToSynchronizationContext ReturnToCurrentSynchronizationContext(bool dontPostWhenSameContext = true, CancellationToken cancellationToken = default(CancellationToken))
	{
		return new ReturnToSynchronizationContext(SynchronizationContext.Current, dontPostWhenSameContext, cancellationToken);
	}

	public static UniTask WaitUntil(Func<bool> predicate, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		short num;
		return new UniTask(WaitUntilPromise.Create(predicate, timing, cancellationToken, cancelImmediately, out num), num);
	}

	public static UniTask WaitWhile(Func<bool> predicate, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		short num;
		return new UniTask(WaitWhilePromise.Create(predicate, timing, cancellationToken, cancelImmediately, out num), num);
	}

	public static UniTask WaitUntilCanceled(CancellationToken cancellationToken, PlayerLoopTiming timing = PlayerLoopTiming.Update, bool completeImmediately = false)
	{
		short num;
		return new UniTask(WaitUntilCanceledPromise.Create(cancellationToken, timing, completeImmediately, out num), num);
	}

	public static UniTask<U> WaitUntilValueChanged<T, U>(T target, Func<T, U> monitorFunction, PlayerLoopTiming monitorTiming = PlayerLoopTiming.Update, IEqualityComparer<U> equalityComparer = null, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false) where T : class
	{
		short num;
		return new UniTask<U>((target is UnityEngine.Object) ? WaitUntilValueChangedUnityObjectPromise<T, U>.Create(target, monitorFunction, equalityComparer, monitorTiming, cancellationToken, cancelImmediately, out num) : WaitUntilValueChangedStandardObjectPromise<T, U>.Create(target, monitorFunction, equalityComparer, monitorTiming, cancellationToken, cancelImmediately, out num), num);
	}

	public static UniTask<T[]> WhenAll<T>(params UniTask<T>[] tasks)
	{
		if (tasks.Length == 0)
		{
			return FromResult(Array.Empty<T>());
		}
		return new UniTask<T[]>(new WhenAllPromise<T>(tasks, tasks.Length), 0);
	}

	public static UniTask<T[]> WhenAll<T>(IEnumerable<UniTask<T>> tasks)
	{
		ArrayPoolUtil.RentArray<UniTask<T>> rentArray = ArrayPoolUtil.Materialize(tasks);
		try
		{
			return new UniTask<T[]>(new WhenAllPromise<T>(rentArray.Array, rentArray.Length), 0);
		}
		finally
		{
			((IDisposable)rentArray/*cast due to constrained. prefix*/).Dispose();
		}
	}

	public static UniTask WhenAll(params UniTask[] tasks)
	{
		if (tasks.Length == 0)
		{
			return CompletedTask;
		}
		return new UniTask(new WhenAllPromise(tasks, tasks.Length), 0);
	}

	public static UniTask WhenAll(IEnumerable<UniTask> tasks)
	{
		ArrayPoolUtil.RentArray<UniTask> rentArray = ArrayPoolUtil.Materialize(tasks);
		try
		{
			return new UniTask(new WhenAllPromise(rentArray.Array, rentArray.Length), 0);
		}
		finally
		{
			((IDisposable)rentArray/*cast due to constrained. prefix*/).Dispose();
		}
	}

	public static UniTask<(T1, T2)> WhenAll<T1, T2>(UniTask<T1> task1, UniTask<T2> task2)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2)>(new WhenAllPromise<T1, T2>(task1, task2), 0);
	}

	public static UniTask<(T1, T2, T3)> WhenAll<T1, T2, T3>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3)>(new WhenAllPromise<T1, T2, T3>(task1, task2, task3), 0);
	}

	public static UniTask<(T1, T2, T3, T4)> WhenAll<T1, T2, T3, T4>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4)>(new WhenAllPromise<T1, T2, T3, T4>(task1, task2, task3, task4), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5)> WhenAll<T1, T2, T3, T4, T5>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5)>(new WhenAllPromise<T1, T2, T3, T4, T5>(task1, task2, task3, task4, task5), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6)> WhenAll<T1, T2, T3, T4, T5, T6>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6>(task1, task2, task3, task4, task5, task6), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7)> WhenAll<T1, T2, T3, T4, T5, T6, T7>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully() && task7.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6, T7)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult(), task7.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6, T7)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6, T7>(task1, task2, task3, task4, task5, task6, task7), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8)> WhenAll<T1, T2, T3, T4, T5, T6, T7, T8>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully() && task7.Status.IsCompletedSuccessfully() && task8.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult(), task7.GetAwaiter().GetResult(), task8.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8>(task1, task2, task3, task4, task5, task6, task7, task8), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9)> WhenAll<T1, T2, T3, T4, T5, T6, T7, T8, T9>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully() && task7.Status.IsCompletedSuccessfully() && task8.Status.IsCompletedSuccessfully() && task9.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult(), task7.GetAwaiter().GetResult(), task8.GetAwaiter().GetResult(), task9.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>(task1, task2, task3, task4, task5, task6, task7, task8, task9), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)> WhenAll<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully() && task7.Status.IsCompletedSuccessfully() && task8.Status.IsCompletedSuccessfully() && task9.Status.IsCompletedSuccessfully() && task10.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult(), task7.GetAwaiter().GetResult(), task8.GetAwaiter().GetResult(), task9.GetAwaiter().GetResult(), task10.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)> WhenAll<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully() && task7.Status.IsCompletedSuccessfully() && task8.Status.IsCompletedSuccessfully() && task9.Status.IsCompletedSuccessfully() && task10.Status.IsCompletedSuccessfully() && task11.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult(), task7.GetAwaiter().GetResult(), task8.GetAwaiter().GetResult(), task9.GetAwaiter().GetResult(), task10.GetAwaiter().GetResult(), task11.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)> WhenAll<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully() && task7.Status.IsCompletedSuccessfully() && task8.Status.IsCompletedSuccessfully() && task9.Status.IsCompletedSuccessfully() && task10.Status.IsCompletedSuccessfully() && task11.Status.IsCompletedSuccessfully() && task12.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult(), task7.GetAwaiter().GetResult(), task8.GetAwaiter().GetResult(), task9.GetAwaiter().GetResult(), task10.GetAwaiter().GetResult(), task11.GetAwaiter().GetResult(), task12.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11, task12), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)> WhenAll<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully() && task7.Status.IsCompletedSuccessfully() && task8.Status.IsCompletedSuccessfully() && task9.Status.IsCompletedSuccessfully() && task10.Status.IsCompletedSuccessfully() && task11.Status.IsCompletedSuccessfully() && task12.Status.IsCompletedSuccessfully() && task13.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult(), task7.GetAwaiter().GetResult(), task8.GetAwaiter().GetResult(), task9.GetAwaiter().GetResult(), task10.GetAwaiter().GetResult(), task11.GetAwaiter().GetResult(), task12.GetAwaiter().GetResult(), task13.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11, task12, task13), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)> WhenAll<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully() && task7.Status.IsCompletedSuccessfully() && task8.Status.IsCompletedSuccessfully() && task9.Status.IsCompletedSuccessfully() && task10.Status.IsCompletedSuccessfully() && task11.Status.IsCompletedSuccessfully() && task12.Status.IsCompletedSuccessfully() && task13.Status.IsCompletedSuccessfully() && task14.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult(), task7.GetAwaiter().GetResult(), task8.GetAwaiter().GetResult(), task9.GetAwaiter().GetResult(), task10.GetAwaiter().GetResult(), task11.GetAwaiter().GetResult(), task12.GetAwaiter().GetResult(), task13.GetAwaiter().GetResult(), task14.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11, task12, task13, task14), 0);
	}

	public static UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)> WhenAll<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14, UniTask<T15> task15)
	{
		if (task1.Status.IsCompletedSuccessfully() && task2.Status.IsCompletedSuccessfully() && task3.Status.IsCompletedSuccessfully() && task4.Status.IsCompletedSuccessfully() && task5.Status.IsCompletedSuccessfully() && task6.Status.IsCompletedSuccessfully() && task7.Status.IsCompletedSuccessfully() && task8.Status.IsCompletedSuccessfully() && task9.Status.IsCompletedSuccessfully() && task10.Status.IsCompletedSuccessfully() && task11.Status.IsCompletedSuccessfully() && task12.Status.IsCompletedSuccessfully() && task13.Status.IsCompletedSuccessfully() && task14.Status.IsCompletedSuccessfully() && task15.Status.IsCompletedSuccessfully())
		{
			return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)>((task1.GetAwaiter().GetResult(), task2.GetAwaiter().GetResult(), task3.GetAwaiter().GetResult(), task4.GetAwaiter().GetResult(), task5.GetAwaiter().GetResult(), task6.GetAwaiter().GetResult(), task7.GetAwaiter().GetResult(), task8.GetAwaiter().GetResult(), task9.GetAwaiter().GetResult(), task10.GetAwaiter().GetResult(), task11.GetAwaiter().GetResult(), task12.GetAwaiter().GetResult(), task13.GetAwaiter().GetResult(), task14.GetAwaiter().GetResult(), task15.GetAwaiter().GetResult()));
		}
		return new UniTask<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)>(new WhenAllPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11, task12, task13, task14, task15), 0);
	}

	public static UniTask<(bool hasResultLeft, T result)> WhenAny<T>(UniTask<T> leftTask, UniTask rightTask)
	{
		return new UniTask<(bool, T)>(new WhenAnyLRPromise<T>(leftTask, rightTask), 0);
	}

	public static UniTask<(int winArgumentIndex, T result)> WhenAny<T>(params UniTask<T>[] tasks)
	{
		return new UniTask<(int, T)>(new WhenAnyPromise<T>(tasks, tasks.Length), 0);
	}

	public static UniTask<(int winArgumentIndex, T result)> WhenAny<T>(IEnumerable<UniTask<T>> tasks)
	{
		ArrayPoolUtil.RentArray<UniTask<T>> rentArray = ArrayPoolUtil.Materialize(tasks);
		try
		{
			return new UniTask<(int, T)>(new WhenAnyPromise<T>(rentArray.Array, rentArray.Length), 0);
		}
		finally
		{
			((IDisposable)rentArray/*cast due to constrained. prefix*/).Dispose();
		}
	}

	public static UniTask<int> WhenAny(params UniTask[] tasks)
	{
		return new UniTask<int>(new WhenAnyPromise(tasks, tasks.Length), 0);
	}

	public static UniTask<int> WhenAny(IEnumerable<UniTask> tasks)
	{
		ArrayPoolUtil.RentArray<UniTask> rentArray = ArrayPoolUtil.Materialize(tasks);
		try
		{
			return new UniTask<int>(new WhenAnyPromise(rentArray.Array, rentArray.Length), 0);
		}
		finally
		{
			((IDisposable)rentArray/*cast due to constrained. prefix*/).Dispose();
		}
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2)> WhenAny<T1, T2>(UniTask<T1> task1, UniTask<T2> task2)
	{
		return new UniTask<(int, T1, T2)>(new WhenAnyPromise<T1, T2>(task1, task2), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3)> WhenAny<T1, T2, T3>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3)
	{
		return new UniTask<(int, T1, T2, T3)>(new WhenAnyPromise<T1, T2, T3>(task1, task2, task3), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4)> WhenAny<T1, T2, T3, T4>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4)
	{
		return new UniTask<(int, T1, T2, T3, T4)>(new WhenAnyPromise<T1, T2, T3, T4>(task1, task2, task3, task4), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5)> WhenAny<T1, T2, T3, T4, T5>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5)>(new WhenAnyPromise<T1, T2, T3, T4, T5>(task1, task2, task3, task4, task5), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6)> WhenAny<T1, T2, T3, T4, T5, T6>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6>(task1, task2, task3, task4, task5, task6), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7)> WhenAny<T1, T2, T3, T4, T5, T6, T7>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6, T7)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7>(task1, task2, task3, task4, task5, task6, task7), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8)> WhenAny<T1, T2, T3, T4, T5, T6, T7, T8>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6, T7, T8)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8>(task1, task2, task3, task4, task5, task6, task7, task8), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9)> WhenAny<T1, T2, T3, T4, T5, T6, T7, T8, T9>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6, T7, T8, T9)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9>(task1, task2, task3, task4, task5, task6, task7, task8, task9), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10)> WhenAny<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11)> WhenAny<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12)> WhenAny<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11, task12), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13)> WhenAny<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11, task12, task13), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13, T14 result14)> WhenAny<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11, task12, task13, task14), 0);
	}

	public static UniTask<(int winArgumentIndex, T1 result1, T2 result2, T3 result3, T4 result4, T5 result5, T6 result6, T7 result7, T8 result8, T9 result9, T10 result10, T11 result11, T12 result12, T13 result13, T14 result14, T15 result15)> WhenAny<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(UniTask<T1> task1, UniTask<T2> task2, UniTask<T3> task3, UniTask<T4> task4, UniTask<T5> task5, UniTask<T6> task6, UniTask<T7> task7, UniTask<T8> task8, UniTask<T9> task9, UniTask<T10> task10, UniTask<T11> task11, UniTask<T12> task12, UniTask<T13> task13, UniTask<T14> task14, UniTask<T15> task15)
	{
		return new UniTask<(int, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)>(new WhenAnyPromise<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(task1, task2, task3, task4, task5, task6, task7, task8, task9, task10, task11, task12, task13, task14, task15), 0);
	}
}
[StructLayout(LayoutKind.Auto)]
[AsyncMethodBuilder(typeof(AsyncUniTaskMethodBuilder<>))]
public readonly struct UniTask<T>
{
	private sealed class IsCanceledSource : IUniTaskSource<(bool, T)>, IUniTaskSource
	{
		private readonly IUniTaskSource<T> source;

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public IsCanceledSource(IUniTaskSource<T> source)
		{
			this.source = source;
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public (bool, T) GetResult(short token)
		{
			if (source.GetStatus(token) == UniTaskStatus.Canceled)
			{
				return (true, default(T));
			}
			T result = source.GetResult(token);
			return (false, result);
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public UniTaskStatus GetStatus(short token)
		{
			return source.GetStatus(token);
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public UniTaskStatus UnsafeGetStatus()
		{
			return source.UnsafeGetStatus();
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			source.OnCompleted(continuation, state, token);
		}
	}

	private sealed class MemoizeSource : IUniTaskSource<T>, IUniTaskSource
	{
		private IUniTaskSource<T> source;

		private T result;

		private ExceptionDispatchInfo exception;

		private UniTaskStatus status;

		public MemoizeSource(IUniTaskSource<T> source)
		{
			this.source = source;
		}

		public T GetResult(short token)
		{
			if (source == null)
			{
				if (exception != null)
				{
					exception.Throw();
				}
				return result;
			}
			try
			{
				result = source.GetResult(token);
				status = UniTaskStatus.Succeeded;
				return result;
			}
			catch (Exception ex)
			{
				exception = ExceptionDispatchInfo.Capture(ex);
				if (ex is OperationCanceledException)
				{
					status = UniTaskStatus.Canceled;
				}
				else
				{
					status = UniTaskStatus.Faulted;
				}
				throw;
			}
			finally
			{
				source = null;
			}
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			if (source == null)
			{
				return status;
			}
			return source.GetStatus(token);
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			if (source == null)
			{
				continuation(state);
			}
			else
			{
				source.OnCompleted(continuation, state, token);
			}
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			if (source == null)
			{
				return status;
			}
			return source.UnsafeGetStatus();
		}
	}

	public readonly struct Awaiter(in UniTask<T> task) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private readonly UniTask<T> task = task;

		public bool IsCompleted
		{
			[MethodImpl((MethodImplOptions)256)]
			[DebuggerHidden]
			get
			{
				return task.Status.IsCompleted();
			}
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public T GetResult()
		{
			IUniTaskSource<T> source = task.source;
			if (source == null)
			{
				return task.result;
			}
			return source.GetResult(task.token);
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public void OnCompleted(Action continuation)
		{
			IUniTaskSource<T> source = task.source;
			if (source == null)
			{
				continuation();
			}
			else
			{
				source.OnCompleted(AwaiterActions.InvokeContinuationDelegate, continuation, task.token);
			}
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public void UnsafeOnCompleted(Action continuation)
		{
			IUniTaskSource<T> source = task.source;
			if (source == null)
			{
				continuation();
			}
			else
			{
				source.OnCompleted(AwaiterActions.InvokeContinuationDelegate, continuation, task.token);
			}
		}

		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		public void SourceOnCompleted(Action<object> continuation, object state)
		{
			IUniTaskSource<T> source = task.source;
			if (source == null)
			{
				continuation(state);
			}
			else
			{
				source.OnCompleted(continuation, state, task.token);
			}
		}
	}

	private readonly IUniTaskSource<T> source;

	private readonly T result;

	private readonly short token;

	public UniTaskStatus Status
	{
		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		get
		{
			if (source != null)
			{
				return source.GetStatus(token);
			}
			return UniTaskStatus.Succeeded;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public UniTask(T result)
	{
		source = null;
		token = 0;
		this.result = result;
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public UniTask(IUniTaskSource<T> source, short token)
	{
		this.source = source;
		this.token = token;
		result = default(T);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public Awaiter GetAwaiter()
	{
		return new Awaiter(this);
	}

	public UniTask<T> Preserve()
	{
		if (source == null)
		{
			return this;
		}
		return new UniTask<T>(new MemoizeSource(source), token);
	}

	public UniTask AsUniTask()
	{
		if (source == null)
		{
			return UniTask.CompletedTask;
		}
		if (source.GetStatus(token).IsCompletedSuccessfully())
		{
			source.GetResult(token);
			return UniTask.CompletedTask;
		}
		return new UniTask(source, token);
	}

	public static implicit operator UniTask(UniTask<T> self)
	{
		return self.AsUniTask();
	}

	public UniTask<(bool IsCanceled, T Result)> SuppressCancellationThrow()
	{
		if (source == null)
		{
			return new UniTask<(bool, T)>((false, result));
		}
		return new UniTask<(bool, T)>(new IsCanceledSource(source), token);
	}

	public override string ToString()
	{
		if (source != null)
		{
			return "(" + source.UnsafeGetStatus().ToString() + ")";
		}
		T val = result;
		if (val == null)
		{
			return null;
		}
		return val.ToString();
	}
}
