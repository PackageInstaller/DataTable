using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnScrollMessageListener : MessageListener, IScrollHandler, IEventSystemHandler
{
	public void OnScroll(PointerEventData eventData)
	{
		EventBus.Trigger("OnScroll", gameObject, eventData);
	}
}
