namespace UnityEngine.EventSystems;

public interface ISelectHandler : IEventSystemHandler
{
	void OnSelect(BaseEventData eventData);
}
