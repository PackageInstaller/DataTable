using UnityEngine.ParticleSystemJobs;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnParticleUpdateJobScheduledHandler
{
	UniTask<ParticleSystemJobData> OnParticleUpdateJobScheduledAsync();
}
