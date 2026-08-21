using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnTriggerExitHandler
{
	UniTask<Collider> OnTriggerExitAsync();
}
