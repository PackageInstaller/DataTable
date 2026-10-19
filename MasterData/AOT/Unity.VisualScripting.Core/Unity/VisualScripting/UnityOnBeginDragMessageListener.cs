using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnBeginDragMessageListener : MessageListener, IBeginDragHandler, IEventSystemHandler
{
	public void OnBeginDrag(PointerEventData eventData)
	{
		EventBus.Trigger("OnBeginDrag", gameObject, eventData);
	}
}
