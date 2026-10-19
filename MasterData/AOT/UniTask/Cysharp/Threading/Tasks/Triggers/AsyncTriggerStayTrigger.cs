using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncTriggerStayTrigger : AsyncTriggerBase<Collider>
{
	private void OnTriggerStay(Collider other)
	{
		RaiseEvent(other);
	}

	public IAsyncOnTriggerStayHandler GetOnTriggerStayAsyncHandler()
	{
		return new AsyncTriggerHandler<Collider>(this, callOnce: false);
	}

	public IAsyncOnTriggerStayHandler GetOnTriggerStayAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collider>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collider> OnTriggerStayAsync()
	{
		return ((IAsyncOnTriggerStayHandler)new AsyncTriggerHandler<Collider>(this, callOnce: true)).OnTriggerStayAsync();
	}

	public UniTask<Collider> OnTriggerStayAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnTriggerStayHandler)new AsyncTriggerHandler<Collider>(this, cancellationToken, callOnce: true)).OnTriggerStayAsync();
	}
}
