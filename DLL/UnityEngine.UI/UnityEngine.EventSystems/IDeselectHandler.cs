namespace UnityEngine.EventSystems;

public interface IDeselectHandler : IEventSystemHandler
{
	void OnDeselect(BaseEventData eventData);
}
