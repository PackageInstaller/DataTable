using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnSelectMessageListener : MessageListener, ISelectHandler, IEventSystemHandler
{
	public void OnSelect(BaseEventData eventData)
	{
		EventBus.Trigger("OnSelect", gameObject, eventData);
	}
}
