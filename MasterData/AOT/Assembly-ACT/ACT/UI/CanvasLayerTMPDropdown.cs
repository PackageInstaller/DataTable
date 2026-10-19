using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[AddComponentMenu("ACT/UI/Canvas Layer TMP Dropdown")]
public class CanvasLayerTMPDropdown : TMP_Dropdown
{
	[SerializeField]
	private bool useCustomCanvasSorting = true;

	[SerializeField]
	private bool overrideSorting = true;

	[SerializeField]
	private string sortingLayerName = "Default";

	[SerializeField]
	private int sortingOrder = 30000;

	[SerializeField]
	private AdditionalCanvasShaderChannels additionalShaderChannels;

	private GameObject m_DropDown;

	protected override GameObject CreateDropdownList(GameObject template)
	{
		m_DropDown = base.CreateDropdownList(template);
		return m_DropDown;
	}

	protected override GameObject CreateBlocker(Canvas rootCanvas)
	{
		GameObject result = base.CreateBlocker(rootCanvas);
		ApplyScrollRectCanvasSettings(m_DropDown);
		return result;
	}

	private void ApplyScrollRectCanvasSettings(GameObject dropdownList)
	{
		if (!useCustomCanvasSorting || dropdownList == null)
		{
			return;
		}
		ScrollRect componentInChildren = dropdownList.GetComponentInChildren<ScrollRect>(includeInactive: true);
		if (!(componentInChildren == null))
		{
			Canvas component = componentInChildren.GetComponent<Canvas>();
			if (!(component == null))
			{
				component.overrideSorting = overrideSorting;
				component.sortingLayerID = SortingLayer.NameToID(sortingLayerName);
				component.sortingOrder = sortingOrder;
				component.additionalShaderChannels = additionalShaderChannels;
			}
		}
	}
}
