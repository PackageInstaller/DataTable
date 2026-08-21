using System;
using System.Runtime.CompilerServices;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;
using Unity.Jobs;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Networking;
using UnityEngine.Rendering;
using UnityEngine.UI;

namespace Cysharp.Threading.Tasks;

public static class UnityAsyncExtensions
{
	public struct AssetBundleRequestAllAssetsAwaiter(AssetBundleRequest asyncOperation) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private AssetBundleRequest asyncOperation = asyncOperation;

		private Action<AsyncOperation> continuationAction = null;

		public bool IsCompleted => ((AsyncOperation)(object)asyncOperation).isDone;

		public AssetBundleRequestAllAssetsAwaiter GetAwaiter()
		{
			return this;
		}

		public UnityEngine.Object[] GetResult()
		{
			if (continuationAction != null)
			{
				((AsyncOperation)(object)asyncOperation).completed -= continuationAction;
				continuationAction = null;
				UnityEngine.Object[] allAssets = asyncOperation.allAssets;
				asyncOperation = null;
				return allAssets;
			}
			UnityEngine.Object[] allAssets2 = asyncOperation.allAssets;
			asyncOperation = null;
			return allAssets2;
		}

		public void OnCompleted(Action continuation)
		{
			UnsafeOnCompleted(continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			Error.ThrowWhenContinuationIsAlreadyRegistered(continuationAction);
			continuationAction = PooledDelegate<AsyncOperation>.Create(continuation);
			((AsyncOperation)(object)asyncOperation).completed += continuationAction;
		}
	}

	private sealed class AssetBundleRequestAllAssetsConfiguredSource : IUniTaskSource<UnityEngine.Object[]>, IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<AssetBundleRequestAllAssetsConfiguredSource>
	{
		private static TaskPool<AssetBundleRequestAllAssetsConfiguredSource> pool;

		private AssetBundleRequestAllAssetsConfiguredSource nextNode;

		private AssetBundleRequest asyncOperation;

		private IProgress<float> progress;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private bool completed;

		private UniTaskCompletionSourceCore<UnityEngine.Object[]> core;

		private Action<AsyncOperation> continuationAction;

		public ref AssetBundleRequestAllAssetsConfiguredSource NextNode => ref nextNode;

		static AssetBundleRequestAllAssetsConfiguredSource()
		{
			TaskPool.RegisterSizeGetter(typeof(AssetBundleRequestAllAssetsConfiguredSource), () => pool.Size);
		}

		private AssetBundleRequestAllAssetsConfiguredSource()
		{
			continuationAction = Continuation;
		}

		public static IUniTaskSource<UnityEngine.Object[]> Create(AssetBundleRequest asyncOperation, PlayerLoopTiming timing, IProgress<float> progress, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource<UnityEngine.Object[]>.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new AssetBundleRequestAllAssetsConfiguredSource();
			}
			result.asyncOperation = asyncOperation;
			result.progress = progress;
			result.cancellationToken = cancellationToken;
			result.completed = false;
			((AsyncOperation)(object)asyncOperation).completed += result.continuationAction;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					AssetBundleRequestAllAssetsConfiguredSource assetBundleRequestAllAssetsConfiguredSource = (AssetBundleRequestAllAssetsConfiguredSource)state;
					assetBundleRequestAllAssetsConfiguredSource.core.TrySetCanceled(assetBundleRequestAllAssetsConfiguredSource.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public UnityEngine.Object[] GetResult(short token)
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
			if (completed || asyncOperation == null)
			{
				return false;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (progress != null)
			{
				progress.Report(((AsyncOperation)(object)asyncOperation).progress);
			}
			if (((AsyncOperation)(object)asyncOperation).isDone)
			{
				core.TrySetResult(asyncOperation.allAssets);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			asyncOperation = null;
			progress = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}

		private void Continuation(AsyncOperation _)
		{
			if (completed)
			{
				TryReturn();
				return;
			}
			completed = true;
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
			}
			else
			{
				core.TrySetResult(asyncOperation.allAssets);
			}
		}
	}

	private sealed class AsyncGPUReadbackRequestAwaiterConfiguredSource : IUniTaskSource<AsyncGPUReadbackRequest>, IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<AsyncGPUReadbackRequestAwaiterConfiguredSource>
	{
		private static TaskPool<AsyncGPUReadbackRequestAwaiterConfiguredSource> pool;

		private AsyncGPUReadbackRequestAwaiterConfiguredSource nextNode;

		private AsyncGPUReadbackRequest asyncOperation;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<AsyncGPUReadbackRequest> core;

		public ref AsyncGPUReadbackRequestAwaiterConfiguredSource NextNode => ref nextNode;

		static AsyncGPUReadbackRequestAwaiterConfiguredSource()
		{
			TaskPool.RegisterSizeGetter(typeof(AsyncGPUReadbackRequestAwaiterConfiguredSource), () => pool.Size);
		}

		private AsyncGPUReadbackRequestAwaiterConfiguredSource()
		{
		}

		public static IUniTaskSource<AsyncGPUReadbackRequest> Create(AsyncGPUReadbackRequest asyncOperation, PlayerLoopTiming timing, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource<AsyncGPUReadbackRequest>.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new AsyncGPUReadbackRequestAwaiterConfiguredSource();
			}
			result.asyncOperation = asyncOperation;
			result.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					AsyncGPUReadbackRequestAwaiterConfiguredSource asyncGPUReadbackRequestAwaiterConfiguredSource = (AsyncGPUReadbackRequestAwaiterConfiguredSource)state;
					asyncGPUReadbackRequestAwaiterConfiguredSource.core.TrySetCanceled(asyncGPUReadbackRequestAwaiterConfiguredSource.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public AsyncGPUReadbackRequest GetResult(short token)
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
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (asyncOperation.hasError)
			{
				core.TrySetException(new Exception("AsyncGPUReadbackRequest.hasError = true"));
				return false;
			}
			if (asyncOperation.done)
			{
				core.TrySetResult(asyncOperation);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			asyncOperation = default(AsyncGPUReadbackRequest);
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}
	}

