using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ScrollEventPasser : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler
{
	public Transform target;

	public void OnBeginDrag(PointerEventData eventData)
	{
		target.GetComponent<ScrollRect>().OnBeginDrag(eventData);
	}

	public void OnDrag(PointerEventData eventData)
	{
		target.GetComponent<ScrollRect>().OnDrag(eventData);
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		target.GetComponent<ScrollRect>().OnEndDrag(eventData);
	}
}
