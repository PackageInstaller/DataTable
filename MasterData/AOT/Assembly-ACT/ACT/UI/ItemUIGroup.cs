using UnityEngine;

namespace ACT.UI;

public class ItemUIGroup : MonoBehaviour
{
	public RectTransform rootPosition;

	public bool independentSelected;

	private ItemUIComponentBase lastSelected;

	public void FindAll_IUCInChildren()
	{
		ItemUIComponentBase[] componentsInChildren = gameObject.GetComponentsInChildren<ItemUIComponentBase>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].group = this;
			_ = LuminApplication.LogEnabled;
		}
	}

	public void SetSelected(ItemUIComponentBase itemUI)
	{
		if (independentSelected)
		{
			if (lastSelected != null)
			{
				lastSelected.IsChosen = false;
			}
			itemUI.IsChosen = true;
			lastSelected = itemUI;
		}
	}

	private void OnEnable()
	{
		if (independentSelected)
		{
			if (lastSelected != null)
			{
				lastSelected.IsChosen = false;
			}
			lastSelected = null;
		}
	}

	public void CloseLast()
	{
		if (independentSelected && lastSelected != null)
		{
			lastSelected.IsChosen = false;
		}
	}
}
