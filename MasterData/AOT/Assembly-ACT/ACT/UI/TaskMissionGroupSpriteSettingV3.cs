using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public sealed class TaskMissionGroupSpriteSettingV3
{
	[SerializeField]
	private TaskCategoryV3 _category;

	[SerializeField]
	private Sprite _backgroundSprite;

	public TaskCategoryV3 Category => _category;

	public Sprite BackgroundSprite => _backgroundSprite;
}
