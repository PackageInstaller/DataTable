using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public class SettingCellBindings
{
	[Serializable]
	public struct DependsOn
	{
		[SerializeField]
		private string _id;

		public string Id => _id;
	}

	public SettingCellType type;

	public bool enabled;

	public string settingsKey = string.Empty;

	public bool localizedDropdown = true;

	[SerializeField]
	private DependsOn[] _dependsOn;

	public List<GameObject> components = new List<GameObject>();

	public DependsOn[] DependsOnSettings => _dependsOn;

	public void SetActive(bool value)
	{
		foreach (GameObject component in components)
		{
			component.SetActive(value);
		}
	}
}
