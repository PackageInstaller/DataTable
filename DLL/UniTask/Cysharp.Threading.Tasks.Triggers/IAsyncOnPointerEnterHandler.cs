using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnPointerEnterHandler
{
	UniTask<PointerEventData> OnPointerEnterAsync();
}
