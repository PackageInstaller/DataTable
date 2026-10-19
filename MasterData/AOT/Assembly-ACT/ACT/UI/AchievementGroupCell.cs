using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.Battle;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AchievementGroupCell : LoopScrollBaseItem
{
	private const string HiddenAchievementText = "？？？";

	[SerializeField]
	private TextMeshProUGUI _achievementGroupText;

	[SerializeField]
	private TextMeshProUGUI _achievementGroupProcessText;

	[SerializeField]
	private ActButton _btn;

	[SerializeField]
	private GameObject _select;

	[SerializeField]
	private RedDotItem redDotItem;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private GamePadSelectComponent _gamePadSelect;

	private ImageAssetStation imageStation;

	private MonoAccomplishmentDetailsView view;

	private int typeId;

	private int groupId;

	private int viewInstanceId;

	private int groupListFillAnimationVersion;

	private static readonly Dictionary<int, int> ViewSelectedGroupMap = new Dictionary<int, int>();

	private void OnEnable()
	{
		MonoECS.instance?.onInputModeChange.AddListener(OnInputModeChanged);
		RefreshGamePadSelectState();
	}

	private void OnDisable()
	{
		InvalidateGroupListFillAnimation();
		MonoECS.instance?.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	public override void Hide()
	{
		InvalidateGroupListFillAnimation();
		base.Hide();
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		RefreshGamePadSelectState();
	}

	public static void SetSelectedGroupForView(int viewId, int selectedGroupId)
	{
		ViewSelectedGroupMap[viewId] = selectedGroupId;
	}

	public static void ClearSelectedGroupForView(int viewId)
	{
		ViewSelectedGroupMap.Remove(viewId);
	}

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		ResetGroupListFillAnimationState();
		if (_select != null)
		{
			_select.SetActive(value: false);
		}
		SetGamePadSelectState(isSelected: false);
		if (imageStation == null)
		{
			imageStation = GetComponentInParent<IBaseUIView>().Station;
		}
		AccomplishmentModel accomplishmentModel = Model<AccomplishmentModel>.Interface;
		if (accomplishmentModel == null)
		{
			return;
		}
		gameObject.SetActive(value: true);
		view = GetComponentInParent<MonoAccomplishmentDetailsView>();
		if (view == null)
		{
			return;
		}
		typeId = view.CurrentMainId;
		List<int> list = ((!view.IsSearching || string.IsNullOrEmpty(view.SearchText)) ? accomplishmentModel?.GetGroupIdsForMain(typeId) : accomplishmentModel?.GetSearchFilteredGroupIdsForMain(typeId, view.SearchText));
		if (list != null && list.Count > 0 && idx >= 0 && idx < list.Count)
		{
			groupId = list[idx];
			viewInstanceId = view.GetInstanceID();
			if (RuntimeConfigs.data.achievementGroups.TryGetValue(groupId, out var value))
			{
				_achievementGroupText.SetText(accomplishmentModel.HasRevealedContentName(groupId) ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.groupName) : "？？？");
			}
			if (!ViewSelectedGroupMap.ContainsKey(viewInstanceId))
			{
				ViewSelectedGroupMap[viewInstanceId] = list[0];
			}
			_achievementGroupProcessText.SetText(accomplishmentModel.GetGroupPercent(groupId));
			RefreshSelectState();
			_btn.SetBtnClick(RefreshRightAchievementList);
			SetRedDotStatus();
		}
	}

	private void SetRedDotStatus()
	{
		string text = string.Empty;
		switch (typeId)
		{
		case 1:
			text = $"{RedDotPathDefine.NewAccomplishmentTask}|GroupId|{groupId}";
			break;
		case 2:
			text = $"{RedDotPathDefine.NewAccomplishmentExplore}|GroupId|{groupId}";
			break;
		case 3:
			text = $"{RedDotPathDefine.NewAccomplishmentBattle}|GroupId|{groupId}";
			break;
		case 4:
			text = $"{RedDotPathDefine.NewAccomplishmentCultivate}|GroupId|{groupId}";
			break;
		case 5:
			text = $"{RedDotPathDefine.NewAccomplishmentOther}|GroupId|{groupId}";
			break;
		}
		Singleton<RedDotManager>.instance.SetLeafNodeActive(text, Model<AccomplishmentModel>.Interface.GroupHasClaimable(groupId));
		RedDotDisplayAction redDotDisplayAction = GetRedDotDisplayAction(groupId);
		if (text != "")
		{
			redDotItem.redDotType = RedDotType.Dot;
			redDotItem.fullPath = text.Split("|").ToList();
			redDotItem.displayAction = redDotDisplayAction;
			redDotItem.BindTrieNode();
			redDotItem.UpdateDisplay();
		}
	}

	private RedDotDisplayAction GetRedDotDisplayAction(int groupIdForRedDot)
	{
		return new AccomplishmentDetailsViewTabActive(groupIdForRedDot);
	}

	private void RefreshRightAchievementList()
	{
		if (!(view == null) && (!ViewSelectedGroupMap.TryGetValue(viewInstanceId, out var value) || value != groupId) && !view.ShouldSkipGroupSwitchRefill(groupId))
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Achive/Switch");
			int num = value;
			ViewSelectedGroupMap[viewInstanceId] = groupId;
			view.RefreshRightAchievementListWithTabAnimation(groupId);
			view.BeginGroupSelectionSwitchAnimation(num, groupId);
			view.RefreshGroupSelectionCellStates(num, groupId);
			view.EndGroupSelectionSwitchAnimation();
		}
	}

	private void RefreshSelectState()
	{
		if (view == null)
		{
			return;
		}
		if (!ViewSelectedGroupMap.TryGetValue(viewInstanceId, out var value))
		{
			value = groupId;
		}
		bool flag = groupId == value;
		if (_select != null)
		{
			_select.SetActive(flag);
		}
		SetGamePadSelectState(flag);
		if (!view.IsFillingGroupListAnimations && !(_betterAnimation == null) && view.TryGetGroupSelectionSwitchAnimation(out var fromGroupId, out var toGroupId))
		{
			if (groupId == toGroupId)
			{
				_betterAnimation.GetSequence("Select")?.Play();
			}
			else if (groupId == fromGroupId)
			{
				_betterAnimation.GetSequence("Normal")?.Play();
			}
		}
	}

	public void RefreshSelectStateForGroupSwitch()
	{
		RefreshSelectState();
	}

	private void RefreshGamePadSelectState()
	{
		bool flag = view != null && ViewSelectedGroupMap.TryGetValue(viewInstanceId, out var value) && groupId == value;
		int num;
		if (view != null && !view.inputTriggerInputField)
		{
			AccomplishmentDetailsViewInputController controller = view.GetController();
			num = ((controller != null && controller.ControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList) ? 1 : 0);
		}
		else
		{
			num = 0;
		}
		bool flag2 = (byte)num != 0;
		SetGamePadSelectState(flag & flag2);
	}

	public void RefreshGamepadInputState(MonoAccomplishmentDetailsView detailsView)
	{
		view = detailsView;
		RefreshGamePadSelectState();
	}

	public void HideGamepadSelectState()
	{
		SetGamePadSelectState(isSelected: false);
	}

	private void SetGamePadSelectState(bool isSelected)
	{
		if (!(_gamePadSelect == null))
		{
			_gamePadSelect.SetSelectState(isSelected && MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
	}

	public void PlayGroupListFillAnimation(float delaySeconds, CancellationToken token)
	{
		PlayGroupListFillAnimationAsync(delaySeconds, token, groupListFillAnimationVersion).Forget();
	}

	private async UniTaskVoid PlayGroupListFillAnimationAsync(float delaySeconds, CancellationToken token, int animationVersion)
	{
		if (_betterAnimation == null)
		{
			return;
		}
		bool desiredSelected = _select != null && _select.activeSelf;
		if (delaySeconds > 0f)
		{
			try
			{
				await UniTask.Delay(TimeSpan.FromSeconds(delaySeconds), ignoreTimeScale: true, PlayerLoopTiming.Update, token);
			}
			catch (OperationCanceledException)
			{
				return;
			}
		}
		if (IsGroupListFillAnimationCurrent(animationVersion, token) && !IsRecycledByLoop())
		{
			if (desiredSelected)
			{
				PlayGroupListFillAnimationSequence("SelectedShow", isSelected: true, animationVersion, token);
			}
			else
			{
				PlayGroupListFillAnimationSequence("NormalShow", isSelected: false, animationVersion, token);
			}
		}
	}

	private void InvalidateGroupListFillAnimation()
	{
		groupListFillAnimationVersion++;
		_betterAnimation?.StopAnimation();
	}

	private bool IsRecycledByLoop()
	{
		LayoutElement component = GetComponent<LayoutElement>();
		if (component != null)
		{
			return component.ignoreLayout;
		}
		return false;
	}

	private void ResetGroupListFillAnimationState()
	{
		InvalidateGroupListFillAnimation();
		if (!(_betterAnimation == null))
		{
			_betterAnimation.GetSequence("NormalShow")?.Complete();
		}
	}

	private bool IsGroupListFillAnimationCurrent(int animationVersion, CancellationToken token)
	{
		if (this != null && isActiveAndEnabled && !token.IsCancellationRequested)
		{
			return animationVersion == groupListFillAnimationVersion;
		}
		return false;
	}

	private void PlayGroupListFillAnimationSequence(string showSequenceName, bool isSelected, int animationVersion, CancellationToken token)
	{
		AnimationBuilder sequence = _betterAnimation.GetSequence(showSequenceName);
		if (sequence != null)
		{
			sequence.OnComplete((AnimationBuilder _) =>
			{
				if (IsGroupListFillAnimationCurrent(animationVersion, token) && _select != null)
				{
					_select.SetActive(isSelected);
				}
			}).Play();
		}
		else if (IsGroupListFillAnimationCurrent(animationVersion, token) && _select != null)
		{
			_select.SetActive(isSelected);
		}
	}
}
