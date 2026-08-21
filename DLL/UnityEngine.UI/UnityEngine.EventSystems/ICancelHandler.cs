namespace UnityEngine.EventSystems;

public interface ICancelHandler : IEventSystemHandler
{
	void OnCancel(BaseEventData eventData);
}
