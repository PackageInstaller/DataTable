using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

[RequireComponent(typeof(Mask))]
public class UISetAsSibling : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	void IPointerClickHandler.OnPointerClick(PointerEventData eventData)
	{
		base.transform.SetAsLastSibling();
	}
}
