using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Fundamental;
using Pb;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ActivitySecondMissionGroup : MonoBehaviour, ISubmitHandler, IEventSystemHandler, ISelectHandler, IDeselectHandler
{
	public LocalizeStringEvent title;

	public TMP_Text alreadyOpenCount;

	public ActButton helpButton;

	public CommonScrollBagComponent rewardBag;

	public ActivitySecondMission missionProgressTemplate;

	public Transform missionProgressRoot;

	public TMP_Text canOpenCount;

	public TMP_Text canOpenCountText;

	public ActButton confirmButton;

	public TextChanger textChanger;

	public List<GameObject> promtps;

	public ViewControlLayer RewardLayer;

	public GameObject PromptA;

	private const string ZeroColorHex = "#84888B";

	private int _activityChallengeGroupID;

	private ActivityChallengeData _firstChallengeData;

	private int _poolID;

	private ActivityChallengeGroup _activityChallengeGroup;

	private List<ItemUnifierProxy> _rewards;

	private List<ActivitySecondMission> _activitySecondMissions = new List<ActivitySecondMission>();

	public int ActivityChallengeGroupID
	{
		get
		{
			return _activityChallengeGroupID;
		}
		set
		{
			_activityChallengeGroupID = value;
			_activityChallengeGroup = CoreUtils.GetData(value, RuntimeConfigs.data.activityChallengeGroups);
			_firstChallengeData = CoreUtils.GetData(_activityChallengeGroup.challengeId.FirstOrDefault(), RuntimeConfigs.data.activityChallengeDatas);
			_poolID = _firstChallengeData.lotteryRewards.FirstOrDefault()?.id ?? 0;
			UpdateStyle();
		}
	}

	private void UpdateStyle()
	{
		if (_activityChallengeGroup == null)
		{
			return;
		}
		title.SetTable("longcommon");
		title.StringReference.TableEntryReference = _firstChallengeData.challengeText;
		if (_rewards == null)
		{
			_rewards = ListPool<ItemUnifierProxy>.Get();
		}
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		foreach (ItemKv item in _firstChallengeData.rewardsPreview)
		{
			_rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
		}
		_rewards.Sort(SortUtility.SortItemUnifierProxy1);
		rewardBag.ItemSource = _rewards;
		rewardBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		RefreshRewardState();
		for (int num = missionProgressRoot.childCount - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(missionProgressRoot.GetChild(num).gameObject);
			_activitySecondMissions.Clear();
		}
		int[] challengeId = _activityChallengeGroup.challengeId;
		foreach (int challengeID in challengeId)
		{
			ActivitySecondMission activitySecondMission = UnityEngine.Object.Instantiate(missionProgressTemplate, missionProgressRoot);
			activitySecondMission.gameObject.SetActive(value: true);
			activitySecondMission.ChallengeID = challengeID;
			activitySecondMission.ChallengeGroupID = _activityChallengeGroup.id;
			_activitySecondMissions.Add(activitySecondMission);
		}
	}

	public void RefreshRewardState()
	{
		if (_activityChallengeGroup != null)
		{
			ActivityLotteryInfo value = null;
			(Model<ActivityCenterModel>.Interface?.GetLotteryInfo())?.LotteryInfos?.TryGetValue(_poolID, out value);
			if (alreadyOpenCount != null)
			{
				alreadyOpenCount.SetText((value?.TotalGachaConut ?? 0).FastToString());
			}
			int num = value?.LeftGachaConut ?? 0;
			if (canOpenCount != null)
			{
				canOpenCount.SetText(num.FastToString());
			}
			if (textChanger != null)
			{
				textChanger.enabled = num != 0;
			}
			if (confirmButton != null)
			{
				confirmButton.Interactable(num > 0);
			}
		}
	}

	private void Awake()
	{
		helpButton.SetBtnClick(OpenIntro);
		confirmButton.SetBtnClick(GetReward);
	}

	public void OnTaskProgressChange(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		for (int i = 0; i < _activitySecondMissions.Count; i++)
		{
			_activitySecondMissions[i].OnTaskProgressChange(taskId, taskInfo, isNew);
		}
		RefreshRewardState();
	}

	private void OnDestroy()
	{
		if (_rewards != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
			ListPool<ItemUnifierProxy>.Release(_rewards);
		}
	}

	private void GetReward()
	{
		int activityId = Model<ActivityCenterModel>.Interface.GetLotteryInfo().ActivityId;
		int challengeGroupId = _activityChallengeGroup.id;
		int challengeId = _activityChallengeGroup.challengeId.FirstOrDefault();
		G.service.SendActivityDailyLotteryGachaReq(activityId, _poolID, (ActivityDailyLotteryGachaAck ack) =>
		{
			if (ack != null)
			{
				ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
				evt.activityId = activityId;
				evt.status = 3;
				evt.challengeId = challengeId;
				evt.challengeGroupId = challengeGroupId;
				evt.isPopup = false;
				EventTrackSolver.Instance.Dispatch(evt);
				List<Item> items = ListPool<Item>.Get();
				foreach (UniversalItem item in ack.Items)
				{
					items.Add(new Item
					{
						Id = item.Index,
						Count = item.Count
					});
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items), notSort: false, () =>
				{
					ListPool<Item>.Release(items);
				});
				Model<ActivityCenterModel>.Interface.RefreshRedDot();
				UpdateStyle();
			}
		});
	}

	public void OpenIntro()
	{
		LocalizationCommonData.CommonString descTextId = CoreUtils.GetData(Model<ActivityCenterModel>.Interface.GetLotteryInfo().ActivityId, RuntimeConfigs.data.activityDatas).activityChallengGroup.IndexOf(_activityChallengeGroupID) switch
		{
			0 => LocalizationCommonData.CommonString.NightPresentIntro, 
			1 => LocalizationCommonData.CommonString.StarPresentIntro, 
			2 => LocalizationCommonData.CommonString.MoonPresentIntro, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
		{
			titleTextId = _activityChallengeGroup.stageName,
			localizedStringType = "Common",
			descTextId = (int)descTextId,
			iconId = 3001
		});
	}

	public void SetPromptVisible(bool value)
	{
		for (int i = 0; i < promtps.Count; i++)
		{
			promtps[i].SetActive(value);
		}
		if (_activitySecondMissions != null && _activitySecondMissions.Count > 0)
		{
			ActivitySecondMission activitySecondMission = _activitySecondMissions[0];
			if (activitySecondMission.jumpButton.gameObject.activeSelf && activitySecondMission.jumpButton.IsInteractable())
			{
				activitySecondMission.PromptY.SetActive(value);
			}
		}
		PromptA.SetActive((confirmButton.gameObject.activeSelf && confirmButton.IsInteractable()) & value);
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (confirmButton.gameObject.activeSelf && confirmButton.IsInteractable())
		{
			confirmButton.OnSubmit(eventData);
		}
	}

	public void OnGoto()
	{
		if (_activitySecondMissions != null && _activitySecondMissions.Count > 0)
		{
			ActivitySecondMission activitySecondMission = _activitySecondMissions[0];
			if (activitySecondMission.jumpButton.gameObject.activeSelf && activitySecondMission.jumpButton.IsInteractable())
			{
				activitySecondMission.jumpButton.OnSubmit(null);
			}
		}
	}

	public void OnSelect(BaseEventData eventData)
	{
		SetPromptVisible(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	public void OnDeselect(BaseEventData eventData)
	{
		SetPromptVisible(value: false);
	}

	public void OnDeviceModeChange(DeviceInputMode deviceInputMode)
	{
		SetPromptVisible(deviceInputMode == DeviceInputMode.Gamepad && EventSystemHelper.CurrentSelected == gameObject);
	}
}
