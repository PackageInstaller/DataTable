namespace UnityEngine.EventSystems;

public interface IDragHandler : IEventSystemHandler
{
	void OnDrag(PointerEventData eventData);
}
