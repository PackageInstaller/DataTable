using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncDestroyTrigger : MonoBehaviour
{
	private class AwakeMonitor : IPlayerLoopItem
	{
		private readonly AsyncDestroyTrigger trigger;

		public AwakeMonitor(AsyncDestroyTrigger trigger)
		{
			this.trigger = trigger;
		}

		public bool MoveNext()
		{
			if (trigger.called || trigger.awakeCalled)
			{
				return false;
			}
			if (trigger == null)
			{
				trigger.OnDestroy();
				return false;
			}
			return true;
		}
	}

	private bool awakeCalled;

	private bool called;

	private CancellationTokenSource cancellationTokenSource;

	public CancellationToken CancellationToken
	{
		get
		{
			if (cancellationTokenSource == null)
			{
				cancellationTokenSource = new CancellationTokenSource();
				if (!awakeCalled)
				{
					PlayerLoopHelper.AddAction(PlayerLoopTiming.Update, new AwakeMonitor(this));
				}
			}
			return cancellationTokenSource.Token;
		}
	}

	private void Awake()
	{
		awakeCalled = true;
	}

	private void OnDestroy()
	{
		called = true;
		cancellationTokenSource?.Cancel();
		cancellationTokenSource?.Dispose();
	}

	public UniTask OnDestroyAsync()
	{
		if (called)
		{
			return UniTask.CompletedTask;
		}
		UniTaskCompletionSource uniTaskCompletionSource = new UniTaskCompletionSource();
		CancellationToken.RegisterWithoutCaptureExecutionContext(delegate(object state)
		{
			((UniTaskCompletionSource)state).TrySetResult();
		}, uniTaskCompletionSource);
		return uniTaskCompletionSource.Task;
	}
}
