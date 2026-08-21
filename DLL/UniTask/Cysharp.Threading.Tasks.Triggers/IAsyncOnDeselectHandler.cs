using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnDeselectHandler
{
	UniTask<BaseEventData> OnDeselectAsync();
}
