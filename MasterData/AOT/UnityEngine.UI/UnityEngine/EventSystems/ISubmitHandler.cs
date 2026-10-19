namespace UnityEngine.EventSystems;

public interface ISubmitHandler : IEventSystemHandler
{
	void OnSubmit(BaseEventData eventData);
}
