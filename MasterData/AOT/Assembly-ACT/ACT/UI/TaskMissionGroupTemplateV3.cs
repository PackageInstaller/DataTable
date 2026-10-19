using System;
using System.Collections.Generic;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TaskMissionGroupTemplateV3 : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent _titleText;

	[SerializeField]
	private LocalizeStringEvent _chapterText;

	[SerializeField]
	private Image _background;

	[SerializeField]
	private GameObject _selectedStyle;

	[SerializeField]
	private GameObject _normalStyle;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private CanvasGroup _canvasGroup;

	[SerializeField]
	private List<TaskMissionGroupSpriteSettingV3> _sprites = new List<TaskMissionGroupSpriteSettingV3>();

	public TaskAnimationTargetV3 AnimationTarget => new TaskAnimationTargetV3(_canvasGroup, PlayNormalShow);

	public void Bind(TaskCategoryV3 category, int titleId, int chapterSubtitleId)
	{
		TaskMissionGroupSpriteSettingV3 spriteSetting = GetSpriteSetting(category);
		StopAnimation();
		SetSelected(selected: false, playAnimation: false);
		_background.sprite = spriteSetting.BackgroundSprite;
		_titleText.StringReference.TableReference = LocalizationUtility.localizeTableName_shortcommon;
		_chapterText.StringReference.TableReference = LocalizationUtility.localizeTableName_shortcommon;
		_titleText.StringReference.TableEntryReference = titleId;
		_chapterText.StringReference.TableEntryReference = chapterSubtitleId;
		_titleText.RefreshString();
		_chapterText.RefreshString();
	}

	public void Unbind()
	{
		StopAnimation();
		SetSelected(selected: false, playAnimation: false);
		_background.sprite = null;
		_titleText.StringReference.TableReference = null;
		_chapterText.StringReference.TableReference = null;
		_titleText.StringReference.TableEntryReference = null;
		_chapterText.StringReference.TableEntryReference = null;
		_titleText.RefreshString();
		_chapterText.RefreshString();
	}

	public void SetSelected(bool selected, bool playAnimation)
	{
		if (_normalStyle == _selectedStyle)
		{
			_normalStyle.SetActive(value: true);
		}
		else
		{
			_selectedStyle.SetActive(selected);
			_normalStyle.SetActive(!selected);
		}
		_ = playAnimation & selected;
	}

	public void StopAnimation()
	{
		_betterAnimation.StopAnimation();
	}

	public bool PlayNormalShow()
	{
		AnimationBuilder sequence = _betterAnimation.GetSequence("NormalShow");
		if (sequence == null)
		{
			return false;
		}
		sequence.Play();
		return true;
	}

	private TaskMissionGroupSpriteSettingV3 GetSpriteSetting(TaskCategoryV3 category)
	{
		for (int i = 0; i < _sprites.Count; i++)
		{
			if (_sprites[i].Category == category)
			{
				return _sprites[i];
			}
		}
		throw new InvalidOperationException($"任务组模板缺少分类 {category} 的 Sprite 配置。");
	}
}
