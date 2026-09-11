using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ScrollRectCast : ScrollRect
{
	private enum Direction
	{
		Horizontal,
		Vertical
	}

	public GameObject m_parent;

	private Direction m_direction;

	private Direction m_beginDragDirection;

	protected override void Awake()
	{
		base.Awake();
		m_direction = ((!base.horizontal) ? Direction.Vertical : Direction.Horizontal);
	}

	public void SetParent(GameObject go)
	{
		m_parent = go;
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		m_beginDragDirection = ((!(Mathf.Abs(eventData.delta.x) > Mathf.Abs(eventData.delta.y))) ? Direction.Vertical : Direction.Horizontal);
		if ((bool)m_parent && m_direction != m_beginDragDirection)
		{
			ExecuteEvents.Execute(m_parent, eventData, ExecuteEvents.beginDragHandler);
		}
		else
		{
			base.OnBeginDrag(eventData);
		}
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if ((bool)m_parent && m_direction != m_beginDragDirection)
		{
			ExecuteEvents.Execute(m_parent, eventData, ExecuteEvents.dragHandler);
		}
		else
		{
			base.OnDrag(eventData);
		}
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		if ((bool)m_parent && m_direction != m_beginDragDirection)
		{
			ExecuteEvents.Execute(m_parent, eventData, ExecuteEvents.endDragHandler);
		}
		else
		{
			base.OnEndDrag(eventData);
		}
	}

	public override void OnScroll(PointerEventData data)
	{
		if ((bool)m_parent && m_direction != m_beginDragDirection)
		{
			ExecuteEvents.Execute(m_parent, data, ExecuteEvents.scrollHandler);
		}
		else
		{
			base.OnScroll(data);
		}
	}
}
