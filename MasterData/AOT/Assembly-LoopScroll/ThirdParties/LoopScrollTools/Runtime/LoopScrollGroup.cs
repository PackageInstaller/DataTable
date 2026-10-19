using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pool;
using UnityEngine.UI;

namespace ThirdParties.LoopScrollTools.Runtime;

public class LoopScrollGroup : UIBehaviour, IInitializePotentialDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler, IDragHandler
{
	private enum State
	{
		None,
		UpDown,
		LeftRight
	}

	private List<RaycastResult> _resultObjs;

	private State _dragState;

	private List<LoopScrollRectBase> _loopScrollRects;

	private List<LoopScrollRectBase> _horizontalRects;

	private List<LoopScrollRectBase> _verticalRects;

	private List<LoopScrollRectBase> _currentOperateRects => _dragState switch
	{
		State.UpDown => _verticalRects, 
		State.LeftRight => _horizontalRects, 
		_ => _horizontalRects, 
	};

	protected override void Awake()
	{
		base.Awake();
		if (_resultObjs == null)
		{
			_resultObjs = CollectionPool<List<RaycastResult>, RaycastResult>.Get();
		}
		if (_horizontalRects == null)
		{
			_horizontalRects = CollectionPool<List<LoopScrollRectBase>, LoopScrollRectBase>.Get();
		}
		if (_verticalRects == null)
		{
			_verticalRects = CollectionPool<List<LoopScrollRectBase>, LoopScrollRectBase>.Get();
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		CollectionPool<List<RaycastResult>, RaycastResult>.Release(_resultObjs);
		CollectionPool<List<LoopScrollRectBase>, LoopScrollRectBase>.Release(_loopScrollRects);
		CollectionPool<List<LoopScrollRectBase>, LoopScrollRectBase>.Release(_horizontalRects);
		CollectionPool<List<LoopScrollRectBase>, LoopScrollRectBase>.Release(_verticalRects);
		_resultObjs = null;
		_loopScrollRects = null;
		_horizontalRects = null;
		_verticalRects = null;
	}

	public void RegisterRect(LoopScrollRectBase rect)
	{
		if (_loopScrollRects == null)
		{
			_loopScrollRects = CollectionPool<List<LoopScrollRectBase>, LoopScrollRectBase>.Get();
		}
		_loopScrollRects.Add(rect);
	}

	public void UnRegisterRect(LoopScrollRectBase rect)
	{
		_loopScrollRects?.Remove(rect);
		if (rect.horizontal || rect is LoopHorizontalScrollRect || rect is LoopHorizontalScrollRectMulti)
		{
			_horizontalRects?.Remove(rect);
		}
		else
		{
			_verticalRects?.Remove(rect);
		}
	}

	public void OnInitializePotentialDrag(PointerEventData eventData)
	{
		RayCastLoopScroll(eventData);
		if (_loopScrollRects == null)
		{
			return;
		}
		foreach (LoopScrollRectBase loopScrollRect in _loopScrollRects)
		{
			loopScrollRect.InitializePotentialDragScrollView(eventData);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (_dragState == State.None)
		{
			Vector2 delta = eventData.delta;
			if (Mathf.Abs(delta.x) > Mathf.Abs(delta.y))
			{
				_dragState = State.LeftRight;
			}
			else
			{
				_dragState = State.UpDown;
			}
		}
		if (_currentOperateRects == null)
		{
			return;
		}
		foreach (LoopScrollRectBase currentOperateRect in _currentOperateRects)
		{
			currentOperateRect.BeginDragScrollView(eventData);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (_currentOperateRects == null)
		{
			return;
		}
		foreach (LoopScrollRectBase currentOperateRect in _currentOperateRects)
		{
			currentOperateRect.DragScrollView(eventData);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (_currentOperateRects != null)
		{
			foreach (LoopScrollRectBase currentOperateRect in _currentOperateRects)
			{
				currentOperateRect.EndDragScrollView(eventData);
			}
		}
		_dragState = State.None;
		ClearRayCastLoopScroll();
	}

	private void OnMouseUp()
	{
		_dragState = State.None;
		ClearRayCastLoopScroll();
	}

	private void RayCastLoopScroll(PointerEventData eventData)
	{
		_resultObjs.Clear();
		_horizontalRects.Clear();
		_verticalRects.Clear();
		EventSystem.current.RaycastAll(eventData, _resultObjs);
		foreach (RaycastResult resultObj in _resultObjs)
		{
			LoopScrollRectBase componentInParent = resultObj.gameObject.GetComponentInParent<LoopScrollRectBase>();
			if ((bool)componentInParent && _loopScrollRects.Contains(componentInParent))
			{
				if (componentInParent.horizontal || componentInParent is LoopHorizontalScrollRect || componentInParent is LoopHorizontalScrollRectMulti)
				{
					_horizontalRects.Add(componentInParent);
				}
				else
				{
					_verticalRects.Add(componentInParent);
				}
			}
		}
	}

	private void ClearRayCastLoopScroll()
	{
		_verticalRects.Clear();
		_horizontalRects.Clear();
	}
}
