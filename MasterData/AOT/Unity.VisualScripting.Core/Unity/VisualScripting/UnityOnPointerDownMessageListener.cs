using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnPointerDownMessageListener : MessageListener, IPointerDownHandler, IEventSystemHandler
{
	public void OnPointerDown(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerDown", gameObject, eventData);
	}
}
