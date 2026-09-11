using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Pipelines.SimPipeline;

public class UIScaleImage : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IScrollHandler, IBeginDragHandler
{
	public class ClickedEvent : UnityEvent
	{
	}

	public class ScaleDragEvent : UnityEvent<float>
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

	private Vector3 m_PointerStartLocalCursor;

	private bool isPointing;

	private float m_startPointDistance;

	private float m_startScale;

	private ClickedEvent m_OnClick = new ClickedEvent();

	private ScaleDragEvent m_OnScaleEvent = new ScaleDragEvent();

	private Vector3 m_ContentStartPosition;

	private int touchCount;

	private int fingerID = 1;

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

	public ScaleDragEvent onScaleEvent
	{
		get
		{
			return m_OnScaleEvent;
		}
		set
		{
			m_OnScaleEvent = value;
		}
	}

	public void ResetContent()
	{
		Content.localPosition = new Vector3(0f, 0f, 0f);
		Content.localScale = new Vector3(1f, 1f, 1f);
	}

	public void SetScale(float scale)
	{
		Content.localScale = new Vector3(scale, scale, scale);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		isPointing = true;
		m_OnClick?.Invoke();
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (isPointing)
		{
			m_OnClick?.Invoke();
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		Vector3 mousePosition = Input.mousePosition;
		mousePosition.x = Mathf.Clamp(mousePosition.x, Screen.width / 6, Screen.width - Screen.width / 6);
		mousePosition.y = Mathf.Clamp(mousePosition.y, Screen.height / 6, Screen.height - Screen.height / 6);
		Camera uiCamera = CanvasManager.Instance.uiCamera;
		RectTransformUtility.ScreenPointToWorldPointInRectangle(View, mousePosition, uiCamera, out var worldPoint);
		Vector3 position = Content.position;
		Vector3 vector = m_ContentStartPosition + (worldPoint - m_PointerStartLocalCursor);
		Vector3 vector2 = RectTransformUtility.WorldToScreenPoint(uiCamera, Content.position + Vector3.ClampMagnitude(vector - position, 0.2f));
		vector2.x = Mathf.Clamp(vector2.x, Screen.width / 6, Screen.width - Screen.width / 6);
		vector2.y = Mathf.Clamp(vector2.y, Screen.height / 6, Screen.height - Screen.height / 6);
		RectTransformUtility.ScreenPointToWorldPointInRectangle(View, vector2, uiCamera, out worldPoint);
		Content.position = worldPoint;
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		m_ContentStartPosition = Content.position;
		Vector3 zero = Vector3.zero;
		zero = Input.mousePosition;
		Camera uiCamera = CanvasManager.Instance.uiCamera;
		RectTransformUtility.ScreenPointToWorldPointInRectangle(View, zero, uiCamera, out m_PointerStartLocalCursor);
		isPointing = false;
	}

	public void LateUpdate()
	{
	}

	public void OnScroll(PointerEventData eventData)
	{
		m_startScale = Content.localScale.x;
		currentScale = m_startScale + eventData.scrollDelta.y * 10f * scalingRate;
		float x = Content.localScale.x;
		float num = Mathf.Clamp(currentScale - x, -0.05f, 0.05f) + x;
		if (num < minScale)
		{
			num = minScale;
		}
		if (num > maxScale)
		{
			num = maxScale;
		}
		Content.localScale = new Vector2(num, num);
		m_OnScaleEvent?.Invoke(num);
	}
}
