using Unity.VisualScripting.Community;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.ViewControl;

[DisallowMultipleComponent]
public class MoveHandlerComponent : MonoBehaviour, IMoveHandler, IEventSystemHandler
{
	[HideInInspector]
	public UnityEvent<BaseEventData> OnMove = new AotUnityEvent<BaseEventData>();

	void IMoveHandler.OnMove(AxisEventData eventData)
	{
		OnMove?.Invoke(eventData);
	}
}
