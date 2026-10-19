using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnPointerDownHandler
{
	UniTask<PointerEventData> OnPointerDownAsync();
}
