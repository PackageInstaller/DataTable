using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class SingleTrainingContentView : MonoBehaviour
{
	[SerializeField]
	private CommonSubWorldEntranceTitle _entranceTitle;

	[SerializeField]
	private CommonSubWorldEntranceDescription _entranceDescription;

	[SerializeField]
	private CommonSubWorldEntranceTarget _entranceTarget;

	[SerializeField]
	private CommonSubWorldEntranceRewards _entranceRewards;

	[SerializeField]
	private ActButton _enterButton;

	private const int FreeTrainingTitleId = 1215;

	private const int FreeTrainingDescriptionId = 1216;

	private const int SingleTrainingDescriptionId = 1218;

	private readonly List<ItemUnifierProxy> _rewards = new List<ItemUnifierProxy>();

	private Action _onEnter;

	private bool _rewardsReceived;

	public bool HasRewards => _rewards.Count > 0;

	private void OnDestroy()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
	}

	public void Initialize(Action onEnter)
	{
		_onEnter = onEnter;
		if (_enterButton != null)
		{
			_enterButton.SetBtnClick(OnEnterClicked, "event:/UI/Interface/CharacterTraining/Play");
		}
	}

	private void OnEnterClicked()
	{
		_onEnter?.Invoke();
	}

	public void Refresh(bool isFreeTraining, CharacterTutorialRaidInfo raidInfo, ImageAssetStation station)
	{
		gameObject.SetActive(value: true);
		if (isFreeTraining)
		{
			_entranceTitle?.RefreshUI("Common", 1215, isComplete: false);
			_entranceDescription?.RefreshUI(LocalizationUtility.GetLocalizeString("Common", 1216));
			SetTargetVisible(visible: false);
			RefreshRewards(null, received: false, station);
			return;
		}
		int num;
		if (raidInfo != null)
		{
			ACT.Game.Data.Raid raidInfo2 = Model<RaidModel>.Interface.GetRaidInfo(raidInfo.RaidId);
			num = ((raidInfo2 != null && raidInfo2.CleanNum > 0) ? 1 : 0);
		}
		else
		{
			num = 0;
		}
		bool flag = (byte)num != 0;
		if (raidInfo != null)
		{
			_entranceTitle?.RefreshUI(LocalizationTableHelper.TableEnum2TableString(raidInfo.RaidNameLocalizedStringData.Table), raidInfo.RaidNameLocalizedStringData.Id, flag, -1, -1, flag);
		}
		_entranceDescription?.RefreshUI(LocalizationUtility.GetLocalizeString("Common", 1218));
		RefreshTarget(raidInfo, flag);
		RefreshRewards(raidInfo?.Reward, flag, station);
	}

	private void SetTargetVisible(bool visible)
	{
		if (!(_entranceTarget == null))
		{
			_entranceTarget.gameObject.SetActive(visible);
		}
	}

	private void RefreshTarget(CharacterTutorialRaidInfo raidInfo, bool completed)
	{
		if (_entranceTarget == null || raidInfo == null || RuntimeConfigs.data?.raids == null || RuntimeConfigs.data.ruless == null || !RuntimeConfigs.data.raids.TryGetValue(raidInfo.RaidId, out var value) || value?.firstReward == null)
		{
			SetTargetVisible(visible: false);
			return;
		}
		ItemKv itemKv = null;
		foreach (ItemKv item in value.firstReward)
		{
			if (item != null && item.id > 0 && RuntimeConfigs.data.ruless.ContainsKey(item.id))
			{
				itemKv = item;
				break;
			}
		}
		if (itemKv == null)
		{
			SetTargetVisible(visible: false);
			return;
		}
		_entranceTarget.gameObject.SetActive(value: true);
		_entranceTarget.RefreshSingle(itemKv.id, completed);
	}

	private void RefreshRewards(IEnumerable<ItemKv> rewards, bool received, ImageAssetStation station)
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		_rewardsReceived = received;
		if (rewards != null)
		{
			foreach (ItemKv reward in rewards)
			{
				if (reward != null && reward.id > 0 && reward.count > 0)
				{
					_rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(reward.id, reward.count));
				}
			}
		}
		if (!(_entranceRewards == null))
		{
			_entranceRewards.gameObject.SetActive(_rewards.Count > 0);
			_entranceRewards.RefreshUI(_rewards, station, received ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, OnRewardItemShow);
		}
	}

	private void OnRewardItemShow(ItemUIComponentBase itemUI)
	{
		if (itemUI?.ItemUnifier != null)
		{
			itemUI.SetData(itemUI.ItemUnifier, long.MinValue, _rewardsReceived ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			itemUI.UpdatePerformance();
		}
	}
}
