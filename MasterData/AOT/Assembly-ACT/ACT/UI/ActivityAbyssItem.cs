using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class ActivityAbyssItem : MonoBehaviour
{
	public GameObject LockGameObject;

	public GameObject LockNormalGameObject;

	public GameObject LockSelectGameObject;

	public TextMeshProUGUI LockTitle;

	public GameObject ReceiveGameObject;

	public GameObject ReceiveNormalGameObject;

	public GameObject ReceiveSelectGameObject;

	public TextMeshProUGUI ReceiveTitle;

	public GameObject ReceivedGameObject;

	public GameObject ReceivedNormalGameObject;

	public GameObject ReceivedSelectGameObject;

	public TextMeshProUGUI ReceivedTitle;

	public ActButton ActButton;

	public GameObject RewardPanel;

	public List<LiteItemUIComponent> Rewards;

	public BetterAnimation betterAnimation;

	private ActivitAbyssInfo _activityAbyssInfo;

	private ActivityChallengeGroup _activityChallengeGroup;

	private ActivityChallengeData _activityChallengeData;

	private ActivityCenterModel.ActivityRewardState _activityRewardState;

	private Action<int> _callBack;

	private int _index;

	private int selectItemIndex;

	private int rewardCount;

	private ImageAssetStation _station;

	public void RefreshUI(int activityChallengeGtoupId, int index, Action<int> callBack, ImageAssetStation Station)
	{
		ActButton.SetBtnClick(OnClickItemButton, "event:/UI/Interface/Activity/Abyss/Click");
		_activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[activityChallengeGtoupId];
		if (_activityChallengeGroup == null)
		{
			return;
		}
		_activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[_activityChallengeGroup.challengeId[0]];
		if (_activityChallengeData == null)
		{
			return;
		}
		_index = index;
		_callBack = callBack;
		_station = Station;
		_activityAbyssInfo = Model<ActivityCenterModel>.Interface.GetActivitAbyssInfo();
		_activityRewardState = Model<ActivityCenterModel>.Interface.GetActivityAbyssRewardState(activityChallengeGtoupId);
		LockGameObject.SetActive(_activityRewardState == ActivityCenterModel.ActivityRewardState.Lock);
		ReceiveGameObject.SetActive(_activityRewardState == ActivityCenterModel.ActivityRewardState.Receive);
		ReceivedGameObject.SetActive(_activityRewardState == ActivityCenterModel.ActivityRewardState.Received);
		LockTitle.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, _activityChallengeGroup.stageName);
		ReceiveTitle.text = LockTitle.text;
		ReceivedTitle.text = LockTitle.text;
		List<ItemKv> certain = RuntimeConfigs.data.collections[_activityChallengeData.challengeReward[0]].certain;
		rewardCount = certain.Count;
		for (int i = 0; i < Rewards.Count; i++)
		{
			Rewards[i].gameObject.SetActive(value: false);
			if (i < certain.Count)
			{
				Rewards[i].gameObject.SetActive(value: true);
				Item item = new Item();
				item.Id = certain[i].id;
				item.Count = certain[i].count;
				Rewards[i].Station = Station;
				Rewards[i].SetData(item, 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				Rewards[i].IsComplete = _activityRewardState == ActivityCenterModel.ActivityRewardState.Received;
				Rewards[i].UpdatePerformance();
			}
		}
	}

	public void OnClickItemButton()
	{
		if (_activityRewardState == ActivityCenterModel.ActivityRewardState.Receive)
		{
			G.service.RequestActivityAbyssReward(_activityAbyssInfo.ActivityId, _activityChallengeGroup.id, _activityChallengeGroup.challengeId[0], (ActivityAbyssRewardAck activityAbyssRewardAck) =>
			{
				List<ItemUnifierProxy> items = ListPool<ItemUnifierProxy>.Get();
				foreach (Item item2 in activityAbyssRewardAck.Items)
				{
					ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.Id, item2.Count);
					items.Add(item);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items), notSort: false, () =>
				{
					ListPool<ItemUnifierProxy>.Release(items);
				});
				Model<ActivityCenterModel>.Interface.RefreshActivityAbyssRedDotState();
				RefreshUI(_activityChallengeGroup.id, _index, _callBack, _station);
				ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
				evt.activityId = _activityAbyssInfo.ActivityId;
				evt.status = 3;
				evt.challengeGroupId = _activityChallengeGroup.id;
				evt.challengeId = _activityChallengeGroup.challengeId[0];
				evt.isPopup = false;
				EventTrackSolver.Instance.Dispatch(evt);
			});
		}
		_callBack?.Invoke(_index);
	}

	public void SetSelect(bool value)
	{
		RewardPanel.SetActive(value);
		switch (_activityRewardState)
		{
		case ActivityCenterModel.ActivityRewardState.Lock:
			LockNormalGameObject.SetActive(!value);
			LockSelectGameObject.SetActive(value);
			break;
		case ActivityCenterModel.ActivityRewardState.Receive:
			ReceiveNormalGameObject.SetActive(!value);
			ReceiveSelectGameObject.SetActive(value);
			break;
		case ActivityCenterModel.ActivityRewardState.Received:
			ReceivedNormalGameObject.SetActive(!value);
			ReceivedSelectGameObject.SetActive(value);
			break;
		case ActivityCenterModel.ActivityRewardState.Normal:
			break;
		}
	}

	public void PlayAnimation()
	{
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			if (_activityRewardState == ActivityCenterModel.ActivityRewardState.Receive)
			{
				betterAnimation.GetSequence("ReceiveLoop").SetLoops(-1).Play();
			}
		}).SetLoops(1)
			.Play();
	}

	public void SetGamepadSelect(bool value)
	{
		switch (_activityRewardState)
		{
		case ActivityCenterModel.ActivityRewardState.Lock:
			LockNormalGameObject.SetActive(!value);
			LockSelectGameObject.SetActive(value);
			break;
		case ActivityCenterModel.ActivityRewardState.Receive:
			ReceiveNormalGameObject.SetActive(value: true);
			break;
		case ActivityCenterModel.ActivityRewardState.Received:
			ReceivedNormalGameObject.SetActive(!value);
			ReceivedSelectGameObject.SetActive(value);
			break;
		case ActivityCenterModel.ActivityRewardState.Normal:
			break;
		}
	}

	public void Left()
	{
		if (selectItemIndex > 0)
		{
			Rewards[selectItemIndex].SetIsOn(val: false);
			selectItemIndex--;
			Rewards[selectItemIndex].SetIsOn(val: true);
		}
	}

	public void Right()
	{
		if (selectItemIndex < Mathf.Min(rewardCount - 1, Rewards.Count - 1))
		{
			Rewards[selectItemIndex].SetIsOn(val: false);
			selectItemIndex++;
			Rewards[selectItemIndex].SetIsOn(val: true);
		}
	}

	public void SelectItem(bool active)
	{
		if (!active)
		{
			for (int i = 0; i < Mathf.Min(rewardCount, Rewards.Count); i++)
			{
				Rewards[i].SetIsOn(val: false);
			}
		}
		else
		{
			selectItemIndex = 0;
			Rewards[selectItemIndex].SetIsOn(val: true);
		}
	}

	public void OpenItemDetail()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = Rewards[selectItemIndex].ItemUnifier.Id,
			Count = (int)Rewards[selectItemIndex].ItemUnifier.Count
		});
	}
}
