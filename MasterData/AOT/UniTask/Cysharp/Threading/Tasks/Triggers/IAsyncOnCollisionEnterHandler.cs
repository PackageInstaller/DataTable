using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnCollisionEnterHandler
{
	UniTask<Collision> OnCollisionEnterAsync();
}
