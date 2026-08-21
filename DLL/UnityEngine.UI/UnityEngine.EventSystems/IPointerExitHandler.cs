namespace UnityEngine.EventSystems;

public interface IPointerExitHandler : IEventSystemHandler
{
	void OnPointerExit(PointerEventData eventData);
}
