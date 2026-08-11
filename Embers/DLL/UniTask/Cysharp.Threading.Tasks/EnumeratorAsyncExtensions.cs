using System;
using System.Collections;
using System.Reflection;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;
using UnityEngine;

namespace Cysharp.Threading.Tasks;

public static class EnumeratorAsyncExtensions
{
	private sealed class EnumeratorPromise : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<EnumeratorPromise>
	{
		private static TaskPool<EnumeratorPromise> pool;

		private EnumeratorPromise nextNode;

		private IEnumerator innerEnumerator;

		private CancellationToken cancellationToken;

		private int initialFrame;

		private bool loopRunning;

		private bool calledGetResult;

		private UniTaskCompletionSourceCore<object> core;

		private static readonly FieldInfo waitForSeconds_Seconds;

		public ref EnumeratorPromise NextNode => ref nextNode;

		static EnumeratorPromise()
		{
			waitForSeconds_Seconds = typeof(WaitForSeconds).GetField("m_Seconds", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.GetField);
			TaskPool.RegisterSizeGetter(typeof(EnumeratorPromise), () => pool.Size);
		}

		private EnumeratorPromise()
		{
		}

		public static IUniTaskSource Create(IEnumerator innerEnumerator, PlayerLoopTiming timing, CancellationToken cancellationToken, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new EnumeratorPromise();
			}
			result.innerEnumerator = ConsumeEnumerator(innerEnumerator);
			result.cancellationToken = cancellationToken;
			result.loopRunning = true;
			result.calledGetResult = false;
			result.initialFrame = -1;
			token = result.core.Version;
			if (result.MoveNext())
			{
				PlayerLoopHelper.AddAction(timing, result);
			}
			return result;
		}

		public void GetResult(short token)
		{
			try
			{
				calledGetResult = true;
				core.GetResult(token);
			}
			finally
			{
				if (!loopRunning)
				{
					TryReturn();
				}
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
			if (calledGetResult)
			{
				loopRunning = false;
				TryReturn();
				return false;
			}
			if (innerEnumerator == null)
			{
				return false;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				loopRunning = false;
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (initialFrame == -1)
			{
				if (PlayerLoopHelper.IsMainThread)
				{
					initialFrame = Time.frameCount;
				}
			}
			else if (initialFrame == Time.frameCount)
			{
				return true;
			}
			try
			{
				if (innerEnumerator.MoveNext())
				{
					return true;
				}
			}
			catch (Exception error)
			{
				loopRunning = false;
				core.TrySetException(error);
				return false;
			}
			loopRunning = false;
			core.TrySetResult(null);
			return false;
		}

		private bool TryReturn()
		{
			core.Reset();
			innerEnumerator = null;
			cancellationToken = default(CancellationToken);
			return pool.TryPush(this);
		}

		private static IEnumerator ConsumeEnumerator(IEnumerator enumerator)
		{
			while (enumerator.MoveNext())
			{
				object current = enumerator.Current;
				if (current == null)
				{
					yield return null;
					continue;
				}
				if (current is CustomYieldInstruction cyi)
				{
					while (cyi.keepWaiting)
					{
						yield return null;
					}
					continue;
				}
				if (current is YieldInstruction)
				{
					IEnumerator innerCoroutine = null;
					if (!(current is AsyncOperation asyncOperation))
					{
						if (current is WaitForSeconds waitForSeconds)
						{
							innerCoroutine = UnwrapWaitForSeconds(waitForSeconds);
						}
					}
					else
					{
						innerCoroutine = UnwrapWaitAsyncOperation(asyncOperation);
					}
					if (innerCoroutine != null)
					{
						while (innerCoroutine.MoveNext())
						{
							yield return null;
						}
						continue;
					}
				}
				else if (current is IEnumerator enumerator2)
				{
					IEnumerator innerCoroutine = ConsumeEnumerator(enumerator2);
					while (innerCoroutine.MoveNext())
					{
						yield return null;
					}
					continue;
				}
				Debug.LogWarning("yield " + current.GetType().Name + " is not supported on await IEnumerator or IEnumerator.ToUniTask(), please use ToUniTask(MonoBehaviour coroutineRunner) instead.");
				yield return null;
			}
		}

		private static IEnumerator UnwrapWaitForSeconds(WaitForSeconds waitForSeconds)
		{
			float second = (float)waitForSeconds_Seconds.GetValue(waitForSeconds);
			float elapsed = 0f;
			do
			{
				yield return null;
				elapsed += Time.deltaTime;
			}
			while (!(elapsed >= second));
		}

		private static IEnumerator UnwrapWaitAsyncOperation(AsyncOperation asyncOperation)
		{
			while (!asyncOperation.isDone)
			{
				yield return null;
			}
		}
	}

	public static UniTask.Awaiter GetAwaiter<T>(this T enumerator) where T : IEnumerator
	{
		object obj = enumerator;
		Error.ThrowArgumentNullException((IEnumerator)obj, "enumerator");
		short token;
		return new UniTask(EnumeratorPromise.Create((IEnumerator)obj, PlayerLoopTiming.Update, CancellationToken.None, out token), token).GetAwaiter();
	}

	public static UniTask WithCancellation(this IEnumerator enumerator, CancellationToken cancellationToken)
	{
		Error.ThrowArgumentNullException(enumerator, "enumerator");
		short token;
		return new UniTask(EnumeratorPromise.Create(enumerator, PlayerLoopTiming.Update, cancellationToken, out token), token);
	}

	public static UniTask ToUniTask(this IEnumerator enumerator, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken))
	{
		Error.ThrowArgumentNullException(enumerator, "enumerator");
		short token;
		return new UniTask(EnumeratorPromise.Create(enumerator, timing, cancellationToken, out token), token);
	}

	public static UniTask ToUniTask(this IEnumerator enumerator, MonoBehaviour coroutineRunner)
	{
		AutoResetUniTaskCompletionSource autoResetUniTaskCompletionSource = AutoResetUniTaskCompletionSource.Create();
		coroutineRunner.StartCoroutine(Core(enumerator, coroutineRunner, autoResetUniTaskCompletionSource));
		return autoResetUniTaskCompletionSource.Task;
	}

	private static IEnumerator Core(IEnumerator inner, MonoBehaviour coroutineRunner, AutoResetUniTaskCompletionSource source)
	{
		yield return coroutineRunner.StartCoroutine(inner);
		source.TrySetResult();
	}
}
