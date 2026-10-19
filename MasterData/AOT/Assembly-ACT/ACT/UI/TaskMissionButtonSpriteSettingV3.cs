using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public sealed class TaskMissionButtonSpriteSettingV3
{
	[SerializeField]
	private TaskCategoryV3 _category;

	[SerializeField]
	private Sprite _backgroundSprite;

	[SerializeField]
	private Sprite _traceSprite;

	public TaskCategoryV3 Category => _category;

	public Sprite BackgroundSprite => _backgroundSprite;

	public Sprite TraceSprite => _traceSprite;
}
