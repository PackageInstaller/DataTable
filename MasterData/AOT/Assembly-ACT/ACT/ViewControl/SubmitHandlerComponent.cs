using Unity.VisualScripting.Community;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.ViewControl;

public class SubmitHandlerComponent : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	[HideInInspector]
	public UnityEvent<BaseEventData> OnSubmit = new AotUnityEvent<BaseEventData>();

	void ISubmitHandler.OnSubmit(BaseEventData eventData)
	{
		OnSubmit?.Invoke(eventData);
	}
}
