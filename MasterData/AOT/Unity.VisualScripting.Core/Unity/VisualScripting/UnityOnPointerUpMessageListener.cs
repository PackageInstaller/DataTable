using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnPointerUpMessageListener : MessageListener, IPointerUpHandler, IEventSystemHandler
{
	public void OnPointerUp(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerUp", gameObject, eventData);
	}
}
