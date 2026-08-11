using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncAnimatorIKTrigger : AsyncTriggerBase<int>
{
	private void OnAnimatorIK(int layerIndex)
	{
		RaiseEvent(layerIndex);
	}

	public IAsyncOnAnimatorIKHandler GetOnAnimatorIKAsyncHandler()
	{
		return new AsyncTriggerHandler<int>(this, callOnce: false);
	}

	public IAsyncOnAnimatorIKHandler GetOnAnimatorIKAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<int>(this, cancellationToken, callOnce: false);
	}

	public UniTask<int> OnAnimatorIKAsync()
	{
		return ((IAsyncOnAnimatorIKHandler)new AsyncTriggerHandler<int>(this, callOnce: true)).OnAnimatorIKAsync();
	}

	public UniTask<int> OnAnimatorIKAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnAnimatorIKHandler)new AsyncTriggerHandler<int>(this, cancellationToken, callOnce: true)).OnAnimatorIKAsync();
	}
}
