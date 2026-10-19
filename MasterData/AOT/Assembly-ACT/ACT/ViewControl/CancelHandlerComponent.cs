using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.ViewControl;

[DisallowMultipleComponent]
public class CancelHandlerComponent : MonoBehaviour, ICancelHandler, IEventSystemHandler
{
	[HideInInspector]
	public UnityEvent<BaseEventData> OnCancel = new UnityEvent<BaseEventData>();

	void ICancelHandler.OnCancel(BaseEventData eventData)
	{
		OnCancel?.Invoke(eventData);
	}
}
