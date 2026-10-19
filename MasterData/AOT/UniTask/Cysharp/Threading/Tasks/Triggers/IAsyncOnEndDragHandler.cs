using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnEndDragHandler
{
	UniTask<PointerEventData> OnEndDragAsync();
}
