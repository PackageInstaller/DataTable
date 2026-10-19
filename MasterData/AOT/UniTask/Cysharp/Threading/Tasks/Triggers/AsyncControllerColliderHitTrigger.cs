using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncControllerColliderHitTrigger : AsyncTriggerBase<ControllerColliderHit>
{
	private void OnControllerColliderHit(ControllerColliderHit hit)
	{
		RaiseEvent(hit);
	}

	public IAsyncOnControllerColliderHitHandler GetOnControllerColliderHitAsyncHandler()
	{
		return new AsyncTriggerHandler<ControllerColliderHit>(this, callOnce: false);
	}

	public IAsyncOnControllerColliderHitHandler GetOnControllerColliderHitAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<ControllerColliderHit>(this, cancellationToken, callOnce: false);
	}

	public UniTask<ControllerColliderHit> OnControllerColliderHitAsync()
	{
		return ((IAsyncOnControllerColliderHitHandler)new AsyncTriggerHandler<ControllerColliderHit>(this, callOnce: true)).OnControllerColliderHitAsync();
	}

	public UniTask<ControllerColliderHit> OnControllerColliderHitAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnControllerColliderHitHandler)new AsyncTriggerHandler<ControllerColliderHit>(this, cancellationToken, callOnce: true)).OnControllerColliderHitAsync();
	}
}
