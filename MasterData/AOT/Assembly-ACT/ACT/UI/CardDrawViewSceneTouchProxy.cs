using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CardDrawViewSceneTouchProxy : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IDragHandler, IPointerUpHandler
{
	private CardDrawViewScene _scene;

	private CardDrawViewScene Scene
	{
		get
		{
			if (!(_scene != null))
			{
				return _scene = GetComponentInParent<CardDrawViewScene>();
			}
			return _scene;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		Scene?.OnPointerDown(eventData);
	}

	public void OnDrag(PointerEventData eventData)
	{
		Scene?.OnDrag(eventData);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		Scene?.OnPointerUp(eventData);
	}
}
