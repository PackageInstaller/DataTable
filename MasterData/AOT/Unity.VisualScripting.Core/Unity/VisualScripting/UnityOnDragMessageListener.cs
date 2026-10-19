using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnDragMessageListener : MessageListener, IDragHandler, IEventSystemHandler
{
	public void OnDrag(PointerEventData eventData)
	{
		EventBus.Trigger("OnDrag", gameObject, eventData);
	}
}
