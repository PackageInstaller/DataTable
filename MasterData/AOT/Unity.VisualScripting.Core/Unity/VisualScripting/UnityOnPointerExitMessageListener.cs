using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnPointerExitMessageListener : MessageListener, IPointerExitHandler, IEventSystemHandler
{
	public void OnPointerExit(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerExit", gameObject, eventData);
	}
}
