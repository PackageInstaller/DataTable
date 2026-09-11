using UnityEngine.EventSystems;

public class LuaEventClickDownListener : LuaEventEmitter, IPointerDownHandler, IEventSystemHandler
{
	public void OnPointerDown(PointerEventData eventData)
	{
		EmitEvent();
	}
}
