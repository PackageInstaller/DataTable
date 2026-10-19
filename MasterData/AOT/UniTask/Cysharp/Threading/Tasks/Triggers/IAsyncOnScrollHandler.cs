using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnScrollHandler
{
	UniTask<PointerEventData> OnScrollAsync();
}
