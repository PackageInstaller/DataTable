namespace UnityEngine.EventSystems;

public interface IUpdateSelectedHandler : IEventSystemHandler
{
	void OnUpdateSelected(BaseEventData eventData);
}
