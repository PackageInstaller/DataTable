using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnCollisionExitHandler
{
	UniTask<Collision> OnCollisionExitAsync();
}
