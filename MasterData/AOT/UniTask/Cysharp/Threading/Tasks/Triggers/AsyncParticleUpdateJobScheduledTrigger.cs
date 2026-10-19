using System.Threading;
using UnityEngine;
using UnityEngine.ParticleSystemJobs;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncParticleUpdateJobScheduledTrigger : AsyncTriggerBase<ParticleSystemJobData>
{
	private void OnParticleUpdateJobScheduled(ParticleSystemJobData particles)
	{
		RaiseEvent(particles);
	}

	public IAsyncOnParticleUpdateJobScheduledHandler GetOnParticleUpdateJobScheduledAsyncHandler()
	{
		return new AsyncTriggerHandler<ParticleSystemJobData>(this, callOnce: false);
	}

	public IAsyncOnParticleUpdateJobScheduledHandler GetOnParticleUpdateJobScheduledAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<ParticleSystemJobData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<ParticleSystemJobData> OnParticleUpdateJobScheduledAsync()
	{
		return ((IAsyncOnParticleUpdateJobScheduledHandler)new AsyncTriggerHandler<ParticleSystemJobData>(this, callOnce: true)).OnParticleUpdateJobScheduledAsync();
	}

	public UniTask<ParticleSystemJobData> OnParticleUpdateJobScheduledAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnParticleUpdateJobScheduledHandler)new AsyncTriggerHandler<ParticleSystemJobData>(this, cancellationToken, callOnce: true)).OnParticleUpdateJobScheduledAsync();
	}
}
