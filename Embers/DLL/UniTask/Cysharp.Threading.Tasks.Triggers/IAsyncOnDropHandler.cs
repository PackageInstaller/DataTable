using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnDropHandler
{
	UniTask<PointerEventData> OnDropAsync();
}
