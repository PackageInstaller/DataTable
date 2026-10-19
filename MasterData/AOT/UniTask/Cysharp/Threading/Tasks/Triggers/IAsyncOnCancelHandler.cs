using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnCancelHandler
{
	UniTask<BaseEventData> OnCancelAsync();
}
