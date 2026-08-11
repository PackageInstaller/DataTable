namespace UnityEngine.EventSystems;

public interface IInitializePotentialDragHandler : IEventSystemHandler
{
	void OnInitializePotentialDrag(PointerEventData eventData);
}
