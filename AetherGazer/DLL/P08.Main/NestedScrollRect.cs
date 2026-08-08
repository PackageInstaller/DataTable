using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class NestedScrollRect : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler
{
	public ScrollRect parentScrollRect;

	private ScrollRect scrollRect;

	public bool isUpAndDown;

	private void Awake()
	{
		scrollRect = GetComponent<ScrollRect>();
		if (parentScrollRect == null)
		{
			parentScrollRect = scrollRect.GetComponentsInParent<ScrollRect>()[1];
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		parentScrollRect.OnBeginDrag(eventData);
		float num = Vector2.Angle(eventData.delta, Vector2.up);
		if (num > 45f && num < 135f)
		{
			scrollRect.enabled = !isUpAndDown;
			parentScrollRect.enabled = isUpAndDown;
		}
		else
		{
			scrollRect.enabled = isUpAndDown;
			parentScrollRect.enabled = !isUpAndDown;
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		parentScrollRect.OnDrag(eventData);
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		parentScrollRect.OnEndDrag(eventData);
		scrollRect.enabled = true;
		parentScrollRect.enabled = true;
	}
}
