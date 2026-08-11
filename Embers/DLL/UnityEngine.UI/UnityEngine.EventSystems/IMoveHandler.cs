namespace UnityEngine.EventSystems;

public interface IMoveHandler : IEventSystemHandler
{
	void OnMove(AxisEventData eventData);
}
