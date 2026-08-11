#define UNITY_EDITOR
using System;
using Cysharp.Threading.Tasks;
using YooAsset;

namespace GameFramework.Resource;

public static class AsyncOperationBaseExtensions
{
	private sealed class AsyncOperationBaserConfiguredSource : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<AsyncOperationBaserConfiguredSource>
	{
		private static TaskPool<AsyncOperationBaserConfiguredSource> pool;

		private AsyncOperationBaserConfiguredSource nextNode;

		private readonly Action<AsyncOperationBase> continuationAction;

		private AsyncOperationBase handle;

		private IProgress<float> progress;

		private bool completed;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		public ref AsyncOperationBaserConfiguredSource NextNode => ref nextNode;

		static AsyncOperationBaserConfiguredSource()
		{
			TaskPool.RegisterSizeGetter(typeof(AsyncOperationBaserConfiguredSource), () => pool.Size);
		}

		private AsyncOperationBaserConfiguredSource()
		{
			continuationAction = Continuation;
		}

		public static IUniTaskSource Create(AsyncOperationBase handle, PlayerLoopTiming timing, IProgress<float> progress, out short token)
		{
			if (!pool.TryPop(out AsyncOperationBaserConfiguredSource result))
			{
				result = new AsyncOperationBaserConfiguredSource();
			}
			result.handle = handle;
			result.progress = progress;
			result.completed = false;
			TaskTracker.TrackActiveTask(result, 3);
			if (progress != null)
			{
				PlayerLoopHelper.AddAction(timing, result);
			}
			handle.Completed += result.continuationAction;
			token = result.core.Version;
			return result;
		}

		private void Continuation(AsyncOperationBase _)
		{
			//IL_0036: Unknown result type (might be due to invalid IL or missing references)
			//IL_003c: Invalid comparison between Unknown and I4
			handle.Completed -= continuationAction;
			if (completed)
			{
				TryReturn();
				return;
			}
			completed = true;
			if ((int)handle.Status == 3)
			{
				core.TrySetException(new Exception(handle.Error));
			}
			else
			{
				core.TrySetResult(AsyncUnit.Default);
			}
		}

		private bool TryReturn()
		{
			TaskTracker.RemoveTracking(this);
			core.Reset();
			handle = null;
			progress = null;
			return pool.TryPush(this);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public void GetResult(short token)
		{
			core.GetResult(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public bool MoveNext()
		{
			if (completed)
			{
				TryReturn();
				return false;
			}
			if (!handle.IsDone)
			{
				progress?.Report(handle.Progress);
			}
			return true;
		}
	}

	public static UniTask.Awaiter GetAwaiter(this AsyncOperationBase handle)
	{
		return handle.ToUniTask().GetAwaiter();
	}

	public static UniTask ToUniTask(this AsyncOperationBase handle, IProgress<float> progress = null, PlayerLoopTiming timing = PlayerLoopTiming.Update)
	{
		Error.ThrowArgumentNullException<AsyncOperationBase>(handle, "handle");
		if (handle.IsDone)
		{
			return UniTask.CompletedTask;
		}
		short token;
		return new UniTask(AsyncOperationBaserConfiguredSource.Create(handle, timing, progress, out token), token);
	}
}
