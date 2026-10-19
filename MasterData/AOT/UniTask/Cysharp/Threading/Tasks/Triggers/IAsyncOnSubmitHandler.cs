using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnSubmitHandler
{
	UniTask<BaseEventData> OnSubmitAsync();
}
