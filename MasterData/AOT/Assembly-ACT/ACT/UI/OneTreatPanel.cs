using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
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
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class OneTreatPanel : ActivityCenterBaseUIView<OneTreatPanelController>
{
	private const int TodayTicketMaxCount = 5;

	[SerializeField]
	private TimeAndDesItem timeAndDesItem;

	[SerializeField]
	private CommonScrollBagComponent rewardBag;

	[SerializeField]
	private TMP_Text progressText;

	[SerializeField]
	private TMP_Text taskCountLeftText;

	[SerializeField]
	private TMP_Text taskCountRightText;

	[SerializeField]
	private ActButton taskButton;

	[SerializeField]
	private ActButton goButton;

	[SerializeField]
	private RedDotItem taskButtonRedDot;

	[SerializeField]
	private RedDotItem goButtonRedDot;

	[SerializeField]
	private BetterAnimation betterAnimation;

	public GameObject GamepadTipsRoot;

	public Dictionary<OneTreatPanelControlType, List<GameObject>> ControlDownPromts;

	public Dictionary<OneTreatPanelControlType, List<GameObject>> ControlPromts;

	public ViewControlRoot ViewControlRoot;

	public Dictionary<OneTreatPanelControlType, ViewControlLayer> ControlLayerDic;

	private ActivityCenterData _activityCenterData;

	private ActivityData _activityData;

	private List<ItemUnifierProxy> _rewards;

	private int _selectedRewardIndex = -1;

	private bool _isOpeningMainView;

	private bool _isHiddenForMainView;

	private int ActivityId => Model<ActivityCenterModel>.Interface.SelectActivityId;

	private OneTreatPanelControlType ControlType
	{
		get
		{
			if (GetController() != null)
			{
				return GetController().ControlType;
			}
			return OneTreatPanelControlType.Main;
		}
		set
		{
			OneTreatPanelController controller = GetController();
			if (controller != null)
			{
				controller.ControlType = value;
			}
		}
	}

	public bool IsRewardSelectionMode => ControlType == OneTreatPanelControlType.Reward;

	private bool HasClaimedAllPrizes
	{
		get
		{
			int normalLotteryPrizeCount = OneTreatConfigUtility.GetNormalLotteryPrizeCount(_activityData);
			int normalLotteryClaimedCount = OneTreatConfigUtility.GetNormalLotteryClaimedCount(_activityData, Model<ActivityCenterModel>.Interface.GetOneTreatInfo());
			if (normalLotteryPrizeCount > 0)
			{
				return normalLotteryClaimedCount >= normalLotteryPrizeCount;
			}
			return false;
		}
	}

	protected override void Init()
	{
		base.Init();
		BindButtons();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += OnTaskProgressChange;
		if (_rewards == null)
		{
			_rewards = ListPool<ItemUnifierProxy>.Get();
		}
		RefreshActivityData();
		ActivityCenterView?.LeftPart?.SetActive(value: true);
		RefreshBaseInfo();
		RefreshProgress();
		RefreshTaskProgress();
		RefreshRewardPreview();
		RefreshRedDots();
		RefreshTaskEntry();
		RefreshControlPresentation(ControlType, ControlType);
		PlayOpenAnim();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/RoleChoise");
	}

	private void PlayOpenAnim()
	{
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show")?.Play();
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		PlayCloseAnimation();
		if (rewardBag != null)
		{
			rewardBag.ItemSource = null;
			rewardBag.OnUpdateEnd = null;
		}
		if (_rewards != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
			ListPool<ItemUnifierProxy>.Release(_rewards);
			_rewards = null;
		}
		_activityCenterData = null;
		_activityData = null;
		_selectedRewardIndex = -1;
		ControlType = OneTreatPanelControlType.Main;
		_isOpeningMainView = false;
		_isHiddenForMainView = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= OnTaskProgressChange;
	}

	private void PlayCloseAnimation()
	{
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide")?.Play();
		}
	}

	private void RefreshActivityData()
	{
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(ActivityId);
		_activityData = _activityCenterData?.StaticActivityData;
	}

	private void OnActivityUpdate(BaseEventContent content)
	{
		if (content is ActivityCenterInfo activityCenterInfo && activityCenterInfo.activityId == ActivityId)
		{
			RefreshActivityData();
			RefreshProgress();
			RefreshTaskProgress();
			RefreshRedDots();
			RefreshTaskEntry();
		}
	}

	private void OnTaskProgressChange(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		RefreshRedDots();
	}

	private void BindButtons()
	{
		taskButton?.SetBtnClick(OpenTaskView);
		goButton?.SetBtnClick(OpenMainView);
	}

	private void RefreshRedDots()
	{
		Model<ActivityCenterModel>.Interface.RefreshOneTreatRedDotState();
		BindRedDot(taskButtonRedDot, RedDotPathDefine.Activity_OneTreatTask);
		BindRedDot(goButtonRedDot, RedDotPathDefine.Activity_OneTreatMain);
	}

	private static void BindRedDot(RedDotItem redDotItem, string path)
	{
		if (!(redDotItem == null) && !string.IsNullOrEmpty(path))
		{
			redDotItem.redDotType = RedDotType.Dot;
			redDotItem.displayAction = new SelfNodeActive();
			redDotItem.fullPath = path.Split("|").ToList();
			redDotItem.BindTrieNode();
			redDotItem.UpdateDisplay();
		}
	}

	private void RefreshBaseInfo()
	{
		if (!(timeAndDesItem == null) && _activityCenterData != null)
		{
			timeAndDesItem.Init(_activityCenterData, -1L);
		}
	}

	private void RefreshProgress()
	{
		if (!(progressText == null))
		{
			int normalLotteryPrizeCount = OneTreatConfigUtility.GetNormalLotteryPrizeCount(_activityData);
			int normalLotteryClaimedCount = OneTreatConfigUtility.GetNormalLotteryClaimedCount(_activityData, Model<ActivityCenterModel>.Interface.GetOneTreatInfo());
			progressText.SetText("{0:0}/{1:0}", normalLotteryClaimedCount, Mathf.Max(0, normalLotteryPrizeCount));
		}
	}

	private void RefreshTaskEntry()
	{
		GameObject gameObject = taskButton?.gameObject;
		bool flag = !HasClaimedAllPrizes;
		if (gameObject != null && gameObject.activeSelf != flag)
		{
			gameObject.SetActive(flag);
		}
	}

	private void RefreshTaskProgress()
	{
		if (!(taskCountLeftText == null) || !(taskCountRightText == null))
		{
			int oneTreatReceivedTaskRewardCount = Model<ActivityCenterModel>.Interface.GetOneTreatReceivedTaskRewardCount();
			if (taskCountLeftText != null)
			{
				taskCountLeftText.SetText("{0:0}", oneTreatReceivedTaskRewardCount);
			}
			if (taskCountRightText != null)
			{
				taskCountRightText.SetText("{0:0}", 5f);
			}
		}
	}

	private void RefreshRewardPreview()
	{
		if (_rewards == null)
		{
			_rewards = ListPool<ItemUnifierProxy>.Get();
		}
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		OneTreatConfigUtility.AddLotteryRewards(_activityData, _rewards);
		_rewards.Sort(SortUtility.SortItemUnifierProxy2);
		if (!(rewardBag == null))
		{
			rewardBag.ItemShowType = ItemUIComponentBase.InitType.RewardItem;
			rewardBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
			rewardBag.ResetPositionAfterUpdate = true;
			rewardBag.OnUpdateEnd = RefreshSelectedRewardState;
			rewardBag.ItemSource = _rewards;
		}
	}

	public void OpenTaskView()
	{
		if (!IsRewardSelectionMode && !HasClaimedAllPrizes)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ONETREATTASK, new OneTreatTaskViewData
			{
				ActivityId = ActivityId
			});
		}
	}

	public void OpenMainView()
	{
		if (!IsRewardSelectionMode && !_isOpeningMainView && !_isHiddenForMainView)
		{
			int activityId = ActivityId;
			_isOpeningMainView = true;
			OpenMainViewAsync(activityId).Forget();
			ReportActivityClick(activityId, 0, 0, 2);
		}
	}

	private async UniTaskVoid OpenMainViewAsync(int activityId)
	{
		UIOpenResult uIOpenResult = await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ONETREATMAIN, new OneTreatMainViewData
		{
			ActivityId = activityId
		});
		_isOpeningMainView = false;
		if (uIOpenResult.IsValid && Singleton<NewUIManager>.instance.GetUIState(uIOpenResult.Uid) == UIState.Opened)
		{
			_isHiddenForMainView = true;
			gameObject.SetActive(value: false);
		}
	}

	public override void OnPopStack()
	{
		base.OnPopStack();
		RestoreAfterMainView();
	}

	private void RestoreAfterMainView()
	{
		_isOpeningMainView = false;
		if (_isHiddenForMainView)
		{
			_isHiddenForMainView = false;
			gameObject.SetActive(value: true);
			RefreshRedDots();
		}
	}

	public void OpenActivityDetail()
	{
		if (!IsRewardSelectionMode)
		{
			if (timeAndDesItem != null)
			{
				timeAndDesItem.OnClickActivityDetailButtonHandle();
				return;
			}
			if (_activityData == null)
			{
				GameUtility.OpenToolTip("暂无活动说明");
				return;
			}
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				descTextId = _activityData.activityDesc,
				iconId = 3001,
				titleTextId = _activityData.activityName
			});
		}
	}

	public void ChangeControlType(OneTreatPanelControlType controlType)
	{
		OneTreatPanelControlType controlType2 = ControlType;
		if (controlType == OneTreatPanelControlType.Reward)
		{
			if (controlType2 != OneTreatPanelControlType.Reward && !SelectRewardPreview(0))
			{
				return;
			}
		}
		else if (!TryExitRewardSelectionMode())
		{
			ControlType = OneTreatPanelControlType.Main;
		}
		RefreshControlPresentation(controlType2, ControlType);
	}

	private void RefreshControlPresentation(OneTreatPanelControlType lastControlType, OneTreatPanelControlType controlType)
	{
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		if (ControlLayerDic != null)
		{
			if ((!flag || lastControlType != controlType) && ControlLayerDic.TryGetValue(lastControlType, out var value))
			{
				value?.UnFocus();
			}
			if (flag && ControlLayerDic.TryGetValue(controlType, out var value2))
			{
				value2?.Focus();
			}
		}
		if (GamepadTipsRoot != null && GamepadTipsRoot.transform.childCount > 0)
		{
			Transform child = GamepadTipsRoot.transform.GetChild(0);
			for (int i = 0; i < child.childCount; i++)
			{
				child.GetChild(i).gameObject.SetActive(value: false);
			}
			if (flag && ControlDownPromts != null && ControlDownPromts.TryGetValue(controlType, out var value3) && value3 != null)
			{
				foreach (GameObject item in value3)
				{
					if (!(item == null))
					{
						item.SetActive(value: true);
						RectTransform component = item.GetComponent<RectTransform>();
						if (component != null)
						{
							LayoutRebuilder.ForceRebuildLayoutImmediate(component);
						}
					}
				}
			}
			RectTransform component2 = child.GetComponent<RectTransform>();
			if (component2 != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(component2);
			}
		}
		if (ControlPromts == null)
		{
			return;
		}
		if (lastControlType != controlType && ControlPromts.TryGetValue(lastControlType, out var value4) && value4 != null)
		{
			for (int j = 0; j < value4.Count; j++)
			{
				if (value4[j] != null)
				{
					value4[j].SetActive(value: false);
				}
			}
		}
		if (!ControlPromts.TryGetValue(controlType, out var value5) || value5 == null)
		{
			return;
		}
		for (int k = 0; k < value5.Count; k++)
		{
			if (value5[k] != null)
			{
				value5[k].SetActive(flag);
			}
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		OnInputModeChange(type);
	}

	public void OnInputModeChange(DeviceInputMode deviceInputMode)
	{
		bool flag = deviceInputMode == DeviceInputMode.Gamepad;
		if (GamepadTipsRoot != null)
		{
			GamepadTipsRoot.SetActive(flag);
		}
		if (!flag && IsRewardSelectionMode)
		{
			ChangeControlType(OneTreatPanelControlType.Main);
		}
		else
		{
			RefreshControlPresentation(ControlType, ControlType);
		}
	}

	public void OnClose()
	{
		if (!TryExitRewardSelectionMode())
		{
			(Singleton<NewUIManager>.instance.GetTopActiveUI().GetUIView() as ActivityCenterView)?.Exit();
		}
	}

	public void OnSelectItemCell()
	{
		ChangeControlType(OneTreatPanelControlType.Reward);
	}

	public void HandleConfirm()
	{
		if (ControlType == OneTreatPanelControlType.Main)
		{
			ChangeControlType(OneTreatPanelControlType.Reward);
		}
		else if (ControlType == OneTreatPanelControlType.Reward)
		{
			OpenSelectedRewardDetail();
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (dir != MoveDirection.Left && dir != MoveDirection.Right)
		{
			return;
		}
		if (ControlType == OneTreatPanelControlType.Reward)
		{
			if (_rewards != null && _rewards.Count != 0)
			{
				int num = ((dir != MoveDirection.Left) ? 1 : (-1));
				SelectRewardPreview(Mathf.Clamp(_selectedRewardIndex + num, 0, _rewards.Count - 1));
			}
		}
		else if (ViewControlRoot != null)
		{
			if (dir == MoveDirection.Left)
			{
				ViewControlRoot.SelectLeft();
			}
			else
			{
				ViewControlRoot.SelectRight();
			}
		}
		else if (_rewards != null && _rewards.Count != 0)
		{
			ChangeControlType(OneTreatPanelControlType.Reward);
		}
	}

	private bool SelectRewardPreview(int index)
	{
		if (_rewards == null || _rewards.Count == 0)
		{
			return false;
		}
		ControlType = OneTreatPanelControlType.Reward;
		_selectedRewardIndex = Mathf.Clamp(index, 0, _rewards.Count - 1);
		if (rewardBag != null)
		{
			rewardBag.ResetPositionAfterUpdate = false;
			bool flag = rewardBag.GetItem(_selectedRewardIndex) == null;
			rewardBag.ClearSelectedModelWithoutNotify();
			rewardBag.AddSelectedModelWithoutNotify(_rewards[_selectedRewardIndex]);
			if (flag)
			{
				rewardBag.ScrollToIndex(_selectedRewardIndex);
				rewardBag.ForceUpdatePerformance();
			}
		}
		RefreshSelectedRewardState();
		return true;
	}

	private bool TryExitRewardSelectionMode()
	{
		if (ControlType != OneTreatPanelControlType.Reward)
		{
			return false;
		}
		ControlType = OneTreatPanelControlType.Main;
		_selectedRewardIndex = -1;
		if (rewardBag != null)
		{
			rewardBag.ClearSelectedModelWithoutNotify();
		}
		RefreshSelectedRewardState();
		RefreshControlPresentation(OneTreatPanelControlType.Reward, ControlType);
		EventSystemHelper.SetSelectedGameObject(null);
		return true;
	}

	private void RefreshSelectedRewardState()
	{
		if (rewardBag == null || _rewards == null)
		{
			return;
		}
		for (int i = 0; i < _rewards.Count; i++)
		{
			ItemUIComponentBase item = rewardBag.GetItem(i);
			if (item != null)
			{
				item.IsHighLight = IsRewardSelectionMode && i == _selectedRewardIndex;
			}
		}
	}

	private void OpenSelectedRewardDetail()
	{
		if (_rewards != null && _selectedRewardIndex >= 0 && _selectedRewardIndex < _rewards.Count)
		{
			ItemUnifierProxy itemUnifierProxy = _rewards[_selectedRewardIndex];
			if (itemUnifierProxy != null && itemUnifierProxy.Id > 0)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
				{
					Id = itemUnifierProxy.Id,
					Count = ToDetailCount(itemUnifierProxy.Count)
				});
			}
		}
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
}
