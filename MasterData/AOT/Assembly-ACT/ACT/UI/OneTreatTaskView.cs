using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.Net;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using Fundamental;
using Pb;
using Runtime.UI.CommonComponent;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI;

public class OneTreatTaskView : BaseUIView<OneTreatTaskInputController>
{
	[SerializeField]
	private LoopVerticalScrollRect taskLoop;

	[SerializeField]
	private TMP_Text refreshTitle;

	[SerializeField]
	private CommonCoinComponent taskCurrency;

	[SerializeField]
	private OperateBtnPrompt taskCurrencyDetailPrompt;

	[SerializeField]
	private ActButton closeBtn;

	private OneTreatTaskViewData m_data;

	private ActivityCenterData _activityCenterData;

	private ActivityData _activityData;

	private readonly List<OneTreatTaskInfo> _tasks = new List<OneTreatTaskInfo>();

	private int _selectedTaskIndex = -1;

	private bool _rewardRequesting;

	private int ActivityId
	{
		get
		{
			if (m_data != null && m_data.ActivityId > 0)
			{
				return m_data.ActivityId;
			}
			return Model<ActivityCenterModel>.Interface.SelectActivityId;
		}
	}

	protected override void Init()
	{
		base.Init();
		m_data = (uiViewData as OneTreatTaskViewData) ?? new OneTreatTaskViewData();
		BindActButtonAction();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += OnTaskProgressChange;
		RefreshActivityData();
		RefreshTaskList();
		RefreshTaskCurrency();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
	}

	private void BindActButtonAction()
	{
		closeBtn.SetBtnClick(Close);
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (taskLoop != null)
		{
			taskLoop.OnItemShow.RemoveListener(OnTaskItemShow);
			taskLoop.ClearCells();
		}
		ReleaseTaskRewards();
		_tasks.Clear();
		_activityCenterData = null;
		_activityData = null;
		_selectedTaskIndex = -1;
		_rewardRequesting = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= OnTaskProgressChange;
	}

	private void OnActivityUpdate(BaseEventContent content)
	{
		if (content is ActivityCenterInfo activityCenterInfo && activityCenterInfo.activityId == ActivityId)
		{
			RefreshActivityData();
			RefreshTaskList();
			RefreshTaskCurrency();
		}
	}

	private void OnTaskProgressChange(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		RefreshTaskList();
	}

	private void RefreshActivityData()
	{
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(ActivityId);
		_activityData = _activityCenterData?.StaticActivityData;
		if (_activityData == null && ActivityId > 0)
		{
			_activityData = CoreUtils.GetData(ActivityId, RuntimeConfigs.data.activityDatas);
		}
	}

	private void RefreshTaskList()
	{
		ReleaseTaskRewards();
		_tasks.Clear();
		BuildTaskList();
		SortTaskList();
		RefreshLoop();
	}

	private void RefreshTaskCurrency()
	{
		if (taskCurrency == null)
		{
			RefreshOperatePrompts();
			return;
		}
		int taskCurrencyItemId = GetTaskCurrencyItemId();
		if (taskCurrencyItemId > 0)
		{
			taskCurrency.InitData(taskCurrencyItemId, IsBagItem(taskCurrencyItemId));
		}
		taskCurrency.Initialize();
		RefreshOperatePrompts();
	}

	private int GetTaskCurrencyItemId()
	{
		return OneTreatConfigUtility.GetTicketItemId(_activityData);
	}

	private static bool IsBagItem(int itemId)
	{
		foreach (PlayerAttribute value in Enum.GetValues(typeof(PlayerAttribute)))
		{
			if (value == (PlayerAttribute)itemId)
			{
				return false;
			}
		}
		return true;
	}

	private void BuildTaskList()
	{
		if (_activityData?.activityChallengGroup == null)
		{
			return;
		}
		int num = 0;
		int[] activityChallengGroup = _activityData.activityChallengGroup;
		foreach (int num2 in activityChallengGroup)
		{
			ActivityChallengeGroup data = CoreUtils.GetData(num2, RuntimeConfigs.data.activityChallengeGroups);
			if (data?.challengeId == null)
			{
				continue;
			}
			int[] challengeId = data.challengeId;
			foreach (int num3 in challengeId)
			{
				ActivityChallengeData data2 = CoreUtils.GetData(num3, RuntimeConfigs.data.activityChallengeDatas);
				if (data2 != null)
				{
					int targetProgress = GetTargetProgress(data2);
					int currentProgress = GetCurrentProgress(data2, targetProgress);
					OneTreatTaskState taskState = GetTaskState(data2, currentProgress, targetProgress);
					_tasks.Add(new OneTreatTaskInfo
					{
						ActivityId = ActivityId,
						ChallengeGroupId = num2,
						ChallengeId = num3,
						SortIndex = num,
						ChallengeData = data2,
						DisplayReward = CreateDisplayReward(data2),
						CurrentProgress = ((taskState == OneTreatTaskState.Received) ? targetProgress : currentProgress),
						TargetProgress = targetProgress,
						State = taskState
					});
					num++;
				}
			}
		}
	}

