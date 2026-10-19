using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnTriggerExit2DHandler
{
	UniTask<Collider2D> OnTriggerExit2DAsync();
}
