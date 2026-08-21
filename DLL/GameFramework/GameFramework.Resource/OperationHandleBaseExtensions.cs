#define UNITY_EDITOR
using System;
using System.Runtime.CompilerServices;
using Cysharp.Threading.Tasks;
using YooAsset;

namespace GameFramework.Resource;

public static class OperationHandleBaseExtensions
{
	private sealed class OperationHandleBaserConfiguredSource : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<OperationHandleBaserConfiguredSource>
	{
		private static TaskPool<OperationHandleBaserConfiguredSource> pool;

		private OperationHandleBaserConfiguredSource nextNode;

		private readonly Action<HandleBase> continuationAction;

		private HandleBase handle;

		private IProgress<float> progress;

		private bool completed;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		public ref OperationHandleBaserConfiguredSource NextNode => ref nextNode;

		static OperationHandleBaserConfiguredSource()
		{
			TaskPool.RegisterSizeGetter(typeof(OperationHandleBaserConfiguredSource), () => pool.Size);
		}

		private OperationHandleBaserConfiguredSource()
		{
			continuationAction = Continuation;
		}

		public static IUniTaskSource Create(HandleBase handle, PlayerLoopTiming timing, IProgress<float> progress, out short token)
		{
			if (!pool.TryPop(out OperationHandleBaserConfiguredSource result))
			{
				result = new OperationHandleBaserConfiguredSource();
			}
			result.handle = handle;
			result.progress = progress;
			result.completed = false;
			TaskTracker.TrackActiveTask(result, 3);
			if (progress != null)
			{
				PlayerLoopHelper.AddAction(timing, result);
			}
			AssetHandle val = (AssetHandle)(object)((handle is AssetHandle) ? handle : null);
			if (val == null)
			{
				SceneHandle val2 = (SceneHandle)(object)((handle is SceneHandle) ? handle : null);
				if (val2 == null)
				{
					SubAssetsHandle val3 = (SubAssetsHandle)(object)((handle is SubAssetsHandle) ? handle : null);
					if (val3 == null)
					{
						RawFileHandle val4 = (RawFileHandle)(object)((handle is RawFileHandle) ? handle : null);
						if (val4 == null)
						{
							AllAssetsHandle val5 = (AllAssetsHandle)(object)((handle is AllAssetsHandle) ? handle : null);
							if (val5 != null)
							{
								val5.Completed += (Action<AllAssetsHandle>)result.continuationAction;
							}
						}
						else
						{
							val4.Completed += (Action<RawFileHandle>)result.continuationAction;
						}
					}
					else
					{
						val3.Completed += (Action<SubAssetsHandle>)result.continuationAction;
					}
				}
				else
				{
					val2.Completed += (Action<SceneHandle>)result.continuationAction;
				}
			}
			else
			{
				val.Completed += (Action<AssetHandle>)result.continuationAction;
			}
			token = result.core.Version;
			return result;
		}

		[MethodImpl((MethodImplOptions)256)]
		private void BaseContinuation()
		{
			//IL_0024: Unknown result type (might be due to invalid IL or missing references)
			//IL_002a: Invalid comparison between Unknown and I4
			if (completed)
			{
				TryReturn();
				return;
			}
			completed = true;
			if ((int)handle.Status == 3)
			{
				core.TrySetException(new Exception(handle.LastError));
			}
			else
			{
				core.TrySetResult(AsyncUnit.Default);
			}
		}

		private void Continuation(HandleBase _)
		{
			HandleBase val = handle;
			HandleBase val2 = val;
			AssetHandle val3 = (AssetHandle)(object)((val2 is AssetHandle) ? val2 : null);
			if (val3 == null)
			{
				SceneHandle val4 = (SceneHandle)(object)((val2 is SceneHandle) ? val2 : null);
				if (val4 == null)
				{
					SubAssetsHandle val5 = (SubAssetsHandle)(object)((val2 is SubAssetsHandle) ? val2 : null);
					if (val5 == null)
					{
						RawFileHandle val6 = (RawFileHandle)(object)((val2 is RawFileHandle) ? val2 : null);
						if (val6 == null)
						{
							AllAssetsHandle val7 = (AllAssetsHandle)(object)((val2 is AllAssetsHandle) ? val2 : null);
							if (val7 != null)
							{
								val7.Completed -= (Action<AllAssetsHandle>)continuationAction;
							}
						}
						else
						{
							val6.Completed -= (Action<RawFileHandle>)continuationAction;
						}
					}
					else
					{
						val5.Completed -= (Action<SubAssetsHandle>)continuationAction;
					}
				}
				else
				{
					val4.Completed -= (Action<SceneHandle>)continuationAction;
				}
			}
			else
			{
				val3.Completed -= (Action<AssetHandle>)continuationAction;
			}
			BaseContinuation();
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
			if (handle.IsValid)
			{
				progress?.Report(handle.Progress);
			}
			return true;
		}
	}

	public static UniTask.Awaiter GetAwaiter(this HandleBase handle)
	{
		return handle.ToUniTask().GetAwaiter();
	}

	public static UniTask ToUniTask(this HandleBase handle, IProgress<float> progress = null, PlayerLoopTiming timing = PlayerLoopTiming.Update)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Invalid comparison between Unknown and I4
		Error.ThrowArgumentNullException<HandleBase>(handle, "handle");
		if ((int)handle.Status == 3 || !handle.IsValid)
		{
			return UniTask.CompletedTask;
		}
		short token;
		return new UniTask(OperationHandleBaserConfiguredSource.Create(handle, timing, progress, out token), token);
	}
}