	public struct AsyncOperationAwaiter(AsyncOperation asyncOperation) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private AsyncOperation asyncOperation = asyncOperation;

		private Action<AsyncOperation> continuationAction = null;

		public bool IsCompleted => asyncOperation.isDone;

		public void GetResult()
		{
			if (continuationAction != null)
			{
				asyncOperation.completed -= continuationAction;
				continuationAction = null;
				asyncOperation = null;
			}
			else
			{
				asyncOperation = null;
			}
		}

		public void OnCompleted(Action continuation)
		{
			UnsafeOnCompleted(continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			Error.ThrowWhenContinuationIsAlreadyRegistered(continuationAction);
			continuationAction = PooledDelegate<AsyncOperation>.Create(continuation);
			asyncOperation.completed += continuationAction;
		}
	}

	private sealed class AsyncOperationConfiguredSource : IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<AsyncOperationConfiguredSource>
	{
		private static TaskPool<AsyncOperationConfiguredSource> pool;

		private AsyncOperationConfiguredSource nextNode;

		private AsyncOperation asyncOperation;

		private IProgress<float> progress;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private bool completed;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		private Action<AsyncOperation> continuationAction;

		public ref AsyncOperationConfiguredSource NextNode => ref nextNode;

		static AsyncOperationConfiguredSource()
		{
			TaskPool.RegisterSizeGetter(typeof(AsyncOperationConfiguredSource), () => pool.Size);
		}

		private AsyncOperationConfiguredSource()
		{
			continuationAction = Continuation;
		}

		public static IUniTaskSource Create(AsyncOperation asyncOperation, PlayerLoopTiming timing, IProgress<float> progress, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new AsyncOperationConfiguredSource();
			}
			result.asyncOperation = asyncOperation;
			result.progress = progress;
			result.cancellationToken = cancellationToken;
			result.completed = false;
			asyncOperation.completed += result.continuationAction;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					AsyncOperationConfiguredSource asyncOperationConfiguredSource = (AsyncOperationConfiguredSource)state;
					asyncOperationConfiguredSource.core.TrySetCanceled(asyncOperationConfiguredSource.cancellationToken);
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
			if (completed || asyncOperation == null)
			{
				return false;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (progress != null)
			{
				progress.Report(asyncOperation.progress);
			}
			if (asyncOperation.isDone)
			{
				core.TrySetResult(AsyncUnit.Default);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			asyncOperation.completed -= continuationAction;
			asyncOperation = null;
			progress = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}

		private void Continuation(AsyncOperation _)
		{
			if (completed)
			{
				TryReturn();
				return;
			}
			completed = true;
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
			}
			else
			{
				core.TrySetResult(AsyncUnit.Default);
			}
		}
	}

	public struct ResourceRequestAwaiter(ResourceRequest asyncOperation) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private ResourceRequest asyncOperation = asyncOperation;

		private Action<AsyncOperation> continuationAction = null;

		public bool IsCompleted => asyncOperation.isDone;

		public UnityEngine.Object GetResult()
		{
			if (continuationAction != null)
			{
				asyncOperation.completed -= continuationAction;
				continuationAction = null;
				UnityEngine.Object asset = asyncOperation.asset;
				asyncOperation = null;
				return asset;
			}
			UnityEngine.Object asset2 = asyncOperation.asset;
			asyncOperation = null;
			return asset2;
		}

		public void OnCompleted(Action continuation)
		{
			UnsafeOnCompleted(continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			Error.ThrowWhenContinuationIsAlreadyRegistered(continuationAction);
			continuationAction = PooledDelegate<AsyncOperation>.Create(continuation);
			asyncOperation.completed += continuationAction;
		}
	}

	private sealed class ResourceRequestConfiguredSource : IUniTaskSource<UnityEngine.Object>, IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<ResourceRequestConfiguredSource>
	{
		private static TaskPool<ResourceRequestConfiguredSource> pool;

		private ResourceRequestConfiguredSource nextNode;

		private ResourceRequest asyncOperation;

		private IProgress<float> progress;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private bool completed;

		private UniTaskCompletionSourceCore<UnityEngine.Object> core;

		private Action<AsyncOperation> continuationAction;

		public ref ResourceRequestConfiguredSource NextNode => ref nextNode;

		static ResourceRequestConfiguredSource()
		{
			TaskPool.RegisterSizeGetter(typeof(ResourceRequestConfiguredSource), () => pool.Size);
		}

		private ResourceRequestConfiguredSource()
		{
			continuationAction = Continuation;
		}

		public static IUniTaskSource<UnityEngine.Object> Create(ResourceRequest asyncOperation, PlayerLoopTiming timing, IProgress<float> progress, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource<UnityEngine.Object>.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new ResourceRequestConfiguredSource();
			}
			result.asyncOperation = asyncOperation;
			result.progress = progress;
			result.cancellationToken = cancellationToken;
			result.completed = false;
			asyncOperation.completed += result.continuationAction;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					ResourceRequestConfiguredSource resourceRequestConfiguredSource = (ResourceRequestConfiguredSource)state;
					resourceRequestConfiguredSource.core.TrySetCanceled(resourceRequestConfiguredSource.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public UnityEngine.Object GetResult(short token)
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
			if (completed || asyncOperation == null)
			{
				return false;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (progress != null)
			{
				progress.Report(asyncOperation.progress);
			}
			if (asyncOperation.isDone)
			{
				core.TrySetResult(asyncOperation.asset);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			asyncOperation.completed -= continuationAction;
			asyncOperation = null;
			progress = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}

		private void Continuation(AsyncOperation _)
		{
			if (completed)
			{
				TryReturn();
				return;
			}
			completed = true;
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
			}
			else
			{
				core.TrySetResult(asyncOperation.asset);
			}
		}
	}

	public struct AssetBundleRequestAwaiter(AssetBundleRequest asyncOperation) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private AssetBundleRequest asyncOperation = asyncOperation;

		private Action<AsyncOperation> continuationAction = null;

