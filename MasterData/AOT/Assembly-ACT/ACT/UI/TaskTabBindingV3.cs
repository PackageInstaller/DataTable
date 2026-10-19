using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization;

namespace ACT.UI;

[Serializable]
public sealed class TaskTabBindingV3
{
	[SerializeField]
	private TaskCategoryV3 _category;

	[SerializeField]
	private ActToggle _tab;

	[SerializeField]
	private LocalizedString _leftTitle;

	[NonSerialized]
	public UnityAction<bool> Handler;

	public TaskCategoryV3 Category => _category;

	public ActToggle Tab => _tab;

	public LocalizedString LeftTitle => _leftTitle;
}
