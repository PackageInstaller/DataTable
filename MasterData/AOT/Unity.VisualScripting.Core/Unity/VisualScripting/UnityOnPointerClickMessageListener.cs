using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnPointerClickMessageListener : MessageListener, IPointerClickHandler, IEventSystemHandler
{
	public void OnPointerClick(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerClick", gameObject, eventData);
	}
}
