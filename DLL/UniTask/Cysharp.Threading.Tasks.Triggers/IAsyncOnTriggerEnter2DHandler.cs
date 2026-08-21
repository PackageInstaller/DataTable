using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnTriggerEnter2DHandler
{
	UniTask<Collider2D> OnTriggerEnter2DAsync();
}
