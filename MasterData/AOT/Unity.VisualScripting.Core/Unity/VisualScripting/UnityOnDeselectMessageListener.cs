using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnDeselectMessageListener : MessageListener, IDeselectHandler, IEventSystemHandler
{
	public void OnDeselect(BaseEventData eventData)
	{
		EventBus.Trigger("OnDeselect", gameObject, eventData);
	}
}
