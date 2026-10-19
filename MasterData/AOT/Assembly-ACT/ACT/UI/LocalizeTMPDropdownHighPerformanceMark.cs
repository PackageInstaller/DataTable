using UnityEngine;

namespace ACT.UI;

public class LocalizeTMPDropdownHighPerformanceMark : MonoBehaviour
{
	[SerializeField]
	private GameObject _markNode;

	public void ResetOption(LocalizeTMPDropdownHighPerformanceMarksManager highPerformanceInfoProvider, int dropdownOptionIndex)
	{
		_markNode?.SetActive(highPerformanceInfoProvider?.IsHighPerformanceOption(dropdownOptionIndex) ?? false);
	}
}
