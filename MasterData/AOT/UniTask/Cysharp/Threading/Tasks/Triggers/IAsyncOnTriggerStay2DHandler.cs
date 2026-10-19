using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnTriggerStay2DHandler
{
	UniTask<Collider2D> OnTriggerStay2DAsync();
}