		public bool IsCompleted => ((AsyncOperation)(object)asyncOperation).isDone;

		public UnityEngine.Object GetResult()
		{
			if (continuationAction != null)
			{
				((AsyncOperation)(object)asyncOperation).completed -= continuationAction;
				continuationAction = null;
				UnityEngine.Object asset = asyncOperation.asset;
				asyncOperation = null;
				return asset;
			}
			UnityEngine.Object asset2 = asyncOperation.asset;
			asyncOperation = null;
			return asset2;
		}

		public void OnCompleted(Action continuation)
		{
			UnsafeOnCompleted(continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			Error.ThrowWhenContinuationIsAlreadyRegistered(continuationAction);
			continuationAction = PooledDelegate<AsyncOperation>.Create(continuation);
			((AsyncOperation)(object)asyncOperation).completed += continuationAction;
		}
	}

	private sealed class AssetBundleRequestConfiguredSource : IUniTaskSource<UnityEngine.Object>, IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<AssetBundleRequestConfiguredSource>
	{
		private static TaskPool<AssetBundleRequestConfiguredSource> pool;

		private AssetBundleRequestConfiguredSource nextNode;

		private AssetBundleRequest asyncOperation;

		private IProgress<float> progress;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private bool completed;

		private UniTaskCompletionSourceCore<UnityEngine.Object> core;

		private Action<AsyncOperation> continuationAction;

		public ref AssetBundleRequestConfiguredSource NextNode => ref nextNode;

		static AssetBundleRequestConfiguredSource()
		{
			TaskPool.RegisterSizeGetter(typeof(AssetBundleRequestConfiguredSource), () => pool.Size);
		}

		private AssetBundleRequestConfiguredSource()
		{
			continuationAction = Continuation;
		}

		public static IUniTaskSource<UnityEngine.Object> Create(AssetBundleRequest asyncOperation, PlayerLoopTiming timing, IProgress<float> progress, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource<UnityEngine.Object>.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new AssetBundleRequestConfiguredSource();
			}
			result.asyncOperation = asyncOperation;
			result.progress = progress;
			result.cancellationToken = cancellationToken;
			result.completed = false;
			((AsyncOperation)(object)asyncOperation).completed += result.continuationAction;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					AssetBundleRequestConfiguredSource assetBundleRequestConfiguredSource = (AssetBundleRequestConfiguredSource)state;
					assetBundleRequestConfiguredSource.core.TrySetCanceled(assetBundleRequestConfiguredSource.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public UnityEngine.Object GetResult(short token)
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
			if (completed || asyncOperation == null)
			{
				return false;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (progress != null)
			{
				progress.Report(((AsyncOperation)(object)asyncOperation).progress);
			}
			if (((AsyncOperation)(object)asyncOperation).isDone)
			{
				core.TrySetResult(asyncOperation.asset);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			((AsyncOperation)(object)asyncOperation).completed -= continuationAction;
			asyncOperation = null;
			progress = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}

		private void Continuation(AsyncOperation _)
		{
			if (completed)
			{
				TryReturn();
				return;
			}
			completed = true;
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
			}
			else
			{
				core.TrySetResult(asyncOperation.asset);
			}
		}
	}

	public struct AssetBundleCreateRequestAwaiter(AssetBundleCreateRequest asyncOperation) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private AssetBundleCreateRequest asyncOperation = asyncOperation;

		private Action<AsyncOperation> continuationAction = null;

		public bool IsCompleted => ((AsyncOperation)(object)asyncOperation).isDone;

		public AssetBundle GetResult()
		{
			if (continuationAction != null)
			{
				((AsyncOperation)(object)asyncOperation).completed -= continuationAction;
				continuationAction = null;
				AssetBundle assetBundle = asyncOperation.assetBundle;
				asyncOperation = null;
				return assetBundle;
			}
			AssetBundle assetBundle2 = asyncOperation.assetBundle;
			asyncOperation = null;
			return assetBundle2;
		}

		public void OnCompleted(Action continuation)
		{
			UnsafeOnCompleted(continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			Error.ThrowWhenContinuationIsAlreadyRegistered(continuationAction);
			continuationAction = PooledDelegate<AsyncOperation>.Create(continuation);
			((AsyncOperation)(object)asyncOperation).completed += continuationAction;
		}
	}

	private sealed class AssetBundleCreateRequestConfiguredSource : IUniTaskSource<AssetBundle>, IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<AssetBundleCreateRequestConfiguredSource>
	{
		private static TaskPool<AssetBundleCreateRequestConfiguredSource> pool;

		private AssetBundleCreateRequestConfiguredSource nextNode;

		private AssetBundleCreateRequest asyncOperation;

		private IProgress<float> progress;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private bool completed;

		private UniTaskCompletionSourceCore<AssetBundle> core;

		private Action<AsyncOperation> continuationAction;

		public ref AssetBundleCreateRequestConfiguredSource NextNode => ref nextNode;

		static AssetBundleCreateRequestConfiguredSource()
		{
			TaskPool.RegisterSizeGetter(typeof(AssetBundleCreateRequestConfiguredSource), () => pool.Size);
		}

		private AssetBundleCreateRequestConfiguredSource()
		{
			continuationAction = Continuation;
		}

		public static IUniTaskSource<AssetBundle> Create(AssetBundleCreateRequest asyncOperation, PlayerLoopTiming timing, IProgress<float> progress, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource<AssetBundle>.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new AssetBundleCreateRequestConfiguredSource();
			}
			result.asyncOperation = asyncOperation;
			result.progress = progress;
			result.cancellationToken = cancellationToken;
			result.completed = false;
			((AsyncOperation)(object)asyncOperation).completed += result.continuationAction;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					AssetBundleCreateRequestConfiguredSource assetBundleCreateRequestConfiguredSource = (AssetBundleCreateRequestConfiguredSource)state;
					assetBundleCreateRequestConfiguredSource.core.TrySetCanceled(assetBundleCreateRequestConfiguredSource.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public AssetBundle GetResult(short token)
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
			if (completed || asyncOperation == null)
			{
				return false;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (progress != null)
			{
				progress.Report(((AsyncOperation)(object)asyncOperation).progress);
			}
			if (((AsyncOperation)(object)asyncOperation).isDone)
			{
				core.TrySetResult(asyncOperation.assetBundle);
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			((AsyncOperation)(object)asyncOperation).completed -= continuationAction;
			asyncOperation = null;
			progress = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}

		private void Continuation(AsyncOperation _)
		{
			if (completed)
			{
				TryReturn();
				return;
			}
			completed = true;
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
			}
			else
			{
				core.TrySetResult(asyncOperation.assetBundle);
			}
		}
	}

