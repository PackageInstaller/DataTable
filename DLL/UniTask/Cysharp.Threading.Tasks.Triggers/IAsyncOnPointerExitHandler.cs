using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnPointerExitHandler
{
	UniTask<PointerEventData> OnPointerExitAsync();
}
