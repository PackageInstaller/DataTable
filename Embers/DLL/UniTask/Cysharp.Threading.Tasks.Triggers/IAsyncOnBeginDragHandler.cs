using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnBeginDragHandler
{
	UniTask<PointerEventData> OnBeginDragAsync();
}
