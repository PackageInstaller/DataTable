using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

public class OnClickDownListener : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	public class ClickedEvent : UnityEvent
	{
	}

	private ClickedEvent m_OnClick = new ClickedEvent();

	public ClickedEvent onValueChanged
	{
		get
		{
			return m_OnClick;
		}
		set
		{
			m_OnClick = value;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (m_OnClick != null)
		{
			m_OnClick.Invoke();
		}
	}
}
