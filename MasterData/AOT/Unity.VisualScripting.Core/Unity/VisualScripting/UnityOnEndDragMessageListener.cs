using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnEndDragMessageListener : MessageListener, IEndDragHandler, IEventSystemHandler
{
	public void OnEndDrag(PointerEventData eventData)
	{
		EventBus.Trigger("OnEndDrag", gameObject, eventData);
	}
}
