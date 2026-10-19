using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using Pb;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class ActivitySkinTrial : ActivityCenterBaseUIView<ActivitySkinTrialController>
{
	[SerializeField]
	private BetterAnimation betterAnimation;

	[SerializeField]
	private TimeAndDesItem _timeAndDesItem;

	[SerializeField]
	private ActButton _gotoShopBtn;

	[SerializeField]
	private LocalizeStringEvent _skinName;

	[SerializeField]
	private CommonScrollBagComponent _rewards;

	[SerializeField]
	private GameObject _normalBtn;

	[SerializeField]
	private ActButton _receiveBtn;

	[SerializeField]
	private GameObject _receivedBtn;

	[SerializeField]
	private ActButton _gotoTrial;

	public GameObject GamepadTipsRoot;

	public Dictionary<ActivitySkinTrialControlType, List<GameObject>> ControlDownPromts;

	public Dictionary<ActivitySkinTrialControlType, List<GameObject>> ControlPromts;

	public ViewControlRoot ViewControlRoot;

	public Dictionary<ActivitySkinTrialControlType, ViewControlLayer> ControlLayerDic;

	private ActivitSkinTrialInfo _activitySkinTrialInfo;

	private ActivityCenterData _activityCenterData;

	private ActivityChallengeGroup _activityChallengeGroup;

	private ActivityChallengeData _activityChallengeData;

	private ActivitySkinTrialControlType ControlType
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

	protected override void Init()
	{
		base.Init();
		_gotoShopBtn.SetBtnClick(OnClickGotoShopBtnHandle);
		_receiveBtn.SetBtnClick(OnClickReceiveBtnHandle);
		_gotoTrial.SetBtnClick(OnClickGotoTrialHandle);
		RefreshUI();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").Play();
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/Role/2601");
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	public void OnClickGotoShopBtnHandle()
	{
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(_activityCenterData.StaticActivityData.shopId);
		JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
		if (jumpResult.ShowType != JumpResult.JumpShowType.CanJump)
		{
			jumpResult.Release();
			return;
		}
		Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
		jumpResult.Release();
		ReportActivityEvent(_activitySkinTrialInfo.ActivityId, _activityChallengeData.id, _activityChallengeGroup.id, 4);
	}

	public void OnClickReceiveBtnHandle()
	{
		if (_activitySkinTrialInfo == null)
		{
			return;
		}
		int activityId = _activitySkinTrialInfo.ActivityId;
		int challengeGroupId = _activityChallengeGroup.id;
		int challengeId = _activityChallengeData.id;
		G.service.SendActivitySkinTrialRewardReq(activityId, challengeGroupId, challengeId, (ActivitySkinTrialRewardAck ack) =>
		{
			if (ack != null)
			{
				ReportActivityEvent(activityId, challengeId, challengeGroupId, 3);
				List<Item> list = ListPool<Item>.Get();
				for (int i = 0; i < ack.Items.Count; i++)
				{
					Item item = new Item
					{
						Id = ack.Items[i].Index,
						Count = ack.Items[i].Count
					};
					list.Add(item);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(list));
				_activitySkinTrialInfo = Model<ActivityCenterModel>.Interface.GetActivitySkinTrialInfo(activityId);
				RefreshReward();
				Model<ActivityCenterModel>.Interface.RefreshActivitySkinTrialRedDotState();
			}
		});
	}

	public void OnClickGotoTrialHandle()
	{
		if (_activityChallengeData == null)
		{
			return;
		}
		int num = _activityChallengeData.extraParm[0];
		if (num != 0)
		{
			foreach (ItemKv item in CoreUtils.GetData(num, RuntimeConfigs.data.CharacterProbationRaids).typeRaidID)
			{
				if (item.id != 3)
				{
					continue;
				}
				TeamUsage raidTrialTeamUsage = Model<RaidModel>.Interface.GetRaidTrialTeamUsage(item.count);
				G.service.RaidEnterInfo(item.count, raidTrialTeamUsage, async (bool r) =>
				{
					if (r)
					{
						await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
					}
				});
				break;
			}
		}
		ReportActivityEvent(_activitySkinTrialInfo.ActivityId, _activityChallengeData.id, _activityChallengeGroup.id, 2);
	}

	private void RefreshUI()
	{
		int selectActivityId = Model<ActivityCenterModel>.Interface.SelectActivityId;
		_activitySkinTrialInfo = Model<ActivityCenterModel>.Interface.GetActivitySkinTrialInfo(selectActivityId);
		if (_activitySkinTrialInfo != null)
		{
			_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(_activitySkinTrialInfo.ActivityId);
			_timeAndDesItem.Init(_activityCenterData, -1L);
			int id = _activityCenterData.StaticActivityData.activityChallengGroup[0];
			_activityChallengeGroup = CoreUtils.GetData(id, RuntimeConfigs.data.activityChallengeGroups);
			_activityChallengeData = CoreUtils.GetData(_activityChallengeGroup.challengeId[0], RuntimeConfigs.data.activityChallengeDatas);
			Skin data = CoreUtils.GetData(_activityChallengeData.extraParm[0], RuntimeConfigs.data.Skins);
			_skinName.SetTable(LocalizationUtility.localizeTableName_shortcommon);
			_skinName.StringReference.TableEntryReference = data.skinname;
			RefreshReward();
		}
	}

	private void RefreshReward()
	{
		if (_activityChallengeData != null)
		{
			Collection data = CoreUtils.GetData(_activityChallengeData.challengeReward[0], RuntimeConfigs.data.collections);
			List<Item> list = new List<Item>();
			for (int i = 0; i < data.certain.Count; i++)
			{
				Item item = new Item
				{
					Id = data.certain[i].id,
					Count = data.certain[i].count
				};
				list.Add(item);
			}
			List<ItemUnifierProxy> list2 = ListPool<ItemUnifierProxy>.Get();
			ItemUnifierProxy.ItemUnifierPool.GetList(list, list2);
			ListPool<Item>.Release(list);
			ActivityCenterModel.ActivityRewardState rewardState = GetRewardState();
			_rewards.ItemShowType = ((rewardState == ActivityCenterModel.ActivityRewardState.Received) ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem);
			_rewards.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
			_rewards.Station = Station;
			_rewards.ItemSource = list2;
			_normalBtn.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Normal);
			_receiveBtn.transform.parent.gameObject.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Receive);
			_receivedBtn.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Received);
		}
	}

	private ActivityCenterModel.ActivityRewardState GetRewardState()
	{
		for (int i = 0; i < _activitySkinTrialInfo.GainedActivityGroup.Count; i++)
		{
			if (_activitySkinTrialInfo.GainedActivityGroup[i].ActivityGroupId == _activityChallengeGroup.id)
			{
				return ActivityCenterModel.ActivityRewardState.Received;
			}
		}
		if (Model<ActivityCenterModel>.Interface.GetActivityChallengeIsComplete(_activityChallengeGroup.challengeId[0]))
		{
			return ActivityCenterModel.ActivityRewardState.Receive;
		}
		return ActivityCenterModel.ActivityRewardState.Normal;
	}

	private void ReportActivityEvent(int activityId, int challengeId, int challengeGroupId, int status)
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = activityId;
		evt.status = status;
		evt.challengeId = challengeId;
		evt.challengeGroupId = challengeGroupId;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public new void OnInputDeviceChange(DeviceInputMode type)
	{
		if (GetController() != null)
		{
			GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
			if (type == DeviceInputMode.Gamepad)
			{
				ChangeControlType(ActivitySkinTrialControlType.Main);
			}
		}
	}

	public void ChangeControlType(ActivitySkinTrialControlType controlType)
	{
		ActivitySkinTrialControlType controlType2 = ControlType;
		ControlType = controlType;
		ControlLayerDic[controlType2].UnFocus();
		ControlLayerDic[controlType].Focus();
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[controlType])
		{
			item.SetActive(value: true);
			LayoutRebuilder.ForceRebuildLayoutImmediate(item.GetComponent<RectTransform>());
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
		for (int j = 0; j < ControlPromts[controlType2].Count; j++)
		{
			ControlPromts[controlType2][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[controlType].Count; k++)
		{
			ControlPromts[controlType][k].SetActive(value: true);
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
		case MoveDirection.Down:
			return;
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		}
		if (ControlType == ActivitySkinTrialControlType.Reward)
		{
			ItemUIComponentBase itemUIComponentBase = EventSystemHelper.CurrentSelected?.GetComponent<ItemUIComponentBase>();
			if (itemUIComponentBase != null)
			{
				itemUIComponentBase.SetIsOn(val: true);
			}
		}
	}

	public void OnConfirm()
	{
		if (ControlType == ActivitySkinTrialControlType.Main)
		{
			if (_receiveBtn.gameObject.activeSelf && _receiveBtn.IsInteractable())
			{
				_receiveBtn.OnSubmit(null);
			}
		}
		else if (ControlType == ActivitySkinTrialControlType.Reward)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void OnClose()
	{
		ActivityCenterView?.Exit();
	}

	public void OnRightStickPress()
	{
		_timeAndDesItem.OnClickActivityDetailButtonHandle();
	}
}
