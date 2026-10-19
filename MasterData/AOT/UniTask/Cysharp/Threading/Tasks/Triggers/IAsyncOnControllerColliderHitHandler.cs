using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnControllerColliderHitHandler
{
	UniTask<ControllerColliderHit> OnControllerColliderHitAsync();
}
