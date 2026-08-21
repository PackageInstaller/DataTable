using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnPointerUpHandler
{
	UniTask<PointerEventData> OnPointerUpAsync();
}
