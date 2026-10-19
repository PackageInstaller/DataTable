using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.ViewControl;

[DisallowMultipleComponent]
public class DeselectHandlerComponent : MonoBehaviour, IDeselectHandler, IEventSystemHandler
{
	[HideInInspector]
	public UnityEvent<BaseEventData> OnDeselect = new UnityEvent<BaseEventData>();

	void IDeselectHandler.OnDeselect(BaseEventData eventData)
	{
		OnDeselect?.Invoke(eventData);
	}
}
