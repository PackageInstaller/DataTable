using System.Collections.Generic;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class HVScrollViewControl : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	private enum State
	{
		None,
		UpDown,
		LeftRight
	}

	public LoopScrollRect verticalLoopScrollRect;

	public ScrollRect verticalScrollRect;

	public int maxNum;

	public bool exclude;

	public string returnMask;

	public GameObject mask;

	private List<RaycastResult> resultObjs = new List<RaycastResult>();

	private State dragState;

	private Vector2 m_pos;

	private bool canUpDown;

	public void OnPointerDown(PointerEventData eventData)
	{
		if (verticalLoopScrollRect != null)
		{
			verticalLoopScrollRect.OnBeginDrag(eventData);
		}
		if (verticalScrollRect != null)
		{
			verticalScrollRect.OnBeginDrag(eventData);
		}
		m_pos = eventData.position;
		PassEvent(eventData, ExecuteEvents.pointerDownHandler);
		PassEvent(eventData, ExecuteEvents.beginDragHandler, remember: true);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (verticalLoopScrollRect != null)
		{
			verticalLoopScrollRect.OnEndDrag(eventData);
		}
		if (verticalScrollRect != null)
		{
			verticalScrollRect.OnEndDrag(eventData);
		}
		PassEvent(eventData, ExecuteEvents.pointerUpHandler);
		if (!eventData.dragging)
		{
			PassEvent(eventData, ExecuteEvents.pointerClickHandler);
		}
		PassEvent(eventData, ExecuteEvents.endDragHandler);
		dragState = State.None;
		EndDrag(eventData, ExecuteEvents.endDragHandler);
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (dragState == State.None)
		{
			Vector2 vector = eventData.position - m_pos;
			if (Mathf.Abs(vector.x) > Mathf.Abs(vector.y))
			{
				dragState = State.LeftRight;
			}
			else
			{
				dragState = State.UpDown;
			}
		}
		PassEvent(eventData, ExecuteEvents.dragHandler, remember: false, isDrag: true);
		if (canUpDown)
		{
			if (verticalLoopScrollRect != null)
			{
				verticalLoopScrollRect.OnDrag(eventData);
			}
			if (verticalScrollRect != null)
			{
				verticalScrollRect.OnDrag(eventData);
			}
		}
	}

	public void PassEvent<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function, bool remember = false, bool isDrag = false) where T : IEventSystemHandler
	{
		canUpDown = false;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystemHelper.Shared.RaycastAll(data, list);
		GameObject gameObject = data.pointerCurrentRaycast.gameObject;
		int num = 0;
		if (remember)
		{
			resultObjs = list;
		}
		for (int i = 0; i < list.Count; i++)
		{
			if (list[0].gameObject != mask)
			{
				break;
			}
			if ((exclude && i - 1 > 0 && list[i - 1].gameObject.name == returnMask) || !(gameObject != list[i].gameObject))
			{
				continue;
			}
			num++;
			if (isDrag)
			{
				switch (dragState)
				{
				case State.UpDown:
					canUpDown = true;
					break;
				case State.LeftRight:
				{
					LoopHorizontalScrollRect component = list[i].gameObject.GetComponent<LoopHorizontalScrollRect>();
					if ((bool)component)
					{
						if (!component.CanDrag(maxNum))
						{
							canUpDown = true;
						}
						else
						{
							ExecuteEvents.Execute(list[i].gameObject, data, function);
						}
						break;
					}
					ScrollRect component2 = list[i].gameObject.GetComponent<ScrollRect>();
					if ((bool)component2)
					{
						if (component2.content.childCount <= maxNum)
						{
							canUpDown = true;
						}
						else
						{
							ExecuteEvents.Execute(list[i].gameObject, data, function);
						}
					}
					break;
				}
				}
			}
			else
			{
				ExecuteEvents.Execute(list[i].gameObject, data, function);
			}
		}
	}

	private void EndDrag<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function) where T : IEventSystemHandler
	{
		GameObject gameObject = data.pointerCurrentRaycast.gameObject;
		for (int i = 0; i < resultObjs.Count; i++)
		{
			if (gameObject != resultObjs[i].gameObject)
			{
				ExecuteEvents.Execute(resultObjs[i].gameObject, data, function);
			}
		}
	}
}
