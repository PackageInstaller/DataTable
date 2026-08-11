using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncParticleCollisionTrigger : AsyncTriggerBase<GameObject>
{
	private void OnParticleCollision(GameObject other)
	{
		RaiseEvent(other);
	}

	public IAsyncOnParticleCollisionHandler GetOnParticleCollisionAsyncHandler()
	{
		return new AsyncTriggerHandler<GameObject>(this, callOnce: false);
	}

	public IAsyncOnParticleCollisionHandler GetOnParticleCollisionAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<GameObject>(this, cancellationToken, callOnce: false);
	}

	public UniTask<GameObject> OnParticleCollisionAsync()
	{
		return ((IAsyncOnParticleCollisionHandler)new AsyncTriggerHandler<GameObject>(this, callOnce: true)).OnParticleCollisionAsync();
	}

	public UniTask<GameObject> OnParticleCollisionAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnParticleCollisionHandler)new AsyncTriggerHandler<GameObject>(this, cancellationToken, callOnce: true)).OnParticleCollisionAsync();
	}
}
