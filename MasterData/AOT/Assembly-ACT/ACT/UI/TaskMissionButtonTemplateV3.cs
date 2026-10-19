using System;
using System.Collections.Generic;
using ACT.Utility;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TaskMissionButtonTemplateV3 : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	[SerializeField]
	private LocalizeStringEvent _normalTitle;

	[SerializeField]
	private LocalizeStringEvent _selectedTitle;

	[SerializeField]
	private Image _background;

	[SerializeField]
	private GameObject _normalStyle;

	[SerializeField]
	private GameObject _hoverStyle;

	[SerializeField]
	private GameObject _selectedStyle;

	[SerializeField]
	private GameObject _traceRoot;

	[SerializeField]
	private Image _traceBackground;

	[SerializeField]
	private GameObject _blockedRoot;

	[SerializeField]
	private Image _blockedBackground;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private CanvasGroup _canvasGroup;

	[SerializeField]
	private List<TaskMissionButtonSpriteSettingV3> _sprites = new List<TaskMissionButtonSpriteSettingV3>();

	public TaskAnimationTargetV3 AnimationTarget => new TaskAnimationTargetV3(_canvasGroup, PlayNormalShow);

	private void OnDisable()
	{
		SetHovered(hovered: false);
	}

	public void Bind(TaskCategoryV3 category, int titleId)
	{
		TaskMissionButtonSpriteSettingV3 spriteSetting = GetSpriteSetting(category);
		StopAnimation();
		SetSelected(selected: false, playAnimation: false);
		SetHovered(hovered: false);
		SetTracing(tracing: false);
		SetBlocked(blocked: false);
		_background.sprite = spriteSetting.BackgroundSprite;
		_traceBackground.sprite = spriteSetting.TraceSprite;
		_normalTitle.StringReference.TableReference = LocalizationUtility.localizeTableName_shortcommon;
		_selectedTitle.StringReference.TableReference = LocalizationUtility.localizeTableName_shortcommon;
		_normalTitle.StringReference.TableEntryReference = titleId;
		_selectedTitle.StringReference.TableEntryReference = titleId;
		_normalTitle.RefreshString();
		_selectedTitle.RefreshString();
	}

	public void Unbind()
	{
		StopAnimation();
		SetSelected(selected: false, playAnimation: false);
		SetHovered(hovered: false);
		SetTracing(tracing: false);
		SetBlocked(blocked: false);
		_background.sprite = null;
		_traceBackground.sprite = null;
		_normalTitle.StringReference.TableReference = null;
		_selectedTitle.StringReference.TableReference = null;
		_normalTitle.StringReference.TableEntryReference = null;
		_selectedTitle.StringReference.TableEntryReference = null;
		_normalTitle.RefreshString();
		_selectedTitle.RefreshString();
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
			_normalStyle.SetActive(value: true);
		}
		if (playAnimation & selected)
		{
			_betterAnimation.GetSequence("SelectedShow")?.Play();
		}
	}

	public void SetTracing(bool tracing)
	{
		_traceRoot.SetActive(tracing);
	}

	public void SetBlocked(bool blocked)
	{
		_blockedRoot.SetActive(blocked);
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		SetHovered(hovered: true);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		SetHovered(hovered: false);
	}

	private void SetHovered(bool hovered)
	{
		_hoverStyle.SetActive(hovered);
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

	private TaskMissionButtonSpriteSettingV3 GetSpriteSetting(TaskCategoryV3 category)
	{
		for (int i = 0; i < _sprites.Count; i++)
		{
			if (_sprites[i].Category == category)
			{
				return _sprites[i];
			}
		}
		throw new InvalidOperationException($"任务按钮模板缺少分类 {category} 的 Sprite 配置。");
	}
}