	public struct UnityWebRequestAsyncOperationAwaiter(UnityWebRequestAsyncOperation asyncOperation) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private UnityWebRequestAsyncOperation asyncOperation = asyncOperation;

		private Action<AsyncOperation> continuationAction = null;

		public bool IsCompleted => ((AsyncOperation)(object)asyncOperation).isDone;

		public UnityWebRequest GetResult()
		{
			if (continuationAction != null)
			{
				((AsyncOperation)(object)asyncOperation).completed -= continuationAction;
				continuationAction = null;
				UnityWebRequest webRequest = asyncOperation.webRequest;
				asyncOperation = null;
				if (webRequest.IsError())
				{
					throw new UnityWebRequestException(webRequest);
				}
				return webRequest;
			}
			UnityWebRequest webRequest2 = asyncOperation.webRequest;
			asyncOperation = null;
			if (webRequest2.IsError())
			{
				throw new UnityWebRequestException(webRequest2);
			}
			return webRequest2;
		}

		public void OnCompleted(Action continuation)
		{
			UnsafeOnCompleted(continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			Error.ThrowWhenContinuationIsAlreadyRegistered(continuationAction);
			continuationAction = PooledDelegate<AsyncOperation>.Create(continuation);
			((AsyncOperation)(object)asyncOperation).completed += continuationAction;
		}
	}

	private sealed class UnityWebRequestAsyncOperationConfiguredSource : IUniTaskSource<UnityWebRequest>, IUniTaskSource, IPlayerLoopItem, ITaskPoolNode<UnityWebRequestAsyncOperationConfiguredSource>
	{
		private static TaskPool<UnityWebRequestAsyncOperationConfiguredSource> pool;

		private UnityWebRequestAsyncOperationConfiguredSource nextNode;

		private UnityWebRequestAsyncOperation asyncOperation;

		private IProgress<float> progress;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private bool completed;

		private UniTaskCompletionSourceCore<UnityWebRequest> core;

		private Action<AsyncOperation> continuationAction;

		public ref UnityWebRequestAsyncOperationConfiguredSource NextNode => ref nextNode;

		static UnityWebRequestAsyncOperationConfiguredSource()
		{
			TaskPool.RegisterSizeGetter(typeof(UnityWebRequestAsyncOperationConfiguredSource), () => pool.Size);
		}

		private UnityWebRequestAsyncOperationConfiguredSource()
		{
			continuationAction = Continuation;
		}

		public static IUniTaskSource<UnityWebRequest> Create(UnityWebRequestAsyncOperation asyncOperation, PlayerLoopTiming timing, IProgress<float> progress, CancellationToken cancellationToken, bool cancelImmediately, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource<UnityWebRequest>.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new UnityWebRequestAsyncOperationConfiguredSource();
			}
			result.asyncOperation = asyncOperation;
			result.progress = progress;
			result.cancellationToken = cancellationToken;
			result.completed = false;
			((AsyncOperation)(object)asyncOperation).completed += result.continuationAction;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
				{
					UnityWebRequestAsyncOperationConfiguredSource unityWebRequestAsyncOperationConfiguredSource = (UnityWebRequestAsyncOperationConfiguredSource)state;
					unityWebRequestAsyncOperationConfiguredSource.asyncOperation.webRequest.Abort();
					unityWebRequestAsyncOperationConfiguredSource.core.TrySetCanceled(unityWebRequestAsyncOperationConfiguredSource.cancellationToken);
				}, result);
			}
			PlayerLoopHelper.AddAction(timing, result);
			token = result.core.Version;
			return result;
		}

		public UnityWebRequest GetResult(short token)
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
			if (completed || asyncOperation == null)
			{
				return false;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				asyncOperation.webRequest.Abort();
				core.TrySetCanceled(cancellationToken);
				return false;
			}
			if (progress != null)
			{
				progress.Report(((AsyncOperation)(object)asyncOperation).progress);
			}
			if (((AsyncOperation)(object)asyncOperation).isDone)
			{
				if (asyncOperation.webRequest.IsError())
				{
					core.TrySetException(new UnityWebRequestException(asyncOperation.webRequest));
				}
				else
				{
					core.TrySetResult(asyncOperation.webRequest);
				}
				return false;
			}
			return true;
		}

		private bool TryReturn()
		{
			core.Reset();
			((AsyncOperation)(object)asyncOperation).completed -= continuationAction;
			asyncOperation = null;
			progress = null;
			cancellationToken = default(CancellationToken);
			cancellationTokenRegistration.Dispose();
			return pool.TryPush(this);
		}

		private void Continuation(AsyncOperation _)
		{
			if (completed)
			{
				TryReturn();
				return;
			}
			completed = true;
			if (cancellationToken.IsCancellationRequested)
			{
				core.TrySetCanceled(cancellationToken);
			}
			else if (asyncOperation.webRequest.IsError())
			{
				core.TrySetException(new UnityWebRequestException(asyncOperation.webRequest));
			}
			else
			{
				core.TrySetResult(asyncOperation.webRequest);
			}
		}
	}

	private sealed class JobHandlePromise : IUniTaskSource, IPlayerLoopItem
	{
		private JobHandle jobHandle;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		public static JobHandlePromise Create(JobHandle jobHandle, out short token)
		{
			JobHandlePromise jobHandlePromise = new JobHandlePromise();
			jobHandlePromise.jobHandle = jobHandle;
			token = jobHandlePromise.core.Version;
			return jobHandlePromise;
		}

