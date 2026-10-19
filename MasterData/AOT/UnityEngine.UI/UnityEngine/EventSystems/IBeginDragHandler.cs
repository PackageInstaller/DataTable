namespace UnityEngine.EventSystems;

public interface IBeginDragHandler : IEventSystemHandler
{
	void OnBeginDrag(PointerEventData eventData);
}
