using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

public class ArcSlider : Selectable, IDragHandler, IEventSystemHandler, IEndDragHandler, IBeginDragHandler
{
	public class SliderEvent : UnityEvent<float>
	{
	}

	[SerializeField]
	private RectTransform m_HandleRect;

	public RectTransform m_baseRect;

	public float m_startAngle;

	public float m_endAngle = 360f;

	private float m_Value;

	[SerializeField]
	private float m_Radius;

	[SerializeField]
	private float m_showValue;

	private SliderEvent m_OnValueChanged = new SliderEvent();

	private Action m_OnDragEnd;

	private bool m_DelayedUpdateVisuals;

	private bool m_dragHandler;

	public RectTransform handleRect
	{
		get
		{
			return m_HandleRect;
		}
		set
		{
			if (SetPropertyUtility.SetClass(ref m_HandleRect, value))
			{
				UpdateVisuals();
			}
		}
	}

	public RectTransform baseRect
	{
		get
		{
			return m_baseRect;
		}
		set
		{
			if (SetPropertyUtility.SetClass(ref m_baseRect, value))
			{
				UpdateVisuals();
			}
		}
	}

	private float value
	{
		get
		{
			return m_Value;
		}
		set
		{
			float num = Mathf.Abs(value * 360f - m_startAngle);
			num = ((num > 180f) ? (360f - num) : num);
			m_showValue = num / (m_endAngle - m_startAngle);
			SetValue(value);
		}
	}

	public float radius
	{
		get
		{
			return m_Radius;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_Radius, value))
			{
				UpdateVisuals();
			}
		}
	}

	public float showValue
	{
		get
		{
			float num = m_showValue * (m_endAngle - m_startAngle) + m_startAngle;
			if (num > 180f)
			{
				num -= 360f;
			}
			m_Value = num / 360f;
			return m_showValue;
		}
		set
		{
			this.value = (value * (m_endAngle - m_startAngle) + m_startAngle) / 360f;
			SetValue(this.value);
		}
	}

	public SliderEvent onValueChanged
	{
		get
		{
			return m_OnValueChanged;
		}
		set
		{
			m_OnValueChanged = value;
		}
	}

	protected override void OnEnable()
	{
		SetValue(m_Value);
	}

	private void Update()
	{
		if (m_DelayedUpdateVisuals)
		{
			m_DelayedUpdateVisuals = false;
			UpdateVisuals();
		}
	}

	private bool MayDrag(PointerEventData eventData)
	{
		if (IsActive() && IsInteractable())
		{
			return eventData.button == PointerEventData.InputButton.Left;
		}
		return false;
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!MayDrag(eventData) || !m_dragHandler || !RectTransformUtility.ScreenPointToLocalPointInRectangle(m_baseRect, eventData.position, eventData.pressEventCamera, out var localPoint))
		{
			return;
		}
		float num = Mathf.Atan2(localPoint.y, localPoint.x) * 57.29578f;
		if (m_endAngle > 180f)
		{
			if (!(num < m_startAngle) || !(num > m_endAngle - 360f))
			{
				value = num / 360f;
			}
			else if (Math.Abs(num - m_startAngle) < Math.Abs(num - m_endAngle + 360f))
			{
				value = m_startAngle / 360f;
			}
			else
			{
				value = m_endAngle / 360f;
			}
		}
		else if (num >= m_startAngle && num <= m_endAngle)
		{
			value = num / 360f;
		}
		else if (Math.Abs(num - m_startAngle) > Math.Abs(num - m_endAngle))
		{
			value = m_startAngle / 360f;
		}
		else
		{
			value = m_endAngle / 360f;
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		m_dragHandler = false;
		if (m_OnDragEnd != null)
		{
			m_OnDragEnd();
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (m_HandleRect != null)
		{
			if (RectTransformUtility.RectangleContainsScreenPoint(m_HandleRect, eventData.position, eventData.enterEventCamera))
			{
				m_dragHandler = true;
			}
		}
		else
		{
			m_dragHandler = true;
		}
	}

	private void UpdateVisuals()
	{
		if (m_HandleRect != null)
		{
			float angle = value * 360f;
			m_HandleRect.transform.localPosition = CalPos(angle);
		}
	}

	private Vector2 CalPos(float angle)
	{
		Vector2 zero = Vector2.zero;
		angle = MathF.PI / 180f * angle;
		zero.y = Mathf.Sin(angle) * m_Radius;
		zero.x = Mathf.Cos(angle) * m_Radius;
		return zero;
	}

	private void SetValue(float input, bool sendCallback = true)
	{
		if (m_Value != input)
		{
			m_Value = input;
			UpdateVisuals();
			if (sendCallback && m_OnValueChanged != null)
			{
				m_OnValueChanged.Invoke(m_showValue);
			}
		}
	}

	public void OnDragEnd(Action call)
	{
		m_OnDragEnd = call;
	}
}
