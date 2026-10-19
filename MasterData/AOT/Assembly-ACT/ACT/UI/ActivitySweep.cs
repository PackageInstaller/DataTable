using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ActivitySweep : ActivityCenterBaseUIView<ActivitySweepController>
{
	[Header("一级界面")]
	public GameObject firstPanelRoot;

	public TimeAndDesItem timeAndDesItem;

	public CommonScrollBagComponent rewardBag;

	public ActivitySweepTaskProgress[] tasks;

	public ActButton confirmButton;

	public RedDotItem redDotItem;

	[Header("二级界面")]
	public GameObject secondPanelRoot;

	public GameObject secondBlurImage;

	public ActivitySecondMissionGroup[] missionGroups;

	public ActButton helpButton;

	public ActButton backButton;

	public BetterAnimation firstPanelAnimation;

	public BetterAnimation secondPanelAnimation;

	public GameObject GamepadTipsRoot;

	public Dictionary<ActivitySweepControllerType, List<GameObject>> ControlDownPromts;

	public Dictionary<ActivitySweepControllerType, List<GameObject>> ControlPromts;

	public Dictionary<ActivitySweepControllerType, ViewControlLayer> ControlLayerDic;

	public ViewControlRoot ViewControlRoot;

	private List<ItemUnifierProxy> _rewards;

	private ActivityCenterData _activityCenterData;

	private ActivityDailyLotteryInfo _lotteryInfo => Model<ActivityCenterModel>.Interface.GetLotteryInfo();

	private ActivityData _activityData => _activityCenterData.StaticActivityData;

	private ActivitySweepControllerType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
		}
	}

	private void Awake()
	{
		confirmButton.SetBtnClick(OpenSecondPanel);
		backButton.SetBtnClick(OpenFirstPanel);
		helpButton.SetBtnClick(OpenInfoView);
	}

	protected override void Init()
	{
		base.Init();
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += OnTaskProgressChange;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
		firstPanelRoot.SetActive(value: true);
		secondPanelRoot.SetActive(value: false);
		secondBlurImage.SetActive(value: false);
		ActivityCenterView.LeftPart.SetActive(value: true);
		_rewards = ListPool<ItemUnifierProxy>.Get();
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(_lotteryInfo.ActivityId);
		if (_activityData != null)
		{
			OpenFirstPanel();
		}
	}

	protected override void UnInit()
	{
		ClearTaskProgressListener();
		ClearActivityUpdateListener();
		base.UnInit();
		if (_rewards != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
			ListPool<ItemUnifierProxy>.Release(_rewards);
			_rewards = null;
		}
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		ClearTaskProgressListener();
		ClearActivityUpdateListener();
	}

	private void ClearTaskProgressListener()
	{
		if (Singleton<PreconditionInfoManager>.HasInstance())
		{
			Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= OnTaskProgressChange;
		}
	}

	private void OnTaskProgressChange(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		if (missionGroups != null)
		{
			for (int i = 0; i < missionGroups.Length; i++)
			{
				missionGroups[i]?.OnTaskProgressChange(taskId, taskInfo, isNew);
			}
		}
	}

	private void ClearActivityUpdateListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
	}

	private void OnActivityUpdate(BaseEventContent content)
	{
		if (content is ActivityCenterInfo activityCenterInfo && _activityCenterData != null && activityCenterInfo.activityId == _activityCenterData.ActivityId)
		{
			RefreshActivityProgress();
		}
	}

	private void RefreshActivityProgress()
	{
		if (tasks != null)
		{
			for (int i = 0; i < tasks.Length; i++)
			{
				tasks[i]?.Refresh();
			}
		}
		if (missionGroups != null)
		{
			for (int j = 0; j < missionGroups.Length; j++)
			{
				missionGroups[j]?.RefreshRewardState();
			}
		}
	}

	private void UpdateBaseInfo()
	{
		timeAndDesItem.Init(_activityCenterData, -1L);
	}

	private void UpdateTasks()
	{
		int num = 0;
		int[] activityChallengGroup = _activityData.activityChallengGroup;
		foreach (int activityChallengeGroupID in activityChallengGroup)
		{
			if (num < tasks.Length)
			{
				tasks[num++].ActivityChallengeGroupID = activityChallengeGroupID;
			}
		}
	}

	private void UpdateReward()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		int[] activityChallengGroup = _activityData.activityChallengGroup;
		for (int i = 0; i < activityChallengGroup.Length; i++)
		{
			ActivityChallengeGroup data = CoreUtils.GetData(activityChallengGroup[i], RuntimeConfigs.data.activityChallengeGroups);
			if (data == null)
			{
				continue;
			}
			int[] challengeId = data.challengeId;
			for (int j = 0; j < challengeId.Length; j++)
			{
				ActivityChallengeData data2 = CoreUtils.GetData(challengeId[j], RuntimeConfigs.data.activityChallengeDatas);
				if (data2 == null)
				{
					continue;
				}
				foreach (ItemKv itemKv in data2.rewardsPreview)
				{
					ItemUnifierProxy itemUnifierProxy = _rewards.FirstOrDefault((ItemUnifierProxy x) => x.Id == itemKv.id);
					if (itemUnifierProxy == null)
					{
						_rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count));
					}
					else
					{
						itemUnifierProxy.Count += itemKv.count;
					}
				}
			}
		}
		_rewards.Sort(SortUtility.SortItemUnifierProxy2);
		rewardBag.ItemSource = _rewards;
		rewardBag.CountShowType = ItemUIComponentBase.ItemCountShowType.Hide;
	}

	private void OpenFirstPanel()
	{
		UpdateBaseInfo();
		UpdateTasks();
		UpdateReward();
		redDotItem.InitRedDot(RedDotPathDefine.Activity_DailyLottery);
		PlayFirstPanelAnimation();
		ChangeControlType(ActivitySweepControllerType.Page1Main);
	}

	private void PlayFirstPanelAnimation()
	{
		firstPanelRoot.SetActive(value: true);
		ActivityCenterView.LeftPart.SetActive(value: true);
		firstPanelAnimation?.GetSequence("ChestShow")?.OnComplete((AnimationBuilder x) =>
		{
			secondPanelRoot.SetActive(value: false);
		}).Play();
		secondPanelAnimation?.GetSequence("Hide")?.Play();
		secondBlurImage.SetActive(value: false);
	}

	private void OpenSecondPanel()
	{
		int num = 0;
		int[] activityChallengGroup = _activityData.activityChallengGroup;
		foreach (int activityChallengeGroupID in activityChallengGroup)
		{
			if (num < missionGroups.Length)
			{
				missionGroups[num++].ActivityChallengeGroupID = activityChallengeGroupID;
			}
		}
		PlaySecondPanelAnimation();
		ReportActivityEvent(0, 0, 2);
		ChangeControlType(ActivitySweepControllerType.Page2Main);
	}

	private void PlaySecondPanelAnimation()
	{
		secondPanelRoot.SetActive(value: true);
		ActivityCenterView.LeftPart.SetActive(value: false);
		firstPanelAnimation?.GetSequence("ChestHide")?.OnComplete((AnimationBuilder x) =>
		{
			firstPanelRoot.SetActive(value: false);
		}).Play();
		secondPanelAnimation?.GetSequence("Show")?.Play();
		secondBlurImage.SetActive(value: true);
	}

	public void OpenInfoView()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
		{
			descTextId = _activityData.activityDesc,
			iconId = 3001,
			titleTextId = _activityData.activityName
		}).Forget();
	}

	private void ReportActivityEvent(int challengeId, int challengeGroupId, int status)
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = Model<ActivityCenterModel>.Interface.OpenActivityID;
		evt.status = status;
		evt.challengeId = challengeId;
		evt.challengeGroupId = challengeGroupId;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		ChangeControlType(ControlType);
		for (int i = 0; i < missionGroups.Length; i++)
		{
			missionGroups[i].OnDeviceModeChange(type);
		}
	}

	public void OnActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public void ChangeControlType(ActivitySweepControllerType controlType)
	{
		ActivitySweepControllerType controlType2 = ControlType;
		ControlType = controlType;
		ControlLayerDic[controlType].ReFocus();
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[controlType])
		{
			item.SetActive(value: true);
		}
		for (int j = 0; j < ControlPromts[controlType2].Count; j++)
		{
			ControlPromts[controlType2][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[controlType].Count; k++)
		{
			ControlPromts[controlType][k].SetActive(value: true);
		}
		if (controlType == ActivitySweepControllerType.Page2Main && EventSystemHelper.CurrentSelected != null)
		{
			ActivitySecondMissionGroup component = EventSystemHelper.CurrentSelected.GetComponent<ActivitySecondMissionGroup>();
			if (component != null)
			{
				ControlLayerDic[ActivitySweepControllerType.Page2Reward] = component.RewardLayer;
			}
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		}
		if (ControlType == ActivitySweepControllerType.Page2Main && EventSystemHelper.CurrentSelected != null)
		{
			ActivitySecondMissionGroup component = EventSystemHelper.CurrentSelected.GetComponent<ActivitySecondMissionGroup>();
			if (component != null)
			{
				ControlLayerDic[ActivitySweepControllerType.Page2Reward] = component.RewardLayer;
			}
		}
	}

	public void OpenActivityDetail()
	{
		timeAndDesItem.OnClickActivityDetailButtonHandle();
	}

	public void OnConfirm()
	{
		if (ControlType != ActivitySweepControllerType.Page1Main && !(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void OpenMissionGroupDetail()
	{
		if (EventSystemHelper.CurrentSelected != null)
		{
			ActivitySecondMissionGroup component = EventSystemHelper.CurrentSelected.GetComponent<ActivitySecondMissionGroup>();
			if (component != null)
			{
				component.OpenIntro();
			}
		}
	}

	public void OnGoto()
	{
		if (EventSystemHelper.CurrentSelected != null)
		{
			ActivitySecondMissionGroup component = EventSystemHelper.CurrentSelected.GetComponent<ActivitySecondMissionGroup>();
			if (component != null)
			{
				component.OnGoto();
			}
		}
	}
}
