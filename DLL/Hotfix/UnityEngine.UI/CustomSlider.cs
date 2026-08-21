using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace UnityEngine.UI;

public class CustomSlider : Slider
{
	public class SliderDragEvent : UnityEvent<PointerEventData>
	{
	}

	private SliderDragEvent m_OnSliderDragEvent = new SliderDragEvent();

	private SliderDragEvent m_OnPointerDownEvent = new SliderDragEvent();

	private SliderDragEvent m_OnPointerUpEvent = new SliderDragEvent();

	public SliderDragEvent OnSliderDragEvent
	{
		get
		{
			return m_OnSliderDragEvent;
		}
		set
		{
			m_OnSliderDragEvent = value;
		}
	}

	public SliderDragEvent OnPointerDownEvent
	{
		get
		{
			return m_OnPointerDownEvent;
		}
		set
		{
			m_OnPointerDownEvent = value;
		}
	}

	public SliderDragEvent OnPointerUpEvent
	{
		get
		{
			return m_OnPointerUpEvent;
		}
		set
		{
			m_OnPointerUpEvent = value;
		}
	}

	public override void OnDrag(PointerEventData eventData)
	{
		base.OnDrag(eventData);
		m_OnSliderDragEvent.Invoke(eventData);
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		base.OnPointerUp(eventData);
		m_OnPointerUpEvent.Invoke(eventData);
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		base.OnPointerDown(eventData);
		m_OnPointerDownEvent.Invoke(eventData);
	}
}