	private int GetTargetProgress(ActivityChallengeData challengeData)
	{
		return Mathf.Max(1, challengeData?.times ?? 1);
	}

	private int GetCurrentProgress(ActivityChallengeData challengeData, int targetProgress)
	{
		if (challengeData != null && Model<ActivityCenterModel>.Interface.GetActivityChallengeIsComplete(challengeData.id))
		{
			return targetProgress;
		}
		return 0;
	}

	private OneTreatTaskState GetTaskState(ActivityChallengeData challengeData, int currentProgress, int targetProgress)
	{
		if (challengeData != null && Model<ActivityCenterModel>.Interface.GetOneTreatTaskRewardReceivedState(challengeData.id))
		{
			return OneTreatTaskState.Received;
		}
		if (challengeData != null && Model<ActivityCenterModel>.Interface.GetActivityChallengeIsComplete(challengeData.id))
		{
			return OneTreatTaskState.CanReceive;
		}
		if (currentProgress >= targetProgress)
		{
			return OneTreatTaskState.CanReceive;
		}
		return OneTreatTaskState.Unfinished;
	}

	private ItemUnifierProxy CreateDisplayReward(ActivityChallengeData challengeData)
	{
		ItemKv firstChallengeReward = OneTreatConfigUtility.GetFirstChallengeReward(challengeData);
		if (firstChallengeReward != null && firstChallengeReward.id > 0)
		{
			return ItemUnifierProxy.ItemUnifierPool.Get<Item>(firstChallengeReward.id, Mathf.Max(1, firstChallengeReward.count));
		}
		return null;
	}

	private void SortTaskList()
	{
		_tasks.Sort((OneTreatTaskInfo left, OneTreatTaskInfo right) =>
		{
			int num = GetStateSortOrder(left.State).CompareTo(GetStateSortOrder(right.State));
			return (num != 0) ? num : left.SortIndex.CompareTo(right.SortIndex);
		});
	}

	private int GetStateSortOrder(OneTreatTaskState state)
	{
		return state switch
		{
			OneTreatTaskState.CanReceive => 0, 
			OneTreatTaskState.Unfinished => 1, 
			OneTreatTaskState.Received => 2, 
			_ => 3, 
		};
	}

	private void RefreshLoop()
	{
		if (!(taskLoop == null))
		{
			taskLoop.OnItemShow.RemoveListener(OnTaskItemShow);
			taskLoop.OnItemShow.AddListener(OnTaskItemShow);
			taskLoop.ClearCells();
			taskLoop.totalCount = _tasks.Count;
			taskLoop.RefillCells();
			RefreshVisibleTaskPrompts();
		}
	}

	public void OnControllerActivate()
	{
		_selectedTaskIndex = -1;
		ClearEventSystemSelection();
		StopTaskLoopMovement();
		RefreshOperatePrompts();
		RefreshVisibleTaskPrompts();
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		ClearEventSystemSelection();
		StopTaskLoopMovement();
		if (_tasks.Count == 0 || (dir != MoveDirection.Up && dir != MoveDirection.Down))
		{
			return;
		}
		if (_selectedTaskIndex < 0)
		{
			SelectTask((dir == MoveDirection.Up) ? (_tasks.Count - 1) : 0);
			return;
		}
		int num = _selectedTaskIndex + ((dir != MoveDirection.Up) ? 1 : (-1));
		if (num >= 0 && num < _tasks.Count && num != _selectedTaskIndex)
		{
			SelectTask(num);
		}
	}

	private static void ClearEventSystemSelection()
	{
		if (EventSystemHelper.Available && EventSystemHelper.CurrentSelected != null)
		{
			EventSystemHelper.SetSelectedGameObject(null);
		}
	}

	private void StopTaskLoopMovement()
	{
		taskLoop?.StopMovement();
	}

