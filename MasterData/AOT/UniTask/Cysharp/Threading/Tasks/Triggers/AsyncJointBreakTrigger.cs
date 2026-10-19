using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncJointBreakTrigger : AsyncTriggerBase<float>
{
	private void OnJointBreak(float breakForce)
	{
		RaiseEvent(breakForce);
	}

	public IAsyncOnJointBreakHandler GetOnJointBreakAsyncHandler()
	{
		return new AsyncTriggerHandler<float>(this, callOnce: false);
	}

	public IAsyncOnJointBreakHandler GetOnJointBreakAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<float>(this, cancellationToken, callOnce: false);
	}

	public UniTask<float> OnJointBreakAsync()
	{
		return ((IAsyncOnJointBreakHandler)new AsyncTriggerHandler<float>(this, callOnce: true)).OnJointBreakAsync();
	}

	public UniTask<float> OnJointBreakAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnJointBreakHandler)new AsyncTriggerHandler<float>(this, cancellationToken, callOnce: true)).OnJointBreakAsync();
	}
}
