namespace UnityEngine.EventSystems;

public interface IDropHandler : IEventSystemHandler
{
	void OnDrop(PointerEventData eventData);
}
