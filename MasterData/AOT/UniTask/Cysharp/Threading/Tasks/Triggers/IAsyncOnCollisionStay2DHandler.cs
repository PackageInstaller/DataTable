using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnCollisionStay2DHandler
{
	UniTask<Collision2D> OnCollisionStay2DAsync();
}
