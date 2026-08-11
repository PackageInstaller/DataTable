using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnPointerClickHandler
{
	UniTask<PointerEventData> OnPointerClickAsync();
}
