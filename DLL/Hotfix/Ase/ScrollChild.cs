using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class ScrollChild : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler
{
	[SerializeField]
	private ScrollRect upperScroll;

	private Action beginDragAction;

	private Action endDragAction;

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (upperScroll != null)
		{
			upperScroll.OnBeginDrag(eventData);
			beginDragAction?.Invoke();
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (upperScroll != null)
		{
			upperScroll.OnDrag(eventData);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (upperScroll != null)
		{
			upperScroll.OnEndDrag(eventData);
			endDragAction?.Invoke();
		}
	}

	public void AddBeginDrag(Action action)
	{
		beginDragAction = (Action)Delegate.Combine(beginDragAction, action);
	}

	public void AddEndDrag(Action action)
	{
		endDragAction = (Action)Delegate.Combine(endDragAction, action);
	}

	private void OnDestroy()
	{
		beginDragAction = null;
		endDragAction = null;
	}
}