		public void GetResult(short token)
		{
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

		public bool MoveNext()
		{
			if (jobHandle.IsCompleted | PlayerLoopHelper.IsEditorApplicationQuitting)
			{
				jobHandle.Complete();
				core.TrySetResult(AsyncUnit.Default);
				return false;
			}
			return true;
		}
	}

	public static AssetBundleRequestAllAssetsAwaiter AwaitForAllAssets(this AssetBundleRequest asyncOperation)
	{
		Error.ThrowArgumentNullException<AssetBundleRequest>(asyncOperation, "asyncOperation");
		return new AssetBundleRequestAllAssetsAwaiter(asyncOperation);
	}

	public static UniTask<UnityEngine.Object[]> AwaitForAllAssets(this AssetBundleRequest asyncOperation, CancellationToken cancellationToken)
	{
		return asyncOperation.AwaitForAllAssets(null, PlayerLoopTiming.Update, cancellationToken);
	}

	public static UniTask<UnityEngine.Object[]> AwaitForAllAssets(this AssetBundleRequest asyncOperation, CancellationToken cancellationToken, bool cancelImmediately)
	{
		return asyncOperation.AwaitForAllAssets(null, PlayerLoopTiming.Update, cancellationToken, cancelImmediately);
	}

	public static UniTask<UnityEngine.Object[]> AwaitForAllAssets(this AssetBundleRequest asyncOperation, IProgress<float> progress = null, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		Error.ThrowArgumentNullException<AssetBundleRequest>(asyncOperation, "asyncOperation");
		if (cancellationToken.IsCancellationRequested)
		{
			return UniTask.FromCanceled<UnityEngine.Object[]>(cancellationToken);
		}
		if (((AsyncOperation)(object)asyncOperation).isDone)
		{
			return UniTask.FromResult(asyncOperation.allAssets);
		}
		short token;
		return new UniTask<UnityEngine.Object[]>(AssetBundleRequestAllAssetsConfiguredSource.Create(asyncOperation, timing, progress, cancellationToken, cancelImmediately, out token), token);
	}

	public static UniTask<AsyncGPUReadbackRequest>.Awaiter GetAwaiter(this AsyncGPUReadbackRequest asyncOperation)
	{
		return asyncOperation.ToUniTask().GetAwaiter();
	}

	public static UniTask<AsyncGPUReadbackRequest> WithCancellation(this AsyncGPUReadbackRequest asyncOperation, CancellationToken cancellationToken)
	{
		return asyncOperation.ToUniTask(PlayerLoopTiming.Update, cancellationToken);
	}

	public static UniTask<AsyncGPUReadbackRequest> WithCancellation(this AsyncGPUReadbackRequest asyncOperation, CancellationToken cancellationToken, bool cancelImmediately)
	{
		return asyncOperation.ToUniTask(PlayerLoopTiming.Update, cancellationToken, cancelImmediately);
	}

	public static UniTask<AsyncGPUReadbackRequest> ToUniTask(this AsyncGPUReadbackRequest asyncOperation, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		if (asyncOperation.done)
		{
			return UniTask.FromResult(asyncOperation);
		}
		short token;
		return new UniTask<AsyncGPUReadbackRequest>(AsyncGPUReadbackRequestAwaiterConfiguredSource.Create(asyncOperation, timing, cancellationToken, cancelImmediately, out token), token);
	}

	public static AsyncOperationAwaiter GetAwaiter(this AsyncOperation asyncOperation)
	{
		Error.ThrowArgumentNullException(asyncOperation, "asyncOperation");
		return new AsyncOperationAwaiter(asyncOperation);
	}

	public static UniTask WithCancellation(this AsyncOperation asyncOperation, CancellationToken cancellationToken)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken);
	}

