using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.ViewControl;

[DisallowMultipleComponent]
public class SelectHandlerComponent : MonoBehaviour, ISelectHandler, IEventSystemHandler
{
	[HideInInspector]
	public UnityEvent<BaseEventData> OnSelect = new UnityEvent<BaseEventData>();

	void ISelectHandler.OnSelect(BaseEventData eventData)
	{
		OnSelect?.Invoke(eventData);
	}
}
