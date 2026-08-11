using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

[RequireComponent(typeof(Image))]
public class ClickThroughImage : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	public void OnPointerClick(PointerEventData eventData)
	{
		Image component = GetComponent<Image>();
		component.raycastTarget = false;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(eventData, list);
		foreach (RaycastResult item in list)
		{
			if (item.gameObject != base.gameObject && item.gameObject.GetComponent<Button>() != null)
			{
				ExecuteEvents.Execute(item.gameObject, eventData, ExecuteEvents.pointerClickHandler);
				break;
			}
		}
		component.raycastTarget = true;
	}
}
