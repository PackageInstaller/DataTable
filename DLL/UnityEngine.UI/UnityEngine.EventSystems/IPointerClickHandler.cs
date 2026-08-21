namespace UnityEngine.EventSystems;

public interface IPointerClickHandler : IEventSystemHandler
{
	void OnPointerClick(PointerEventData eventData);
}
