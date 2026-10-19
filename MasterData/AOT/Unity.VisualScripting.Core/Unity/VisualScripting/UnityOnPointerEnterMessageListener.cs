using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnPointerEnterMessageListener : MessageListener, IPointerEnterHandler, IEventSystemHandler
{
	public void OnPointerEnter(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerEnter", gameObject, eventData);
	}
}
