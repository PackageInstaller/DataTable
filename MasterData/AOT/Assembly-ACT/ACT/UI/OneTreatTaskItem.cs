using System;
using ACT.Battle;
using ACT.Utility;
using ACT.ViewControl;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class OneTreatTaskItem : LoopScrollBaseItem, ISubmitHandler, IEventSystemHandler
{
	[SerializeField]
	private TMP_Text taskNameText;

	[SerializeField]
	private LocalizeStringEvent taskNameLocalize;

	[SerializeField]
	private CommonNumberComponent progressNumber;

	[SerializeField]
	private ItemUIComponentBase rewardItem;

	[SerializeField]
	private ActButton receiveButton;

	[SerializeField]
	private ActButton gotoButton;

	[SerializeField]
	private TMP_Text completeText;

	[SerializeField]
	private OperateBtnPrompt confirmPrompt;

	[SerializeField]
	private OperateBtnPrompt rewardDetailPrompt;

	private SelectionUGUI selectionUGUI;

	private OneTreatTaskInfo _taskInfo;

	private Action<OneTreatTaskInfo> _onReceive;

	private Action<OneTreatTaskInfo> _onGoto;

	private bool _componentsCached;

	private bool _selected;

	public OneTreatTaskInfo TaskInfo => _taskInfo;

	public int TaskIndex { get; private set; } = -1;

	public void SetData(OneTreatTaskInfo taskInfo, Action<OneTreatTaskInfo> onReceive, Action<OneTreatTaskInfo> onGoto, int taskIndex = -1)
	{
		CacheComponents();
		_taskInfo = taskInfo;
		_onReceive = onReceive;
		_onGoto = onGoto;
		TaskIndex = taskIndex;
		RefreshTaskName();
		RefreshProgress();
		RefreshReward();
		RefreshState();
	}

	public void SetSelected(bool selected)
	{
		CacheComponents();
		_selected = selected;
		RefreshOperatePrompts();
		RefreshSelectionUGUI();
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (_taskInfo != null && !TrySubmitButton(receiveButton, eventData))
		{
			TrySubmitButton(gotoButton, eventData);
		}
	}

	private void CacheComponents()
	{
		if (!_componentsCached)
		{
			_componentsCached = true;
			selectionUGUI = GetComponent<SelectionUGUI>();
			ConfigurePrompt(confirmPrompt, "UI/Confirm");
			ConfigurePrompt(rewardDetailPrompt, "UI/SelectItemCell");
		}
	}

	private void RefreshTaskName()
	{
		int valueOrDefault = (_taskInfo?.ChallengeData?.challengeText).GetValueOrDefault();
		if (valueOrDefault == 0)
		{
			if (taskNameText != null)
			{
				taskNameText.text = string.Empty;
			}
			return;
		}
		if (taskNameLocalize != null)
		{
			taskNameLocalize.StringReference.TableReference = LocalizationUtility.localizeTableName_longcommon;
			taskNameLocalize.StringReference.TableEntryReference = valueOrDefault;
		}
		if (taskNameText != null)
		{
			taskNameText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, valueOrDefault);
		}
	}

	private void RefreshProgress()
	{
		if (!(progressNumber == null) && _taskInfo != null)
		{
			int num = Mathf.Max(1, _taskInfo.TargetProgress);
			int num2 = Mathf.Clamp(_taskInfo.CurrentProgress, 0, num);
			progressNumber.UpdateNumber(num2, num);
		}
	}

	private void RefreshReward()
	{
		if (!(rewardItem == null))
		{
			bool flag = _taskInfo?.DisplayReward != null;
			SetActiveIfChanged(rewardItem.gameObject, flag);
			if (flag)
			{
				rewardItem.Station = Station;
				rewardItem.SetData(_taskInfo.DisplayReward, _taskInfo.DisplayReward.Count, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				rewardItem.UpdatePerformance();
			}
		}
	}

	private void RefreshState()
	{
		if (_taskInfo == null)
		{
			SetActiveIfChanged(receiveButton?.gameObject, active: false);
			SetActiveIfChanged(gotoButton?.gameObject, active: false);
			SetActiveIfChanged(completeText?.gameObject, active: false);
			RefreshOperatePrompts();
			return;
		}
		bool active = _taskInfo.State == OneTreatTaskState.CanReceive;
		bool active2 = _taskInfo.State == OneTreatTaskState.Unfinished;
		bool active3 = _taskInfo.State == OneTreatTaskState.Received;
		SetActiveIfChanged(receiveButton?.gameObject, active);
		SetActiveIfChanged(gotoButton?.gameObject, active2);
		SetActiveIfChanged(completeText?.gameObject, active3);
		if (receiveButton != null)
		{
			receiveButton.Interactable(active);
			receiveButton.SetBtnClick(() =>
			{
				_onReceive?.Invoke(_taskInfo);
			});
			SetButtonText(receiveButton, "领取");
		}
		if (gotoButton != null)
		{
			gotoButton.Interactable(active2);
			gotoButton.SetBtnClick(() =>
			{
				_onGoto?.Invoke(_taskInfo);
			});
			SetButtonText(gotoButton, "前往");
		}
		RefreshOperatePrompts();
	}

	private void OnDisable()
	{
		_selected = false;
		RefreshOperatePrompts();
		RefreshSelectionUGUI();
	}

	private void RefreshOperatePrompts()
	{
		bool flag = _taskInfo != null && (_taskInfo.State == OneTreatTaskState.CanReceive || _taskInfo.State == OneTreatTaskState.Unfinished);
		bool flag2 = _taskInfo?.DisplayReward != null;
		SetPromptVisible(confirmPrompt, _selected & flag);
		SetPromptVisible(rewardDetailPrompt, _selected & flag2);
	}

	private void RefreshSelectionUGUI()
	{
		if (!(selectionUGUI == null))
		{
			bool flag = _selected && gameObject.activeInHierarchy && MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
			if (selectionUGUI.gamePadArrow != null)
			{
				selectionUGUI.gamePadArrow.SetActive(flag);
				selectionUGUI.gamePadArrow.transform.localScale = (flag ? Vector3.one : Vector3.zero);
			}
			if (_selected && gameObject.activeInHierarchy)
			{
				selectionUGUI.ScrollTargetToShow(transform);
			}
		}
	}

	private static void SetButtonText(ActButton button, string text)
	{
		if (!(button == null))
		{
			TMP_Text componentInChildren = button.GetComponentInChildren<TMP_Text>(includeInactive: true);
			if (componentInChildren != null)
			{
				componentInChildren.text = text;
			}
		}
	}

	private static void SetActiveIfChanged(GameObject target, bool active)
	{
		if (target != null && target.activeSelf != active)
		{
			target.SetActive(active);
		}
	}

	private static bool TrySubmitButton(ActButton button, BaseEventData eventData)
	{
		if (!IsButtonAvailable(button))
		{
			return false;
		}
		button.OnSubmit(eventData);
		return true;
	}

	private static bool IsButtonAvailable(ActButton button)
	{
		if (button != null && button.gameObject.activeInHierarchy)
		{
			return button.IsInteractable();
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
}
