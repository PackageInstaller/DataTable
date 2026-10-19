using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class AttributeTextColor : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	public Color normalColor;

	public Color pressColor;

	public TextMeshProUGUI text;

	public virtual void OnPointerDown(PointerEventData eventData)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(pressColor);
		}
		text.color = pressColor;
	}

	public virtual void OnPointerUp(PointerEventData eventData)
	{
		text.color = normalColor;
	}
}
