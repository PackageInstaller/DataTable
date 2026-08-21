using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnTriggerEnterHandler
{
	UniTask<Collider> OnTriggerEnterAsync();
}
