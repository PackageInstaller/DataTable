using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

public class SelfUIScaleImage : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	public class ClickedEvent : UnityEvent
	{
	}

	private enum state
	{
		None,
		BeginDrag,
		Dragging,
		BeginScale,
		Scaling
	}

	public float scalingRate = 0.001f;

	public float maxScale = 3f;

	public float minScale = 0.5f;

	public RectTransform Content;

	public RectTransform View;

	private float currentScale = 1f;

	private bool isPointing;

	private float m_startPointDistance;

	private float m_startScale;

	private ClickedEvent m_OnClick = new ClickedEvent();

	private Vector2 m_ContentStartPosition;

	private int touchCount;

	private int fingerID = 1;

	private Vector2 contentPivot;

	private float rightWidth;

	private float leftWidth;

	private float topHeight;

	private float bottomHeight;

	private float falfViewWidth;

	private float falfViewHeight;

	private state m_state;

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

	public void ResetContent()
	{
		Content.localPosition = new Vector3(0f, 0f, 0f);
		Content.localScale = new Vector3(1f, 1f, 1f);
	}

	public void OnEnable()
	{
		Content.anchorMax = new Vector2(0.5f, 0.5f);
		Content.anchorMin = Content.anchorMax;
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		touchCount++;
		if (touchCount == 1)
		{
			m_state = state.BeginDrag;
			isPointing = true;
		}
		if (touchCount >= 2)
		{
			m_state = state.BeginScale;
		}
		contentPivot = Content.pivot;
		leftWidth = Content.rect.width * contentPivot.x;
		rightWidth = Content.rect.width - leftWidth;
		bottomHeight = Content.rect.height * contentPivot.y;
		topHeight = Content.rect.height - bottomHeight;
		falfViewWidth = View.rect.width * 0.5f;
		falfViewHeight = View.rect.height * 0.5f;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		touchCount--;
		if (touchCount == 1)
		{
			m_state = state.BeginDrag;
		}
		if (touchCount <= 0)
		{
			m_state = state.None;
			if (isPointing)
			{
				m_OnClick.Invoke();
			}
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (Input.touchCount <= 0)
		{
			touchCount = 1;
			return;
		}
		isPointing = false;
		if (m_state == state.BeginDrag)
		{
			m_state = state.Dragging;
			m_ContentStartPosition = Content.position;
			fingerID = Input.GetTouch(0).fingerId;
		}
		else if (m_state == state.BeginScale)
		{
			m_state = state.Scaling;
			m_startPointDistance = Vector3.Distance(Input.GetTouch(0).position, Input.GetTouch(1).position);
			m_startScale = Content.localScale.x;
		}
		if (m_state == state.Dragging)
		{
			Touch touch = Input.GetTouch(0);
			if (touch.fingerId != fingerID)
			{
				m_ContentStartPosition = Content.localPosition;
				fingerID = touch.fingerId;
				return;
			}
			float x = Content.localScale.x;
			Vector2 vector = Content.localPosition;
			Vector2 delta = eventData.delta;
			Vector2 vector2 = vector + delta;
			if (Content.rect.width * x >= View.rect.width)
			{
				if (delta.x < 0f && vector2.x + rightWidth * x < falfViewWidth)
				{
					vector2.x = vector.x;
				}
				if (delta.x > 0f && vector2.x - leftWidth * x > 0f - falfViewWidth)
				{
					vector2.x = vector.x;
				}
			}
			else
			{
				if (delta.x < 0f && vector2.x - leftWidth * x < 0f - falfViewWidth)
				{
					vector2.x = vector.x;
				}
				if (delta.x > 0f && vector2.x + rightWidth * x > falfViewWidth)
				{
					vector2.x = vector.x;
				}
			}
			if (Content.rect.height * x >= View.rect.height)
			{
				if (delta.y < 0f && vector2.y + topHeight * x < falfViewHeight)
				{
					vector2.y = vector.y;
				}
				if (delta.y > 0f && vector2.y - bottomHeight * x > 0f - falfViewHeight)
				{
					vector2.y = vector.y;
				}
			}
			else
			{
				if (delta.y < 0f && vector2.y - bottomHeight * x < 0f - falfViewHeight)
				{
					vector2.y = vector.y;
				}
				if (delta.y > 0f && vector2.y + topHeight * x > falfViewHeight)
				{
					vector2.y = vector.y;
				}
			}
			Content.localPosition = new Vector3(vector2.x, vector2.y, 0f);
		}
		else if (m_state == state.Scaling)
		{
			float num = Vector3.Distance(Input.GetTouch(0).position, Input.GetTouch(1).position) - m_startPointDistance;
			currentScale = m_startScale + num * scalingRate;
			float x2 = Content.localScale.x;
			float num2 = Mathf.Clamp(currentScale - x2, -0.05f, 0.05f) + x2;
			if (num2 < minScale)
			{
				num2 = minScale;
			}
			if (num2 > maxScale)
			{
				num2 = maxScale;
			}
			Content.localScale = new Vector2(num2, num2);
		}
	}
}
