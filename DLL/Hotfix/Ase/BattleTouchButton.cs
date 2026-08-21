using UnityEngine;
using UnityEngine.EventSystems;

namespace Ase;

public class BattleTouchButton : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IBeginDragHandler, IDragHandler, IEndDragHandler, IPointerUpHandler
{
	public void OnPointerDown(PointerEventData eventData)
	{
		if (OnlySameFinger(eventData))
		{
			PointerDown(eventData);
		}
	}

	public virtual void PointerDown(PointerEventData eventData)
	{
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (OnlySameFinger(eventData))
		{
			BeginDrag(eventData);
		}
	}

	public virtual void BeginDrag(PointerEventData eventData)
	{
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (OnlySameFinger(eventData))
		{
			Drag(eventData);
		}
	}

	public virtual void Drag(PointerEventData eventData)
	{
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (OnlySameFinger(eventData))
		{
			EndDrag(eventData);
		}
	}

	public virtual void EndDrag(PointerEventData eventData)
	{
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (OnlySameFinger(eventData))
		{
			PointerUp(eventData);
		}
	}

	public virtual void PointerUp(PointerEventData eventData)
	{
	}

	protected virtual bool OnlySameFinger(PointerEventData eventData)
	{
		return true;
	}
}
