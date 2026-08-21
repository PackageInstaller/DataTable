namespace UnityEngine.EventSystems;

public interface IPointerEnterHandler : IEventSystemHandler
{
	void OnPointerEnter(PointerEventData eventData);
}
