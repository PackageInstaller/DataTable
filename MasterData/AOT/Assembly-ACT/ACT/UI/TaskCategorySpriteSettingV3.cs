using System;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.UI;

[Serializable]
public sealed class TaskCategorySpriteSettingV3
{
	[SerializeField]
	private TaskCategoryV3 _category;

	[SerializeField]
	private Sprite _sprite;

	[SerializeField]
	private LocalizedString _text;

	public TaskCategoryV3 Category => _category;

	public Sprite Sprite => _sprite;

	public LocalizedString Text => _text;
}
