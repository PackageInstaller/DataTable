using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.RichText;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class TeamTrainingContentView : MonoBehaviour
{
	private readonly struct RewardBinding(ItemKv item, int targetIndex, bool received)
	{
		public readonly ItemKv Item = item;

		public readonly int TargetIndex = targetIndex;

		public readonly bool Received = received;
	}

	[SerializeField]
	private CommonSubWorldEntranceTitle _entranceTitle;

	[SerializeField]
	private CommonSubWorldEntranceDescription _entranceDescription;

	[SerializeField]
	private CommonSubWorldEntranceTarget _entranceTarget;

	[SerializeField]
	private CommonSubWorldEntranceRewards _entranceRewards;

	[SerializeField]
	private BImage[] _teamCharacterHeads;

	[SerializeField]
	private ActButton[] _teamCharacterButtons;

	[SerializeField]
	private GameObject[] _teamCharacterBgs;

	[SerializeField]
	private GameObject[] _noCharacterBgs;

	[SerializeField]
	private ActButton _enterButton;

	[SerializeField]
	private GameObject _levelLockRoot;

	[SerializeField]
	private TMP_Text _levelLockText;

	private readonly List<RewardBinding> _rewards = new List<RewardBinding>();

	private readonly List<ItemUnifierProxy> _rewardItems = new List<ItemUnifierProxy>();

	private readonly List<int> _targetIds = new List<int>();

	private TrainingContents _current;

	private Action _onEnter;

	private Action<TrainingContents, int> _onTeamDetail;

	public bool HasRewards => _rewards.Count > 0;

	private void OnDestroy()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_rewardItems);
	}

	public void Initialize(Action onEnter, Action<TrainingContents, int> onTeamDetail)
	{
		_onEnter = onEnter;
		_onTeamDetail = onTeamDetail;
		if (_enterButton != null)
		{
			_enterButton.SetBtnClick(() =>
			{
				_onEnter?.Invoke();
			}, "event:/UI/Interface/CharacterTraining/Play");
		}
		if (_teamCharacterButtons == null)
		{
			return;
		}
		for (int num = 0; num < _teamCharacterButtons.Length; num++)
		{
			int characterIndex = num;
			ActButton actButton = _teamCharacterButtons[num];
			if (actButton == null)
			{
				continue;
			}
			actButton.SetBtnClick(() =>
			{
				if (_current != null)
				{
					_onTeamDetail?.Invoke(_current, characterIndex);
				}
			});
		}
	}

	public void Refresh(TrainingContents data, ImageAssetStation station, bool unlocked, int challengeTime = -1)
	{
		_current = data;
		gameObject.SetActive(data != null);
		if (data == null)
		{
			return;
		}
		RuntimeConfigs.data.raids.TryGetValue(data.raidID, out var value);
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(data.raidID);
		bool flag = raidInfo != null && raidInfo.CleanNum > 0;
		int num;
		if (flag)
		{
			StageChallengeTarget target = raidInfo.Target;
			if (target != null && target.IsPerfect)
			{
				num = (HasAllTargets(value, raidInfo) ? 1 : 0);
				goto IL_0075;
			}
		}
		num = 0;
		goto IL_0075;
		IL_0075:
		bool isPerfect = (byte)num != 0;
		int recordTime;
		if (challengeTime >= 0)
		{
			recordTime = challengeTime;
		}
		else
		{
			recordTime = (flag ? raidInfo.FastestClearTime : (-1));
		}
		_entranceTitle?.RefreshUI(data.contentLv1name, flag, -1, recordTime, isPerfect);
		string description = ((value != null && value.ruleDescId > 0) ? LocalizationUtility.GetLocalizeString("shortcommon", value.ruleDescId) : string.Empty);
		_entranceDescription?.RefreshUI(description);
		RefreshLockPresentation(value, unlocked);
		RefreshFixedTeam(data.teamCharacter, station);
		RefreshTargets(value, raidInfo);
		RefreshRewards(value?.firstReward, raidInfo, station);
	}

	private void RefreshTargets(ACT.Config.Raid raidConfig, ACT.Game.Data.Raid raid)
	{
		if (_entranceTarget == null)
		{
			return;
		}
		_targetIds.Clear();
		if (raidConfig?.firstReward != null)
		{
			foreach (ItemKv item in raidConfig.firstReward)
			{
				if (item != null && item.id > 0)
				{
					_targetIds.Add(item.id);
				}
			}
		}
		_entranceTarget.gameObject.SetActive(_targetIds.Count > 0);
		_entranceTarget.RefreshUI(_targetIds, raid?.Target, GetHiddenTargetProgress, preferMissionDescription: true);
	}

	private static int GetHiddenTargetProgress(int targetId)
	{
		return -1;
	}

	private void RefreshRewards(IEnumerable<ItemKv> targetRewards, ACT.Game.Data.Raid raid, ImageAssetStation station)
	{
		_rewards.Clear();
		ItemUnifierProxy.ItemUnifierPool.Release(_rewardItems);
		if (targetRewards != null)
		{
			int num = 0;
			foreach (ItemKv targetReward in targetRewards)
			{
				if (targetReward != null && targetReward.id > 0 && targetReward.count > 0 && RuntimeConfigs.data.collections.TryGetValue(targetReward.count, out var value) && value?.certain != null)
				{
					bool received = HasTargetReward(raid, targetReward.id);
					foreach (ItemKv item in value.certain)
					{
						if (item != null && item.id > 0 && item.count > 0 && RuntimeConfigs.data.itemDatas.ContainsKey(item.id))
						{
							_rewards.Add(new RewardBinding(item, num, received));
						}
					}
				}
				num++;
			}
		}
		_rewards.Sort((RewardBinding left, RewardBinding right) =>
		{
			bool received2 = left.Received;
			int num2 = received2.CompareTo(right.Received);
			if (num2 == 0)
			{
				int targetIndex = left.TargetIndex;
				return targetIndex.CompareTo(right.TargetIndex);
			}
			return num2;
		});
		foreach (RewardBinding reward in _rewards)
		{
			ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get<Item>(reward.Item.id, reward.Item.count);
			itemUnifierProxy.RewardTag = GetTargetRewardTag(reward.TargetIndex);
			_rewardItems.Add(itemUnifierProxy);
		}
		if (!(_entranceRewards == null))
		{
			_entranceRewards.gameObject.SetActive(_rewardItems.Count > 0);
			_entranceRewards.RefreshUI(_rewardItems, station, ItemUIComponentBase.InitType.WorldSettlementRewardItem, OnRewardItemShow);
		}
	}

	private void OnRewardItemShow(ItemUIComponentBase itemUI)
	{
		if (!(itemUI == null) && itemUI.Index >= 0 && itemUI.Index < _rewards.Count && itemUI.ItemUnifier != null)
		{
			RewardBinding rewardBinding = _rewards[itemUI.Index];
			itemUI.SetData(itemUI.ItemUnifier, long.MinValue, rewardBinding.Received ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.WorldSettlementRewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			itemUI.UpdatePerformance();
		}
	}

	private void RefreshLockPresentation(ACT.Config.Raid raidConfig, bool unlocked)
	{
		if (_enterButton != null)
		{
			_enterButton.gameObject.SetActive(unlocked);
		}
		if (_levelLockRoot != null)
		{
			_levelLockRoot.SetActive(!unlocked);
		}
		if (!unlocked && _levelLockText != null)
		{
			_levelLockText.SetText(GetUnlockConditionText(raidConfig));
		}
	}

	private void RefreshFixedTeam(int[] probationIds, ImageAssetStation station)
	{
		if (_teamCharacterHeads == null)
		{
			return;
		}
		for (int i = 0; i < _teamCharacterHeads.Length; i++)
		{
			int num = ((probationIds != null && i < probationIds.Length) ? probationIds[i] : 0);
			int num2 = 0;
			if (num > 0 && RuntimeConfigs.data?.entityCharacterProbations != null && RuntimeConfigs.data.entityCharacterProbations.TryGetValue(num, out var value))
			{
				num2 = value.characterId;
			}
			bool flag = num2 > 0;
			SetSlotActive(_teamCharacterBgs, i, flag);
			SetSlotActive(_noCharacterBgs, i, !flag);
			BImage bImage = _teamCharacterHeads[i];
			if (bImage != null)
			{
				bImage.icon.gameObject.SetActive(flag);
				if (flag)
				{
					station.LoadImage(148, num2, bImage);
				}
			}
			if (_teamCharacterButtons != null && i < _teamCharacterButtons.Length && _teamCharacterButtons[i] != null)
			{
				_teamCharacterButtons[i].interactable = flag;
			}
		}
	}

	private static void SetSlotActive(GameObject[] objects, int index, bool active)
	{
		if (objects != null && index >= 0 && index < objects.Length && !(objects[index] == null))
		{
			objects[index].SetActive(active);
		}
	}

	private static bool HasAllTargets(ACT.Config.Raid raidConfig, ACT.Game.Data.Raid raid)
	{
		if (raidConfig?.firstReward == null || raidConfig.firstReward.Count == 0)
		{
			return false;
		}
		foreach (ItemKv item in raidConfig.firstReward)
		{
			if (item == null || !HasTargetReward(raid, item.id))
			{
				return false;
			}
		}
		return true;
	}

	private static bool HasTargetReward(ACT.Game.Data.Raid raid, int targetId)
	{
		bool value = default;
		return (targetId > 0 && raid?.Target?.TargetReward != null && raid.Target.TargetReward.TryGetValue(targetId, out value)) & value;
	}

	private static UniversalItemTag GetTargetRewardTag(int targetIndex)
	{
		return targetIndex switch
		{
			0 => UniversalItemTag.TargetOne, 
			1 => UniversalItemTag.TargetTwo, 
			2 => UniversalItemTag.TargetThree, 
			_ => UniversalItemTag.Default, 
		};
	}

	private static string GetUnlockConditionText(ACT.Config.Raid raidConfig)
	{
		ACT.Config.Mission data = CoreUtils.GetData(CoreUtils.GetData(raidConfig.unlockCondition, RuntimeConfigs.data.missionGroups).missionId[0], RuntimeConfigs.data.missions);
		return CustomTagParser.ReplacePreconditionText(data, data.number, data.param);
	}
}