	public void HandleConfirm()
	{
		if (_tasks.Count != 0)
		{
			if (_selectedTaskIndex < 0)
			{
				SelectTask(0);
			}
			else
			{
				SubmitSelectedTask();
			}
		}
	}

	public void HandleBack()
	{
		Close();
	}

	public void OpenSelectedRewardDetail()
	{
		if (_tasks.Count == 0)
		{
			return;
		}
		if (_selectedTaskIndex < 0)
		{
			SelectTask(0);
			return;
		}
		OneTreatTaskInfo selectedTaskInfo = GetSelectedTaskInfo();
		if (selectedTaskInfo?.DisplayReward != null && selectedTaskInfo.DisplayReward.Id > 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
			{
				Id = selectedTaskInfo.DisplayReward.Id,
				Count = ToDetailCount(selectedTaskInfo.DisplayReward.Count)
			});
		}
	}

	public void OpenTaskCurrencyDetail()
	{
		if (!(taskCurrency == null))
		{
			taskCurrency.InputClick();
		}
	}

	private void SelectTask(int index)
	{
		if (_tasks.Count != 0)
		{
			_selectedTaskIndex = Mathf.Clamp(index, 0, _tasks.Count - 1);
			OneTreatTaskItem taskItem = GetTaskItem(_selectedTaskIndex);
			if (taskLoop != null && taskItem == null)
			{
				taskLoop.ScrollToCell(_selectedTaskIndex, 0f);
			}
			RefreshVisibleTaskPrompts();
		}
	}

	private void SubmitSelectedTask()
	{
		OneTreatTaskItem taskItem = GetTaskItem(_selectedTaskIndex);
		if (taskItem != null)
		{
			taskItem.OnSubmit(null);
			return;
		}
		OneTreatTaskInfo selectedTaskInfo = GetSelectedTaskInfo();
		if (selectedTaskInfo != null)
		{
			if (selectedTaskInfo.State == OneTreatTaskState.CanReceive)
			{
				OnReceiveTask(selectedTaskInfo);
			}
			else if (selectedTaskInfo.State == OneTreatTaskState.Unfinished)
			{
				OnGotoTask(selectedTaskInfo);
			}
		}
	}

	private OneTreatTaskItem GetTaskItem(int index)
	{
		if (taskLoop != null && taskLoop.GetItem(index) is OneTreatTaskItem result)
		{
			return result;
		}
		OneTreatTaskItem[] componentsInChildren = GetComponentsInChildren<OneTreatTaskItem>(includeInactive: true);
		OneTreatTaskInfo taskInfo = ((index >= 0 && index < _tasks.Count) ? _tasks[index] : null);
		OneTreatTaskItem[] array = componentsInChildren;
		foreach (OneTreatTaskItem oneTreatTaskItem in array)
		{
			if (IsTaskItemMatch(oneTreatTaskItem, index, taskInfo))
			{
				return oneTreatTaskItem;
			}
		}
		return null;
	}

	private OneTreatTaskInfo GetSelectedTaskInfo()
	{
		if (_selectedTaskIndex < 0 || _selectedTaskIndex >= _tasks.Count)
		{
			return null;
		}
		return _tasks[_selectedTaskIndex];
	}

	private static int ToDetailCount(long count)
	{
		if (count <= 0)
		{
			return 0;
		}
		if (count <= int.MaxValue)
		{
			return (int)count;
		}
		return int.MaxValue;
	}

	private void OnTaskItemShow(ILoopScrollDataSource dataSource)
	{
		if (dataSource is OneTreatTaskItem { index: var index } oneTreatTaskItem)
		{
			if (index < 0 || index >= _tasks.Count)
			{
				oneTreatTaskItem.gameObject.SetActive(value: false);
				return;
			}
			oneTreatTaskItem.gameObject.SetActive(value: true);
			oneTreatTaskItem.SetData(_tasks[index], OnReceiveTask, OnGotoTask, index);
			oneTreatTaskItem.SetSelected(index == _selectedTaskIndex);
		}
	}

	private void RefreshVisibleTaskPrompts()
	{
		OneTreatTaskItem[] componentsInChildren = GetComponentsInChildren<OneTreatTaskItem>(includeInactive: true);
		OneTreatTaskInfo selectedTaskInfo = GetSelectedTaskInfo();
		OneTreatTaskItem[] array = componentsInChildren;
		foreach (OneTreatTaskItem oneTreatTaskItem in array)
		{
			if (!(oneTreatTaskItem == null))
			{
				oneTreatTaskItem.SetSelected(IsTaskItemMatch(oneTreatTaskItem, _selectedTaskIndex, selectedTaskInfo));
			}
		}
	}

	private static bool IsTaskItemMatch(OneTreatTaskItem item, int taskIndex, OneTreatTaskInfo taskInfo)
	{
		if (item == null || taskIndex < 0 || taskInfo == null)
		{
			return false;
		}
		if (item.TaskIndex == taskIndex)
		{
			return true;
		}
		OneTreatTaskInfo taskInfo2 = item.TaskInfo;
		if (taskInfo2 != taskInfo)
		{
			if (taskInfo2 != null)
			{
				return taskInfo2.ChallengeId == taskInfo.ChallengeId;
			}
			return false;
		}
		return true;
	}

	private void RefreshOperatePrompts()
	{
		SetPromptVisible(taskCurrencyDetailPrompt, taskCurrency != null);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshOperatePrompts();
		RefreshVisibleTaskPrompts();
	}

	private void OnReceiveTask(OneTreatTaskInfo taskInfo)
	{
		if (_rewardRequesting || taskInfo == null)
		{
			return;
		}
		int activityId = taskInfo.ActivityId;
		int challengeGroupId = taskInfo.ChallengeGroupId;
		int challengeId = taskInfo.ChallengeId;
		List<OneTreatTaskInfo> receiveTasks = new List<OneTreatTaskInfo>();
		foreach (OneTreatTaskInfo task in _tasks)
		{
			if (task.State == OneTreatTaskState.CanReceive && task.ChallengeGroupId == challengeGroupId)
			{
				receiveTasks.Add(task);
			}
		}
		if (receiveTasks.Count == 0)
		{
			return;
		}
		_rewardRequesting = true;
		G.service.SendActivityKujiRewardReq(activityId, challengeGroupId, (ActivityKujiRewardAck ack) =>
		{
			_rewardRequesting = false;
			if (ack != null)
			{
				ReportActivityClick(activityId, challengeId, challengeGroupId, 3);
				List<int> list = new List<int>();
				foreach (OneTreatTaskInfo item in receiveTasks)
				{
					list.Add(item.ChallengeId);
				}
				Model<ActivityCenterModel>.Interface.MarkOneTreatTaskGroupRewardReceived(challengeGroupId, list);
				foreach (OneTreatTaskInfo item2 in receiveTasks)
				{
					item2.State = OneTreatTaskState.Received;
					item2.CurrentProgress = item2.TargetProgress;
				}
				SortTaskList();
				RefreshLoop();
				if (ack.Items.Count > 0)
				{
					GameUtility.OpenPopReward(ack.Items);
				}
			}
		});
	}

	private void OnGotoTask(OneTreatTaskInfo taskInfo)
	{
		int firstJumpId = GetFirstJumpId(taskInfo?.ChallengeData);
		if (firstJumpId == 0)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CanNotGoTo);
			return;
		}
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(firstJumpId);
		JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
		if (result.ShowType == JumpResult.JumpShowType.Forbidden || result.ShowType == JumpResult.JumpShowType.Hide)
		{
			GameUtility.OpenJumpResultTips(result);
			result.Release();
			return;
		}
		int activityId = taskInfo.ActivityId;
		int challengeGroupId = taskInfo.ChallengeGroupId;
		int challengeId = taskInfo.ChallengeId;
		runTimeJumpData.FromSystem = SystemType.Activity;
		Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
		result.Release();
		ReportActivityClick(activityId, challengeId, challengeGroupId, 2);
	}

	private static void ReportActivityClick(int activityId, int challengeId, int challengeGroupId, int status)
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = activityId;
		evt.challengeId = challengeId;
		evt.challengeGroupId = challengeGroupId;
		evt.status = status;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private int GetFirstJumpId(ActivityChallengeData challengeData)
	{
		if (challengeData?.challengeJump == null)
		{
			return 0;
		}
		int[] challengeJump = challengeData.challengeJump;
		foreach (int num in challengeJump)
		{
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	private void ReleaseTaskRewards()
	{
		foreach (OneTreatTaskInfo task in _tasks)
		{
			ItemUnifierProxy item = task.DisplayReward;
			ItemUnifierProxy.ItemUnifierPool.Release(ref item);
			task.DisplayReward = null;
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

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}
}
