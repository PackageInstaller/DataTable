using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

[RequireComponent(typeof(RectTransform))]
[RequireComponent(typeof(EmptyRaycast))]
public class BoardPartItem : MonoBehaviour, IBoardPart, IBoardPartContextSource, IBoardPartActionEntryProvider, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerClickHandler, IBeginDragHandler, IDragHandler, IEndDragHandler
{
	public enum DragNormalizeAxis
	{
		None,
		X,
		Y
	}

	[SerializeField]
	private DragNormalizeAxis normalizeAxis = DragNormalizeAxis.X;

	[SerializeField]
	private float dragThreshold = 5f;

	[SerializeField]
	private bool suppressClickOnDrag = true;

	[SerializeField]
	[HideInInspector]
	private List<BoardPartActionEntry> actionEntries = new List<BoardPartActionEntry>();

	[SerializeField]
	[HideInInspector]
	private string partId;

	private RectTransform rectTransform;

	private bool pointerDown;

	private bool dragStarted;

	private float dragAccum;

	private int pointerId;

	private readonly List<string> emptyCacheAniNames = new List<string>();

	[HideInInspector]
	public GameObject FollowRoot;

	public string PartId => partId;

	public IReadOnlyList<BoardPartActionEntry> ActionEntries => actionEntries;

	public IReadOnlyList<string> CacheAniNames => emptyCacheAniNames;

	public bool CheckFrequentlyUsed => false;

	private ISpinePlayCommand playCommand => new SpineLegacyPlayCommand();

	public ISpinePlayCommand PlayCommand => playCommand;

	public event Action<BoardPartClickContext> OnPartClick;

	public event Action<BoardPartDragContext> OnPartDrag;

	public void AssginPartId(string partId)
	{
		this.partId = partId;
	}

	public void Init()
	{
		rectTransform = GetComponent<RectTransform>();
		if (string.IsNullOrEmpty(partId))
		{
			partId = base.gameObject.name;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		pointerDown = true;
		dragStarted = false;
		dragAccum = 0f;
		pointerId = eventData.pointerId;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		pointerDown = false;
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (!suppressClickOnDrag || !dragStarted)
		{
			BoardPartClickContext obj = new BoardPartClickContext
			{
				PartId = partId,
				CheckFrequentlyUsed = CheckFrequentlyUsed,
				PointerId = eventData.pointerId,
				ScreenPos = eventData.position,
				LocalPos = ScreenToLocal(eventData),
				ClickCount = eventData.clickCount,
				Time = Time.unscaledTime,
				Source = base.gameObject,
				PlayCommand = playCommand
			};
			OnPartClick?.Invoke(obj);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (pointerDown && eventData.pointerId == pointerId)
		{
			dragAccum = 0f;
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!pointerDown || eventData.pointerId != pointerId)
		{
			return;
		}
		dragAccum += eventData.delta.magnitude;
		if (!dragStarted)
		{
			if (!(dragAccum < dragThreshold))
			{
				dragStarted = true;
				RaiseDrag(eventData, BoardPartDragPhase.Begin);
			}
		}
		else
		{
			RaiseDrag(eventData, BoardPartDragPhase.Move);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (pointerDown && eventData.pointerId == pointerId && dragStarted)
		{
			RaiseDrag(eventData, BoardPartDragPhase.End);
		}
	}

	private void RaiseDrag(PointerEventData eventData, BoardPartDragPhase phase)
	{
		Vector2 vector = ScreenToLocal(eventData);
		BoardPartDragContext obj = new BoardPartDragContext
		{
			PartId = partId,
			PointerId = eventData.pointerId,
			ScreenPos = eventData.position,
			LocalPos = vector,
			Delta = eventData.delta,
			Phase = phase,
			Normalized = CalcNormalized(vector),
			Time = Time.unscaledTime,
			Source = base.gameObject
		};
		OnPartDrag?.Invoke(obj);
	}

	private Vector2 ScreenToLocal(PointerEventData eventData)
	{
		if (rectTransform == null)
		{
			return Vector2.zero;
		}
		Vector2 result = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, eventData.position, eventData.pressEventCamera, ref result);
		return result;
	}

	private float CalcNormalized(Vector2 local)
	{
		if (rectTransform == null || normalizeAxis == DragNormalizeAxis.None)
		{
			return 0.5f;
		}
		Rect rect = rectTransform.rect;
		if (normalizeAxis == DragNormalizeAxis.X)
		{
			if (rect.width <= 0.0001f)
			{
				return 0.5f;
			}
			return Mathf.Clamp01((local.x - rect.xMin) / rect.width);
		}
		if (rect.height <= 0.0001f)
		{
			return 0.5f;
		}
		return Mathf.Clamp01((local.y - rect.yMin) / rect.height);
	}
}
