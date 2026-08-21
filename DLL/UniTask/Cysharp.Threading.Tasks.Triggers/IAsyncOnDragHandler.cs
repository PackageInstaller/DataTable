using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnDragHandler
{
	UniTask<PointerEventData> OnDragAsync();
}
