using System.Collections.Generic;
using System.Linq;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

internal class PalleteNodeDragHandler : SerializedMonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler
{
	private Transform level;

	private int dragCnt;

	public Transform dragIcon;

	public Toggle palleteSelectToggle;

	private Vector3 originalPos;

	private Transform dragOriginalRoot;

	public List<RaycastResult> hits = new List<RaycastResult>();

	[HideInInspector]
	public ColorPuzzleNode hoverOn;

	private void Start()
	{
		originalPos = dragIcon.localPosition;
		dragOriginalRoot = dragIcon.parent;
		level = GetComponentInParent<ColorPuzzle>().transform;
		dragCnt = 0;
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (dragCnt == 0)
		{
			dragIcon.SetParent(level, worldPositionStays: true);
		}
		dragCnt++;
		if ((bool)palleteSelectToggle && !palleteSelectToggle.isOn)
		{
			palleteSelectToggle.isOn = true;
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		dragCnt--;
		if (dragCnt == 0)
		{
			dragIcon.position = dragOriginalRoot.TransformPoint(originalPos);
			dragIcon.SetParent(dragOriginalRoot, worldPositionStays: true);
			if ((bool)hoverOn)
			{
				hoverOn.OnClickNode(base.transform.GetSiblingIndex());
			}
			hoverOn = null;
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		EventSystem.current.RaycastAll(eventData, hits);
		if (eventData.dragging)
		{
			hoverOn = hits.Select((RaycastResult hit) => hit.gameObject.GetComponentInParent<ColorPuzzleNode>()).FirstOrDefault((ColorPuzzleNode node) => node);
			if ((bool)hoverOn)
			{
				dragIcon.position = hoverOn.transform.position;
			}
			else
			{
				dragIcon.position = eventData.pointerCurrentRaycast.worldPosition;
			}
		}
	}

	private void Update()
	{
		if (!Input.GetMouseButton(0) && !Input.GetMouseButton(1) && !Input.GetMouseButton(2) && Input.touchCount == 0 && dragCnt != 0)
		{
			dragCnt = 1;
			OnEndDrag(null);
		}
	}
}
