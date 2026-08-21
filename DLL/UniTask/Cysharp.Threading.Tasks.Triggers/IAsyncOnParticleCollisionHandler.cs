using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnParticleCollisionHandler
{
	UniTask<GameObject> OnParticleCollisionAsync();
}
