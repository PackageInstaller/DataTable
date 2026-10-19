using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnSelectHandler
{
	UniTask<BaseEventData> OnSelectAsync();
}
