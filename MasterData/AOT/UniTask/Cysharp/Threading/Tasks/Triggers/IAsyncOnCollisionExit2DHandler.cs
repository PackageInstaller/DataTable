using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnCollisionExit2DHandler
{
	UniTask<Collision2D> OnCollisionExit2DAsync();
}
