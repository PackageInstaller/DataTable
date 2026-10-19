using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnDropMessageListener : MessageListener, IDropHandler, IEventSystemHandler
{
	public void OnDrop(PointerEventData eventData)
	{
		EventBus.Trigger("OnDrop", gameObject, eventData);
	}
}
