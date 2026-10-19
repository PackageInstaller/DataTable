using System.Collections.Generic;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class PassOnPointerEvent : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IDragHandler, IBeginDragHandler, IPointerUpHandler, IEndDragHandler, IPointerClickHandler
{
	private List<RaycastResult> _rayCastResults = new List<RaycastResult>();

	public int maxRayCastCount = 2;

	private bool _isDragging;

	public void OnPointerDown(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.pointerDownHandler);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.pointerUpHandler);
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		_isDragging = true;
		PassEvent(eventData, ExecuteEvents.beginDragHandler, raycast: false);
	}

	public void OnDrag(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.dragHandler, raycast: false);
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		_isDragging = false;
		PassEvent(eventData, ExecuteEvents.endDragHandler, raycast: false);
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (!_isDragging)
		{
			PassEvent(eventData, ExecuteEvents.submitHandler);
			PassEvent(eventData, ExecuteEvents.pointerClickHandler);
		}
	}

	public void PassEvent<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function, bool raycast = true) where T : IEventSystemHandler
	{
		if (raycast)
		{
			EventSystemHelper.Shared.RaycastAll(data, _rayCastResults);
			FilterRaycastResults();
		}
		ExecuteEventsOnResults(data, function);
	}

	private void FilterRaycastResults()
	{
		_rayCastResults.RemoveAll((RaycastResult result) => result.gameObject == gameObject || !HasEventHandler(result.gameObject));
	}

	private bool HasEventHandler(GameObject target)
	{
		ICanvasElement component14;
		if (!target.TryGetComponent<IMoveHandler>(out var _) && !target.TryGetComponent<IEndDragHandler>(out var _) && !target.TryGetComponent<IBeginDragHandler>(out var _) && !target.TryGetComponent<IDragHandler>(out var _) && !target.TryGetComponent<IPointerClickHandler>(out var _) && !target.TryGetComponent<IPointerDownHandler>(out var _) && !target.TryGetComponent<IPointerUpHandler>(out var _) && !target.TryGetComponent<IPointerEnterHandler>(out var _) && !target.TryGetComponent<IPointerExitHandler>(out var _) && !target.TryGetComponent<ISelectHandler>(out var _) && !target.TryGetComponent<IDeselectHandler>(out var _) && !target.TryGetComponent<IInitializePotentialDragHandler>(out var _) && !target.TryGetComponent<IScrollHandler>(out var _))
		{
			return target.TryGetComponent<ICanvasElement>(out component14);
		}
		return true;
	}

	private void ExecuteEventsOnResults<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function) where T : IEventSystemHandler
	{
		for (int i = 0; i < _rayCastResults.Count && i < maxRayCastCount; i++)
		{
			ExecuteEvents.ExecuteHierarchy(_rayCastResults[i].gameObject, data, function);
		}
	}
}
