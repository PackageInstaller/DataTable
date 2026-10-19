using System;
using System.Text.RegularExpressions;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class AchievementContentCell : LoopScrollBaseItem
{
	private const string HiddenAchievementText = "？？？";

	private const int HiddenAchievementDescriptionId = 2904;

	[SerializeField]
	private BImage bg;

	[SerializeField]
	private BImage labelIcon;

	[SerializeField]
	private TextMeshProUGUI _nameText;

	[SerializeField]
	private TextMeshProUGUI _descText;

	[SerializeField]
	private LiteItemUIComponent _itemUIComponent;

	[SerializeField]
	private ActButton _btnReward;

	[SerializeField]
	private GameObject _processingRoot;

	[SerializeField]
	private TextMeshProUGUI _achievementProcessText;

	[SerializeField]
	private GameObject _ClaimedRoot;

	[SerializeField]
	private TextMeshProUGUI _completeTimeText;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private GamePadSelectComponent _gamePadSelect;

	[SerializeField]
	private OperateBtnPrompt operateBtnPromptA;

	[SerializeField]
	private OperateBtnPrompt operateBtnPromptPressLeftStick;

	private RectTransform _showContentRect;

	private CanvasGroup _showContentCanvasGroup;

	private ImageAssetStation imageStation;

	private int typeId;

	private int groupId;

	private int achievementId;

	private bool _gamepadInputInited;

	private int _showAnimationVersion;

	private const string SearchHighlightColor = "#ffc561";

	private const float ShowAnimationStartX = 70f;

	private const float ShowAnimationStartAlpha = 0f;

	private const float ShowAnimationFinalX = 20f;

	private const float ShowAnimationFinalAlpha = 1f;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		if (imageStation == null)
		{
			imageStation = GetComponentInParent<IBaseUIView>()?.Station;
		}
		AccomplishmentModel accomplishmentModel = Model<AccomplishmentModel>.Interface;
		if (accomplishmentModel == null)
		{
			return;
		}
		MonoAccomplishmentDetailsView componentInParent = GetComponentInParent<MonoAccomplishmentDetailsView>();
		if (componentInParent == null)
		{
			return;
		}
		groupId = componentInParent.CurrSelectedGroupId;
		if (groupId == 0)
		{
			return;
		}
		if (!componentInParent.TryGetCurrentAchievementContentId(idx, out achievementId))
		{
			gameObject.SetActive(value: false);
		}
		else
		{
			if (!accomplishmentModel.TryGetContent(achievementId, out var content))
			{
				return;
			}
			gameObject.SetActive(value: true);
			typeId = accomplishmentModel.GetMainIdForContent(achievementId);
			bool flag = accomplishmentModel.GetContentProgressPercentValue(achievementId) <= 0f;
			if (_nameText != null)
			{
				if (flag)
				{
					_nameText.SetText("？？？");
				}
				else
				{
					string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, content.groupName);
					_nameText.SetText((componentInParent.IsSearching && !string.IsNullOrEmpty(componentInParent.SearchText)) ? ApplySearchHighlight(localizeString, componentInParent.SearchText) : localizeString);
				}
			}
			if (_descText != null)
			{
				if (flag)
				{
					_descText.SetText(LocalizationUtility.GetLocalizeString("Common", 2904));
				}
				else
				{
					string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, content.description);
					_descText.SetText((componentInParent.IsSearching && !string.IsNullOrEmpty(componentInParent.SearchText)) ? ApplySearchHighlight(localizeString2, componentInParent.SearchText) : localizeString2);
				}
			}
			if (imageStation != null)
			{
				if (bg != null)
				{
					imageStation.LoadImageAsync(205, Mathf.Clamp(content.level, 1, 3), bg).Forget();
				}
				if (flag)
				{
					if (labelIcon != null && typeId != 0)
					{
						imageStation.LoadImageAsync(206, typeId * 10 + 4, labelIcon).Forget();
					}
				}
				else if (labelIcon != null && typeId != 0)
				{
					imageStation.LoadImageAsync(206, typeId * 10 + content.level, labelIcon).Forget();
				}
			}
			BindReward(accomplishmentModel, content);
			RefreshState(accomplishmentModel);
			RefreshGamepadInputState(componentInParent);
		}
	}

	private void BindReward(AccomplishmentModel model, AchievementContents content)
	{
		if (!(_itemUIComponent == null))
		{
			if (!Model<AccomplishmentModel>.Interface.HasReward(content))
			{
				_itemUIComponent.gameObject.SetActive(value: false);
				return;
			}
			ItemKv itemKv = content.achievementsRewards[0];
			_itemUIComponent.gameObject.SetActive(value: true);
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count);
			_itemUIComponent.SetData(item, long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			_itemUIComponent.UpdatePerformance();
			_itemUIComponent.showDetailPanel = true;
			_itemUIComponent.IsComplete = model.GetRowState(achievementId) == AccomplishmentRowState.Claimed;
		}
	}

	private void RefreshState(AccomplishmentModel model)
	{
		AccomplishmentRowState rowState = model.GetRowState(achievementId);
		if (_btnReward != null)
		{
			bool active = rowState == AccomplishmentRowState.Claimable;
			_btnReward.gameObject.SetActive(active);
			_btnReward.SetBtnClick(() =>
			{
				model.ClaimAllInCurrentGroupAsync(groupId).Forget();
			});
		}
		if (_processingRoot != null)
		{
			_processingRoot.SetActive(rowState == AccomplishmentRowState.InProgress);
		}
		if (_achievementProcessText != null)
		{
			bool flag = rowState == AccomplishmentRowState.InProgress;
			_achievementProcessText.gameObject.SetActive(flag);
			if (flag)
			{
				_achievementProcessText.SetText(model.GetProgressCounterText(achievementId));
			}
		}
		if (_ClaimedRoot != null)
		{
			_ClaimedRoot.SetActive(rowState == AccomplishmentRowState.Claimed);
		}
		if (_completeTimeText != null)
		{
			_completeTimeText.SetText((rowState == AccomplishmentRowState.Claimed) ? model.GetCompleteTimeText(achievementId) : string.Empty);
		}
		if (_itemUIComponent != null && _itemUIComponent.gameObject.activeSelf)
		{
			_itemUIComponent.IsComplete = rowState == AccomplishmentRowState.Claimed;
		}
	}

	public void RefreshGamepadInputState(MonoAccomplishmentDetailsView view)
	{
		InitGamepadInput();
		bool num = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		bool flag = view?.GetController()?.ControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.AchieveContentList;
		bool flag2 = (num & flag) && IsCurrentSelectedCell();
		bool flag3 = IsClaimable();
		_gamePadSelect?.SetSelectState(flag2);
		SetPromptVisible(operateBtnPromptA, flag2 & flag3);
		SetPromptVisible(operateBtnPromptPressLeftStick, flag2 && HasRewardItem());
	}

	public bool TryClaimReward()
	{
		if (!IsClaimable())
		{
			return false;
		}
		AccomplishmentModel accomplishmentModel = Model<AccomplishmentModel>.Interface;
		if (accomplishmentModel == null)
		{
			return false;
		}
		accomplishmentModel.ClaimAllInCurrentGroupAsync(groupId).Forget();
		RefreshState(accomplishmentModel);
		return true;
	}

	public bool OpenRewardItemDetail()
	{
		if (!HasRewardItem())
		{
			return false;
		}
		ExecuteEvents.Execute(_itemUIComponent.gameObject, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
		{
			handler.OnSubmit(data);
		});
		return true;
	}

	public void ClearRewardItemGamepadSelection()
	{
		if (!(_itemUIComponent == null))
		{
			_itemUIComponent.IsHighLight = false;
			if (EventSystemHelper.CurrentSelected == _itemUIComponent.gameObject)
			{
				ACT.ViewControl.SelectableEx componentInChildren = GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
				EventSystemHelper.SetSelectedGameObject((componentInChildren != null) ? componentInChildren.gameObject : gameObject);
			}
		}
	}

	private void InitGamepadInput()
	{
		if (!_gamepadInputInited)
		{
			_gamepadInputInited = true;
			ConfigurePrompt(operateBtnPromptA, "UI/Confirm");
			ConfigurePrompt(operateBtnPromptPressLeftStick, "UI/SelectItemCell");
		}
	}

	private bool IsClaimable()
	{
		AccomplishmentModel accomplishmentModel = Model<AccomplishmentModel>.Interface;
		if (accomplishmentModel != null)
		{
			return accomplishmentModel.GetRowState(achievementId) == AccomplishmentRowState.Claimable;
		}
		return false;
	}

	private bool HasRewardItem()
	{
		if (_itemUIComponent != null)
		{
			return _itemUIComponent.gameObject.activeSelf;
		}
		return false;
	}

	private bool IsCurrentSelectedCell()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			return currentSelected.GetComponentInParent<AchievementContentCell>(includeInactive: true) == this;
		}
		return false;
	}

	private static void ConfigurePrompt(OperateBtnPrompt prompt, string bindingAction)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(bindingAction);
			prompt.SetVisible(vis: false);
			prompt.RefreshIcon();
		}
	}

	private static void SetPromptVisible(OperateBtnPrompt prompt, bool visible)
	{
		if (!(prompt == null))
		{
			prompt.SetVisible(visible);
			if (visible)
			{
				prompt.RefreshIcon();
			}
		}
	}

	private static string ApplySearchHighlight(string source, string keyword)
	{
		if (string.IsNullOrEmpty(source) || string.IsNullOrEmpty(keyword))
		{
			return source;
		}
		try
		{
			string text = keyword.Trim();
			if (text.Length == 0)
			{
				return source;
			}
			return Regex.Replace(source, Regex.Escape(text), (Match m) => "<color=#ffc561>" + m.Value + "</color>", RegexOptions.IgnoreCase);
		}
		catch
		{
			return source;
		}
	}

	public void PlayShowAnimation(float delaySeconds, CancellationToken token)
	{
		int version = ResetShowAnimationState();
		PlayShowAnimationAsync(delaySeconds, token, version).Forget();
	}

	public int ResetShowAnimationState()
	{
		_showAnimationVersion++;
		_betterAnimation?.StopAnimation();
		if (_showContentRect == null)
		{
			_showContentRect = transform.Find("content") as RectTransform;
		}
		if (_showContentCanvasGroup == null && _showContentRect != null)
		{
			_showContentCanvasGroup = _showContentRect.GetComponent<CanvasGroup>();
		}
		if (_showContentRect != null)
		{
			Vector2 anchoredPosition = _showContentRect.anchoredPosition;
			anchoredPosition.x = 70f;
			_showContentRect.anchoredPosition = anchoredPosition;
		}
		if (_showContentCanvasGroup != null)
		{
			_showContentCanvasGroup.alpha = 0f;
		}
		return _showAnimationVersion;
	}

	public void SetShowAnimationFinalState()
	{
		_showAnimationVersion++;
		_betterAnimation?.StopAnimation();
		if (_showContentRect == null)
		{
			_showContentRect = transform.Find("content") as RectTransform;
		}
		if (_showContentCanvasGroup == null && _showContentRect != null)
		{
			_showContentCanvasGroup = _showContentRect.GetComponent<CanvasGroup>();
		}
		if (_showContentRect != null)
		{
			Vector2 anchoredPosition = _showContentRect.anchoredPosition;
			anchoredPosition.x = 20f;
			_showContentRect.anchoredPosition = anchoredPosition;
		}
		if (_showContentCanvasGroup != null)
		{
			_showContentCanvasGroup.alpha = 1f;
		}
	}

	public void SetShowAnimationFinalStateIfCurrent(int version)
	{
		if (version == _showAnimationVersion)
		{
			SetShowAnimationFinalState();
		}
	}

	private async UniTaskVoid PlayShowAnimationAsync(float delaySeconds, CancellationToken token, int version)
	{
		if (_betterAnimation == null)
		{
			SetShowAnimationFinalState();
			return;
		}
		if (delaySeconds > 0f)
		{
			try
			{
				await UniTask.Delay(TimeSpan.FromSeconds(delaySeconds), ignoreTimeScale: true, PlayerLoopTiming.Update, token);
			}
			catch (OperationCanceledException)
			{
				SetShowAnimationFinalStateIfCurrent(version);
				return;
			}
		}
		if (token.IsCancellationRequested)
		{
			SetShowAnimationFinalStateIfCurrent(version);
		}
		else if (version == _showAnimationVersion)
		{
			_betterAnimation.GetSequence("Show")?.Play();
		}
	}
}
