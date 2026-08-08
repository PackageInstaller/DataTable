using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UIDropDown : Dropdown
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
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		Show();
	}

	protected override GameObject CreateDropdownList(GameObject template)
	{
		Object.DestroyImmediate(template.GetComponent<GraphicRaycaster>());
		Object.DestroyImmediate(template.GetComponent<Canvas>());
		return Object.Instantiate(template);
	}

	protected override GameObject CreateBlocker(Canvas rootCanvas)
	{
		GameObject obj = new GameObject("Blocker");
		Transform parent = base.transform.Find("mask");
		RectTransform rectTransform = obj.AddComponent<RectTransform>();
		rectTransform.SetParent(parent, worldPositionStays: false);
		rectTransform.anchorMin = Vector3.zero;
		rectTransform.anchorMax = Vector3.one;
		rectTransform.sizeDelta = Vector2.zero;
		obj.AddComponent<Image>().color = Color.clear;
		obj.AddComponent<Button>().onClick.AddListener(base.Hide);
		return obj;
	}
}
