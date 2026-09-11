using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

public class MutiTouchHelper : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler, IPointerClickHandler, IScrollHandler
{
	public RectTransform limitTrs;

	private Camera uiCamera;

	public Action<float, float> OnSingleDrag;

	public Action<float> OnMutiDrag;

	public LuaHelper.ETLCallBack1 OnClick;

	public Action OnIdle;

	public Action EndDrag;

	[HideInInspector]
	public bool isOnDrag;

	public float idleTime = 90f;

	private PointerEventData dragEventData;

	private int draging;

	public int maxDraging = 5;

	private Vector2 _scrollDelta;

	private float lastTouchDis = -1f;

	private float idleTimer;

	public void OnPointerClick(PointerEventData eventData)
	{
		idleTimer = 0f;
		if (!isOnDrag && OnClick != null)
		{
			OnClick?.Invoke(base.gameObject, eventData);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		idleTimer = 0f;
		isOnDrag = true;
	}

	public void OnDrag(PointerEventData eventData)
	{
		dragEventData = eventData;
		draging = maxDraging;
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		isOnDrag = false;
		if (EndDrag != null)
		{
			EndDrag();
		}
	}

	public void OnScroll(PointerEventData eventData)
	{
		_scrollDelta = eventData.scrollDelta;
	}

	private void Start()
	{
		limitTrs = GetComponent<RectTransform>();
		uiCamera = CanvasManager.Instance.uiCamera;
	}

	private void OnEnable()
	{
		idleTimer = 0f;
	}

	private void Update()
	{
		if (!isOnDrag)
		{
			idleTimer += Time.deltaTime;
			if (idleTimer > idleTime && OnIdle != null)
			{
				idleTimer = 0f;
				OnIdle();
			}
		}
		else
		{
			if (dragEventData != null && Input.touchCount <= 1)
			{
				Vector2 vector = dragEventData.delta / Time.deltaTime;
				float x = vector.x;
				float num = -1f * vector.y;
				OnSingleDrag(x * 0.001f, num * 0.001f);
				dragEventData = null;
			}
			else if (0 < draging)
			{
				draging--;
			}
			else
			{
				OnSingleDrag(0f, 0f);
				draging = 0;
			}
			idleTimer = 0f;
		}
		if (Input.touchCount == 2)
		{
			isOnDrag = true;
			idleTimer = 0f;
			if (!RectTransformUtility.RectangleContainsScreenPoint(limitTrs, Input.touches[0].position, uiCamera) || !RectTransformUtility.RectangleContainsScreenPoint(limitTrs, Input.touches[1].position, uiCamera))
			{
				lastTouchDis = -1f;
				return;
			}
			float num2 = Vector2.Distance(Input.touches[0].position, Input.touches[1].position);
			if (-1f == lastTouchDis)
			{
				lastTouchDis = num2;
			}
			float num3 = num2 - lastTouchDis;
			if (num3 != 0f && OnMutiDrag != null)
			{
				OnMutiDrag(num3);
			}
		}
		else if (_scrollDelta != default(Vector2))
		{
			OnMutiDrag?.Invoke(_scrollDelta.y);
			_scrollDelta = default(Vector2);
		}
		else
		{
			lastTouchDis = -1f;
		}
	}

	protected void OnDestroy()
	{
		OnSingleDrag = null;
		OnMutiDrag = null;
		OnClick = null;
		OnIdle = null;
	}
}
