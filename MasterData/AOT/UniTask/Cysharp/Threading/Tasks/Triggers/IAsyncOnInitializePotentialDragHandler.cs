using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnInitializePotentialDragHandler
{
	UniTask<PointerEventData> OnInitializePotentialDragAsync();
}
