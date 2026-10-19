namespace UnityEngine.EventSystems;

public interface IEndDragHandler : IEventSystemHandler
{
	void OnEndDrag(PointerEventData eventData);
}
