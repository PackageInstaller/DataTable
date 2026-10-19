using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class LocalizeTMPDropdownHighPerformanceMarksManager : MonoBehaviour
{
	[SerializeField]
	private GameObject _markNode;

	private HashSet<int> _highPerformanceOptions;

	public void SetHighPerformanceInfos(HashSet<int> highPerformanceOptions)
	{
		_highPerformanceOptions = highPerformanceOptions;
	}

	public void UpdateValue(int arg0)
	{
		_markNode?.SetActive(IsHighPerformanceOption(arg0));
	}

	public bool IsHighPerformanceOption(int dropdownOptionIndex)
	{
		return _highPerformanceOptions?.Contains(dropdownOptionIndex) ?? false;
	}
}
