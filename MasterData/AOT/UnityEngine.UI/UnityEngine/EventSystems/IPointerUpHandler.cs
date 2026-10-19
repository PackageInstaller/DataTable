namespace UnityEngine.EventSystems;

public interface IPointerUpHandler : IEventSystemHandler
{
	void OnPointerUp(PointerEventData eventData);
}