	public static UniTask WithCancellation(this AsyncOperation asyncOperation, CancellationToken cancellationToken, bool cancelImmediately)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken, cancelImmediately);
	}

	public static UniTask ToUniTask(this AsyncOperation asyncOperation, IProgress<float> progress = null, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		Error.ThrowArgumentNullException(asyncOperation, "asyncOperation");
		if (cancellationToken.IsCancellationRequested)
		{
			return UniTask.FromCanceled(cancellationToken);
		}
		if (asyncOperation.isDone)
		{
			return UniTask.CompletedTask;
		}
		short token;
		return new UniTask(AsyncOperationConfiguredSource.Create(asyncOperation, timing, progress, cancellationToken, cancelImmediately, out token), token);
	}

	public static ResourceRequestAwaiter GetAwaiter(this ResourceRequest asyncOperation)
	{
		Error.ThrowArgumentNullException(asyncOperation, "asyncOperation");
		return new ResourceRequestAwaiter(asyncOperation);
	}

	public static UniTask<UnityEngine.Object> WithCancellation(this ResourceRequest asyncOperation, CancellationToken cancellationToken)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken);
	}

	public static UniTask<UnityEngine.Object> WithCancellation(this ResourceRequest asyncOperation, CancellationToken cancellationToken, bool cancelImmediately)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken, cancelImmediately);
	}

	public static UniTask<UnityEngine.Object> ToUniTask(this ResourceRequest asyncOperation, IProgress<float> progress = null, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		Error.ThrowArgumentNullException(asyncOperation, "asyncOperation");
		if (cancellationToken.IsCancellationRequested)
		{
			return UniTask.FromCanceled<UnityEngine.Object>(cancellationToken);
		}
		if (asyncOperation.isDone)
		{
			return UniTask.FromResult(asyncOperation.asset);
		}
		short token;
		return new UniTask<UnityEngine.Object>(ResourceRequestConfiguredSource.Create(asyncOperation, timing, progress, cancellationToken, cancelImmediately, out token), token);
	}

	public static AssetBundleRequestAwaiter GetAwaiter(this AssetBundleRequest asyncOperation)
	{
		Error.ThrowArgumentNullException<AssetBundleRequest>(asyncOperation, "asyncOperation");
		return new AssetBundleRequestAwaiter(asyncOperation);
	}

	public static UniTask<UnityEngine.Object> WithCancellation(this AssetBundleRequest asyncOperation, CancellationToken cancellationToken)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken);
	}

	public static UniTask<UnityEngine.Object> WithCancellation(this AssetBundleRequest asyncOperation, CancellationToken cancellationToken, bool cancelImmediately)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken, cancelImmediately);
	}

	public static UniTask<UnityEngine.Object> ToUniTask(this AssetBundleRequest asyncOperation, IProgress<float> progress = null, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		Error.ThrowArgumentNullException<AssetBundleRequest>(asyncOperation, "asyncOperation");
		if (cancellationToken.IsCancellationRequested)
		{
			return UniTask.FromCanceled<UnityEngine.Object>(cancellationToken);
		}
		if (((AsyncOperation)(object)asyncOperation).isDone)
		{
			return UniTask.FromResult(asyncOperation.asset);
		}
		short token;
		return new UniTask<UnityEngine.Object>(AssetBundleRequestConfiguredSource.Create(asyncOperation, timing, progress, cancellationToken, cancelImmediately, out token), token);
	}

	public static AssetBundleCreateRequestAwaiter GetAwaiter(this AssetBundleCreateRequest asyncOperation)
	{
		Error.ThrowArgumentNullException<AssetBundleCreateRequest>(asyncOperation, "asyncOperation");
		return new AssetBundleCreateRequestAwaiter(asyncOperation);
	}

	public static UniTask<AssetBundle> WithCancellation(this AssetBundleCreateRequest asyncOperation, CancellationToken cancellationToken)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken);
	}

	public static UniTask<AssetBundle> WithCancellation(this AssetBundleCreateRequest asyncOperation, CancellationToken cancellationToken, bool cancelImmediately)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken, cancelImmediately);
	}

	public static UniTask<AssetBundle> ToUniTask(this AssetBundleCreateRequest asyncOperation, IProgress<float> progress = null, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		Error.ThrowArgumentNullException<AssetBundleCreateRequest>(asyncOperation, "asyncOperation");
		if (cancellationToken.IsCancellationRequested)
		{
			return UniTask.FromCanceled<AssetBundle>(cancellationToken);
		}
		if (((AsyncOperation)(object)asyncOperation).isDone)
		{
			return UniTask.FromResult<AssetBundle>(asyncOperation.assetBundle);
		}
		short token;
		return new UniTask<AssetBundle>(AssetBundleCreateRequestConfiguredSource.Create(asyncOperation, timing, progress, cancellationToken, cancelImmediately, out token), token);
	}

	public static UnityWebRequestAsyncOperationAwaiter GetAwaiter(this UnityWebRequestAsyncOperation asyncOperation)
	{
		Error.ThrowArgumentNullException<UnityWebRequestAsyncOperation>(asyncOperation, "asyncOperation");
		return new UnityWebRequestAsyncOperationAwaiter(asyncOperation);
	}

	public static UniTask<UnityWebRequest> WithCancellation(this UnityWebRequestAsyncOperation asyncOperation, CancellationToken cancellationToken)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken);
	}

	public static UniTask<UnityWebRequest> WithCancellation(this UnityWebRequestAsyncOperation asyncOperation, CancellationToken cancellationToken, bool cancelImmediately)
	{
		return asyncOperation.ToUniTask(null, PlayerLoopTiming.Update, cancellationToken, cancelImmediately);
	}

	public static UniTask<UnityWebRequest> ToUniTask(this UnityWebRequestAsyncOperation asyncOperation, IProgress<float> progress = null, PlayerLoopTiming timing = PlayerLoopTiming.Update, CancellationToken cancellationToken = default(CancellationToken), bool cancelImmediately = false)
	{
		Error.ThrowArgumentNullException<UnityWebRequestAsyncOperation>(asyncOperation, "asyncOperation");
		if (cancellationToken.IsCancellationRequested)
		{
			return UniTask.FromCanceled<UnityWebRequest>(cancellationToken);
		}
		if (((AsyncOperation)(object)asyncOperation).isDone)
		{
			if (asyncOperation.webRequest.IsError())
			{
				return UniTask.FromException<UnityWebRequest>(new UnityWebRequestException(asyncOperation.webRequest));
			}
			return UniTask.FromResult<UnityWebRequest>(asyncOperation.webRequest);
		}
		short token;
		return new UniTask<UnityWebRequest>(UnityWebRequestAsyncOperationConfiguredSource.Create(asyncOperation, timing, progress, cancellationToken, cancelImmediately, out token), token);
	}

	public static async UniTask WaitAsync(this JobHandle jobHandle, PlayerLoopTiming waitTiming, CancellationToken cancellationToken = default(CancellationToken))
	{
		await UniTask.Yield(waitTiming);
		jobHandle.Complete();
		cancellationToken.ThrowIfCancellationRequested();
	}

	public static UniTask.Awaiter GetAwaiter(this JobHandle jobHandle)
	{
		JobHandlePromise jobHandlePromise = JobHandlePromise.Create(jobHandle, out var token);
		PlayerLoopHelper.AddAction(PlayerLoopTiming.EarlyUpdate, jobHandlePromise);
		PlayerLoopHelper.AddAction(PlayerLoopTiming.PreUpdate, jobHandlePromise);
		PlayerLoopHelper.AddAction(PlayerLoopTiming.Update, jobHandlePromise);
		PlayerLoopHelper.AddAction(PlayerLoopTiming.PreLateUpdate, jobHandlePromise);
		PlayerLoopHelper.AddAction(PlayerLoopTiming.PostLateUpdate, jobHandlePromise);
		return new UniTask(jobHandlePromise, token).GetAwaiter();
	}

	public static UniTask ToUniTask(this JobHandle jobHandle, PlayerLoopTiming waitTiming)
	{
		JobHandlePromise jobHandlePromise = JobHandlePromise.Create(jobHandle, out var token);
		PlayerLoopHelper.AddAction(waitTiming, jobHandlePromise);
		return new UniTask(jobHandlePromise, token);
	}

	public static UniTask StartAsyncCoroutine(this MonoBehaviour monoBehaviour, Func<CancellationToken, UniTask> asyncCoroutine)
	{
		CancellationToken cancellationTokenOnDestroy = monoBehaviour.GetCancellationTokenOnDestroy();
		return asyncCoroutine(cancellationTokenOnDestroy);
	}

	public static AsyncUnityEventHandler GetAsyncEventHandler(this UnityEvent unityEvent, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler(unityEvent, cancellationToken, callOnce: false);
	}

	public static UniTask OnInvokeAsync(this UnityEvent unityEvent, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler(unityEvent, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<AsyncUnit> OnInvokeAsAsyncEnumerable(this UnityEvent unityEvent, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable(unityEvent, cancellationToken);
	}

	public static AsyncUnityEventHandler<T> GetAsyncEventHandler<T>(this UnityEvent<T> unityEvent, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<T>(unityEvent, cancellationToken, callOnce: false);
	}

	public static UniTask<T> OnInvokeAsync<T>(this UnityEvent<T> unityEvent, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<T>(unityEvent, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<T> OnInvokeAsAsyncEnumerable<T>(this UnityEvent<T> unityEvent, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable<T>(unityEvent, cancellationToken);
	}

	public static IAsyncClickEventHandler GetAsyncClickEventHandler(this Button button)
	{
		return new AsyncUnityEventHandler(button.onClick, button.GetCancellationTokenOnDestroy(), callOnce: false);
	}

	public static IAsyncClickEventHandler GetAsyncClickEventHandler(this Button button, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler(button.onClick, cancellationToken, callOnce: false);
	}

	public static UniTask OnClickAsync(this Button button)
	{
		return new AsyncUnityEventHandler(button.onClick, button.GetCancellationTokenOnDestroy(), callOnce: true).OnInvokeAsync();
	}

	public static UniTask OnClickAsync(this Button button, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler(button.onClick, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<AsyncUnit> OnClickAsAsyncEnumerable(this Button button)
	{
		return new UnityEventHandlerAsyncEnumerable(button.onClick, button.GetCancellationTokenOnDestroy());
	}

	public static IUniTaskAsyncEnumerable<AsyncUnit> OnClickAsAsyncEnumerable(this Button button, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable(button.onClick, cancellationToken);
	}

	public static IAsyncValueChangedEventHandler<bool> GetAsyncValueChangedEventHandler(this Toggle toggle)
	{
		return new AsyncUnityEventHandler<bool>(toggle.onValueChanged, toggle.GetCancellationTokenOnDestroy(), callOnce: false);
	}

	public static IAsyncValueChangedEventHandler<bool> GetAsyncValueChangedEventHandler(this Toggle toggle, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<bool>(toggle.onValueChanged, cancellationToken, callOnce: false);
	}

	public static UniTask<bool> OnValueChangedAsync(this Toggle toggle)
	{
		return new AsyncUnityEventHandler<bool>(toggle.onValueChanged, toggle.GetCancellationTokenOnDestroy(), callOnce: true).OnInvokeAsync();
	}

	public static UniTask<bool> OnValueChangedAsync(this Toggle toggle, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<bool>(toggle.onValueChanged, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<bool> OnValueChangedAsAsyncEnumerable(this Toggle toggle)
	{
		return new UnityEventHandlerAsyncEnumerable<bool>(toggle.onValueChanged, toggle.GetCancellationTokenOnDestroy());
	}

	public static IUniTaskAsyncEnumerable<bool> OnValueChangedAsAsyncEnumerable(this Toggle toggle, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable<bool>(toggle.onValueChanged, cancellationToken);
	}

	public static IAsyncValueChangedEventHandler<float> GetAsyncValueChangedEventHandler(this Scrollbar scrollbar)
	{
		return new AsyncUnityEventHandler<float>(scrollbar.onValueChanged, scrollbar.GetCancellationTokenOnDestroy(), callOnce: false);
	}

	public static IAsyncValueChangedEventHandler<float> GetAsyncValueChangedEventHandler(this Scrollbar scrollbar, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<float>(scrollbar.onValueChanged, cancellationToken, callOnce: false);
	}

	public static UniTask<float> OnValueChangedAsync(this Scrollbar scrollbar)
	{
		return new AsyncUnityEventHandler<float>(scrollbar.onValueChanged, scrollbar.GetCancellationTokenOnDestroy(), callOnce: true).OnInvokeAsync();
	}

	public static UniTask<float> OnValueChangedAsync(this Scrollbar scrollbar, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<float>(scrollbar.onValueChanged, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<float> OnValueChangedAsAsyncEnumerable(this Scrollbar scrollbar)
	{
		return new UnityEventHandlerAsyncEnumerable<float>(scrollbar.onValueChanged, scrollbar.GetCancellationTokenOnDestroy());
	}

	public static IUniTaskAsyncEnumerable<float> OnValueChangedAsAsyncEnumerable(this Scrollbar scrollbar, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable<float>(scrollbar.onValueChanged, cancellationToken);
	}

	public static IAsyncValueChangedEventHandler<Vector2> GetAsyncValueChangedEventHandler(this ScrollRect scrollRect)
	{
		return new AsyncUnityEventHandler<Vector2>(scrollRect.onValueChanged, scrollRect.GetCancellationTokenOnDestroy(), callOnce: false);
	}

	public static IAsyncValueChangedEventHandler<Vector2> GetAsyncValueChangedEventHandler(this ScrollRect scrollRect, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<Vector2>(scrollRect.onValueChanged, cancellationToken, callOnce: false);
	}

	public static UniTask<Vector2> OnValueChangedAsync(this ScrollRect scrollRect)
	{
		return new AsyncUnityEventHandler<Vector2>(scrollRect.onValueChanged, scrollRect.GetCancellationTokenOnDestroy(), callOnce: true).OnInvokeAsync();
	}

	public static UniTask<Vector2> OnValueChangedAsync(this ScrollRect scrollRect, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<Vector2>(scrollRect.onValueChanged, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<Vector2> OnValueChangedAsAsyncEnumerable(this ScrollRect scrollRect)
	{
		return new UnityEventHandlerAsyncEnumerable<Vector2>(scrollRect.onValueChanged, scrollRect.GetCancellationTokenOnDestroy());
	}

	public static IUniTaskAsyncEnumerable<Vector2> OnValueChangedAsAsyncEnumerable(this ScrollRect scrollRect, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable<Vector2>(scrollRect.onValueChanged, cancellationToken);
	}

	public static IAsyncValueChangedEventHandler<float> GetAsyncValueChangedEventHandler(this Slider slider)
	{
		return new AsyncUnityEventHandler<float>(slider.onValueChanged, slider.GetCancellationTokenOnDestroy(), callOnce: false);
	}

	public static IAsyncValueChangedEventHandler<float> GetAsyncValueChangedEventHandler(this Slider slider, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<float>(slider.onValueChanged, cancellationToken, callOnce: false);
	}

	public static UniTask<float> OnValueChangedAsync(this Slider slider)
	{
		return new AsyncUnityEventHandler<float>(slider.onValueChanged, slider.GetCancellationTokenOnDestroy(), callOnce: true).OnInvokeAsync();
	}

	public static UniTask<float> OnValueChangedAsync(this Slider slider, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<float>(slider.onValueChanged, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<float> OnValueChangedAsAsyncEnumerable(this Slider slider)
	{
		return new UnityEventHandlerAsyncEnumerable<float>(slider.onValueChanged, slider.GetCancellationTokenOnDestroy());
	}

	public static IUniTaskAsyncEnumerable<float> OnValueChangedAsAsyncEnumerable(this Slider slider, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable<float>(slider.onValueChanged, cancellationToken);
	}

	public static IAsyncEndEditEventHandler<string> GetAsyncEndEditEventHandler(this InputField inputField)
	{
		return new AsyncUnityEventHandler<string>(inputField.onEndEdit, inputField.GetCancellationTokenOnDestroy(), callOnce: false);
	}

	public static IAsyncEndEditEventHandler<string> GetAsyncEndEditEventHandler(this InputField inputField, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<string>(inputField.onEndEdit, cancellationToken, callOnce: false);
	}

	public static UniTask<string> OnEndEditAsync(this InputField inputField)
	{
		return new AsyncUnityEventHandler<string>(inputField.onEndEdit, inputField.GetCancellationTokenOnDestroy(), callOnce: true).OnInvokeAsync();
	}

	public static UniTask<string> OnEndEditAsync(this InputField inputField, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<string>(inputField.onEndEdit, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<string> OnEndEditAsAsyncEnumerable(this InputField inputField)
	{
		return new UnityEventHandlerAsyncEnumerable<string>(inputField.onEndEdit, inputField.GetCancellationTokenOnDestroy());
	}

	public static IUniTaskAsyncEnumerable<string> OnEndEditAsAsyncEnumerable(this InputField inputField, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable<string>(inputField.onEndEdit, cancellationToken);
	}

	public static IAsyncValueChangedEventHandler<string> GetAsyncValueChangedEventHandler(this InputField inputField)
	{
		return new AsyncUnityEventHandler<string>(inputField.onValueChanged, inputField.GetCancellationTokenOnDestroy(), callOnce: false);
	}

	public static IAsyncValueChangedEventHandler<string> GetAsyncValueChangedEventHandler(this InputField inputField, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<string>(inputField.onValueChanged, cancellationToken, callOnce: false);
	}

	public static UniTask<string> OnValueChangedAsync(this InputField inputField)
	{
		return new AsyncUnityEventHandler<string>(inputField.onValueChanged, inputField.GetCancellationTokenOnDestroy(), callOnce: true).OnInvokeAsync();
	}

	public static UniTask<string> OnValueChangedAsync(this InputField inputField, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<string>(inputField.onValueChanged, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<string> OnValueChangedAsAsyncEnumerable(this InputField inputField)
	{
		return new UnityEventHandlerAsyncEnumerable<string>(inputField.onValueChanged, inputField.GetCancellationTokenOnDestroy());
	}

	public static IUniTaskAsyncEnumerable<string> OnValueChangedAsAsyncEnumerable(this InputField inputField, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable<string>(inputField.onValueChanged, cancellationToken);
	}

	public static IAsyncValueChangedEventHandler<int> GetAsyncValueChangedEventHandler(this Dropdown dropdown)
	{
		return new AsyncUnityEventHandler<int>(dropdown.onValueChanged, dropdown.GetCancellationTokenOnDestroy(), callOnce: false);
	}

	public static IAsyncValueChangedEventHandler<int> GetAsyncValueChangedEventHandler(this Dropdown dropdown, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<int>(dropdown.onValueChanged, cancellationToken, callOnce: false);
	}

	public static UniTask<int> OnValueChangedAsync(this Dropdown dropdown)
	{
		return new AsyncUnityEventHandler<int>(dropdown.onValueChanged, dropdown.GetCancellationTokenOnDestroy(), callOnce: true).OnInvokeAsync();
	}

	public static UniTask<int> OnValueChangedAsync(this Dropdown dropdown, CancellationToken cancellationToken)
	{
		return new AsyncUnityEventHandler<int>(dropdown.onValueChanged, cancellationToken, callOnce: true).OnInvokeAsync();
	}

	public static IUniTaskAsyncEnumerable<int> OnValueChangedAsAsyncEnumerable(this Dropdown dropdown)
	{
		return new UnityEventHandlerAsyncEnumerable<int>(dropdown.onValueChanged, dropdown.GetCancellationTokenOnDestroy());
	}

	public static IUniTaskAsyncEnumerable<int> OnValueChangedAsAsyncEnumerable(this Dropdown dropdown, CancellationToken cancellationToken)
	{
		return new UnityEventHandlerAsyncEnumerable<int>(dropdown.onValueChanged, cancellationToken);
	}
}
