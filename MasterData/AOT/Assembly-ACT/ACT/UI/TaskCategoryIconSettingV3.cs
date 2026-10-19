using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public sealed class TaskCategoryIconSettingV3
{
	[SerializeField]
	private TaskCategoryV3 _category;

	[SerializeField]
	private GameObject _icon;

	public TaskCategoryV3 Category => _category;

	public GameObject Icon => _icon;
}
