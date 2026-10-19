using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnUpdateSelectedHandler
{
	UniTask<BaseEventData> OnUpdateSelectedAsync();
}
