using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TaskCategoryGroupV3 : MonoBehaviour, ITaskPoolItemV3
{
	[SerializeField]
	private Image _background;

	[SerializeField]
	private LocalizeStringEvent _titleName;

	[SerializeField]
	private Transform _groupedMissionRoot;

	[SerializeField]
	private Transform _standaloneMissionRoot;

	[SerializeField]
	private List<TaskCategoryIconSettingV3> _categoryIcons = new List<TaskCategoryIconSettingV3>();

	[SerializeField]
	private List<TaskCategorySpriteSettingV3> _categorySprites = new List<TaskCategorySpriteSettingV3>();

	public TaskCategoryV3 Category { get; private set; }

	public Transform GroupedMissionRoot => _groupedMissionRoot;

	public Transform StandaloneMissionRoot => _standaloneMissionRoot;

	public void Bind(TaskCategoryV3 category)
	{
		Category = category;
		_titleName.StringReference = GetCategoryString(category);
		_background.sprite = GetCategorySprite(category);
		for (int i = 0; i < _categoryIcons.Count; i++)
		{
			TaskCategoryIconSettingV3 taskCategoryIconSettingV = _categoryIcons[i];
			taskCategoryIconSettingV.Icon.SetActive(taskCategoryIconSettingV.Category == category);
		}
	}

	public void Unbind()
	{
		_background.sprite = null;
		for (int i = 0; i < _categoryIcons.Count; i++)
		{
			_categoryIcons[i].Icon.SetActive(value: false);
		}
		Category = TaskCategoryV3.All;
	}

	private Sprite GetCategorySprite(TaskCategoryV3 category)
	{
		for (int i = 0; i < _categorySprites.Count; i++)
		{
			if (_categorySprites[i].Category == category)
			{
				return _categorySprites[i].Sprite;
			}
		}
		return null;
	}

	private LocalizedString GetCategoryString(TaskCategoryV3 category)
	{
		for (int i = 0; i < _categorySprites.Count; i++)
		{
			if (_categorySprites[i].Category == category)
			{
				return _categorySprites[i].Text;
			}
		}
		return null;
	}
}
