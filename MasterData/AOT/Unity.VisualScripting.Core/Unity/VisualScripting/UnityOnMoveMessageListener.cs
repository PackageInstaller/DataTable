using UnityEngine;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnMoveMessageListener : MessageListener, IMoveHandler, IEventSystemHandler
{
	public void OnMove(AxisEventData eventData)
	{
		EventBus.Trigger("OnMove", gameObject, eventData);
	}
}
