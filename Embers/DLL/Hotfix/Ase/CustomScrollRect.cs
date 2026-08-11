using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Ase;

public class CustomScrollRect : ScrollRect
{
	public class ScrollDragEvent : UnityEvent<PointerEventData>
	{
	}

	private ScrollDragEvent m_OnBeginDragEvent = new ScrollDragEvent();

	private ScrollDragEvent m_OnDragEvent = new ScrollDragEvent();

	private ScrollDragEvent m_OnEndDragEvent = new ScrollDragEvent();

	public ScrollDragEvent OnBeginDragEvent
	{
		get
		{
			return m_OnBeginDragEvent;
		}
		set
		{
			m_OnBeginDragEvent = value;
		}
	}

	public ScrollDragEvent OnDragEvent
	{
		get
		{
			return m_OnDragEvent;
		}
		set
		{
			m_OnDragEvent = value;
		}
	}

	public ScrollDragEvent OnEndDragEvent
	{
		get
		{
			return m_OnEndDragEvent;
		}
		set
		{
			m_OnEndDragEvent = value;
		}
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		base.OnBeginDrag(eventData);
		m_OnBeginDragEvent?.Invoke(eventData);
	}

	public override void OnDrag(PointerEventData eventData)
	{
		base.OnDrag(eventData);
		m_OnDragEvent?.Invoke(eventData);
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		base.OnEndDrag(eventData);
		m_OnEndDragEvent?.Invoke(eventData);
	}
}
