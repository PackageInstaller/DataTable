using TMPro;
using UnityEngine;

namespace ACT.LocalizationExtension.Sample;

public class SampleCustomDropdown : MonoBehaviour
{
	public LocalizeTMP_Dropdown dropdown;

	public LocalizeTMP_Dropdown.OptionDataList optionDataList;

	private void Start()
	{
		for (int i = 0; i < optionDataList.options.Count; i++)
		{
			optionDataList.options[i].customData = (float)i;
		}
		dropdown.onAddItem += (LocalizeTMP_Dropdown.OptionData data, LocalizeTMP_Dropdown.DropdownItem item) =>
		{
			item.GetComponentsInChildren<TextMeshProUGUI>()[1].text = ((float)data.customData).ToString("0");
		};
		dropdown.options = optionDataList.options;
	}

	private void Update()
	{
		for (int i = 0; i < optionDataList.options.Count; i++)
		{
			optionDataList.options[i].customData = (float)optionDataList.options[i].customData + 0.0001f;
		}
	}
}
