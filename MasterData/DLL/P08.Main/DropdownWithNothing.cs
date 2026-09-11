using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class DropdownWithNothing : Dropdown
{
	public Text selectedText;

	public new void Show()
	{
		base.Show();
		DropdownItem[] componentsInChildren = base.transform.Find("Dropdown List/Viewport/Content").GetComponentsInChildren<DropdownItem>(includeInactive: false);
		if (selectedText != null)
		{
			selectedText.color = Color.white;
		}
		selectedText = componentsInChildren[base.value].text;
		selectedText.color = new Color(0f, 0f, 0f, 1f);
		Transform transform = base.transform.Find("Dropdown List/Viewport/Content");
		if ((bool)transform.GetChild(1))
		{
			transform.GetChild(1).gameObject.SetActive(value: false);
		}
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		Show();
	}
}
