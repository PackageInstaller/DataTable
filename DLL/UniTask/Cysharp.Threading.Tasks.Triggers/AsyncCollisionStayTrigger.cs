using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncCollisionStayTrigger : AsyncTriggerBase<Collision>
{
	private void OnCollisionStay(Collision coll)
	{
		RaiseEvent(coll);
	}

	public IAsyncOnCollisionStayHandler GetOnCollisionStayAsyncHandler()
	{
		return new AsyncTriggerHandler<Collision>(this, callOnce: false);
	}

	public IAsyncOnCollisionStayHandler GetOnCollisionStayAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collision>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collision> OnCollisionStayAsync()
	{
		return ((IAsyncOnCollisionStayHandler)new AsyncTriggerHandler<Collision>(this, callOnce: true)).OnCollisionStayAsync();
	}

	public UniTask<Collision> OnCollisionStayAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnCollisionStayHandler)new AsyncTriggerHandler<Collision>(this, cancellationToken, callOnce: true)).OnCollisionStayAsync();
	}
}
