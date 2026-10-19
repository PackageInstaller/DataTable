using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnCollisionEnter2DHandler
{
	UniTask<Collision2D> OnCollisionEnter2DAsync();
}
