using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnSubmitMessageListener : MessageListener, ISubmitHandler, IEventSystemHandler
{
	public void OnSubmit(BaseEventData eventData)
	{
		EventBus.Trigger("OnSubmit", gameObject, eventData);
	}
}
