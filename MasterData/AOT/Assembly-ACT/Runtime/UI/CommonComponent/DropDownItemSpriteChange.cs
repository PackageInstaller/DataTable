using ACT.LocalizationExtension;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Runtime.UI.CommonComponent;

public class DropDownItemSpriteChange : MonoBehaviour, IPointerClickHandler, IEventSystemHandler, IPointerEnterHandler, IPointerExitHandler
{
	public LocalizeTMP_Dropdown parentDropDown;

	public Image targetGraphic;

	public Sprite normalGraphic;

	public Sprite highlightedGraphic;

	public Sprite pressedGraphic;

	public Sprite disabledGraphic;

	private void Start()
	{
		if (parentDropDown.interactable)
		{
			parentDropDown.interactable = false;
		}
	}

	private void OnDisable()
	{
		parentDropDown.interactable = true;
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (!(targetGraphic == null) && !(pressedGraphic == null))
		{
			targetGraphic.sprite = pressedGraphic;
			eventData.Use();
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (!(targetGraphic == null) && !(highlightedGraphic == null))
		{
			targetGraphic.sprite = highlightedGraphic;
			eventData.Use();
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (!(targetGraphic == null) && !(normalGraphic == null))
		{
			targetGraphic.sprite = normalGraphic;
			eventData.Use();
		}
	}
}
