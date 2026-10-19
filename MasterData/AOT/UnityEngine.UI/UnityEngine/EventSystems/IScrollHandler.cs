namespace UnityEngine.EventSystems;

public interface IScrollHandler : IEventSystemHandler
{
	void OnScroll(PointerEventData eventData);
}
