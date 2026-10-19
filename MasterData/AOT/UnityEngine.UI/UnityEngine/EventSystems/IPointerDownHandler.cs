namespace UnityEngine.EventSystems;

public interface IPointerDownHandler : IEventSystemHandler
{
	void OnPointerDown(PointerEventData eventData);
}
