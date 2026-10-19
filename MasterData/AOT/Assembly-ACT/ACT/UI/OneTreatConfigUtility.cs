using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using UnityEngine;

namespace ACT.UI;

internal static class OneTreatConfigUtility
{
	public static void CollectLotteryConfigs(ActivityData activityData, List<Lottery> normalLotteries, out Lottery finalLottery)
	{
		normalLotteries?.Clear();
		finalLottery = null;
		int activityLotteryId = GetActivityLotteryId(activityData);
		if (activityLotteryId <= 0 || RuntimeConfigs.data?.lotterys == null)
		{
			return;
		}
		foreach (KeyValuePair<int, Lottery> lottery in RuntimeConfigs.data.lotterys)
		{
			Lottery value = lottery.Value;
			if (value == null || value.lotteryid != activityLotteryId)
			{
				continue;
			}
			if (value.finalReward == 1)
			{
				if (finalLottery == null || value.id < finalLottery.id)
				{
					finalLottery = value;
				}
			}
			else
			{
				normalLotteries?.Add(value);
			}
		}
		normalLotteries?.Sort((Lottery left, Lottery right) =>
		{
			int id = left.id;
			return id.CompareTo(right.id);
		});
	}

	public static int GetNormalLotteryPrizeCount(ActivityData activityData)
	{
		int activityLotteryId = GetActivityLotteryId(activityData);
		if (activityLotteryId <= 0 || RuntimeConfigs.data?.lotterys == null)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<int, Lottery> lottery in RuntimeConfigs.data.lotterys)
		{
			Lottery value = lottery.Value;
			if (value != null && value.lotteryid == activityLotteryId && value.finalReward != 1)
			{
				num += Mathf.Max(1, value.max);
			}
		}
		return num;
	}

	public static int GetNormalLotteryClaimedCount(ActivityData activityData, ActivityKujiInfo kujiInfo)
	{
		if (kujiInfo == null || kujiInfo.PrizeInfo.Count <= 0)
		{
			return 0;
		}
		int activityLotteryId = GetActivityLotteryId(activityData);
		if (activityLotteryId <= 0 || RuntimeConfigs.data?.lotterys == null)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<int, int> item in kujiInfo.PrizeInfo)
		{
			if (RuntimeConfigs.data.lotterys.TryGetValue(item.Key, out var value) && value != null && value.lotteryid == activityLotteryId && value.finalReward != 1)
			{
				num += Mathf.Clamp(item.Value, 0, Mathf.Max(1, value.max));
			}
		}
		return Mathf.Clamp(num, 0, GetNormalLotteryPrizeCount(activityData));
	}

	public static ItemKv GetFirstLotteryReward(Lottery lottery)
	{
		return GetFirstValidItem(lottery?.certain);
	}

	public static int GetTicketItemId(ActivityData activityData)
	{
		return GetLotteryConfigKv(activityData)?.count ?? 0;
	}

	public static ItemKv GetFirstChallengeReward(ActivityChallengeData challengeData)
	{
		ItemKv firstValidItem = GetFirstValidItem(challengeData?.rewardsPreview);
		if (firstValidItem != null)
		{
			return firstValidItem;
		}
		if (challengeData?.challengeReward == null)
		{
			return null;
		}
		int[] challengeReward = challengeData.challengeReward;
		for (int i = 0; i < challengeReward.Length; i++)
		{
			ItemKv firstCollectionReward = GetFirstCollectionReward(CoreUtils.GetData(challengeReward[i], RuntimeConfigs.data.collections));
			if (firstCollectionReward != null)
			{
				return firstCollectionReward;
			}
		}
		return null;
	}

	public static void AddChallengeRewards(ActivityChallengeData challengeData, List<ItemUnifierProxy> rewards)
	{
		if (challengeData != null && rewards != null && !AddItemRewards(challengeData.rewardsPreview, rewards, 1, mergeSameItem: false) && challengeData.challengeReward != null)
		{
			int[] challengeReward = challengeData.challengeReward;
			for (int i = 0; i < challengeReward.Length; i++)
			{
				AddCollectionRewards(CoreUtils.GetData(challengeReward[i], RuntimeConfigs.data.collections), rewards, 1, mergeSameItem: false);
			}
		}
	}

	public static void AddLotteryRewards(ActivityData activityData, List<ItemUnifierProxy> rewards)
	{
		int activityLotteryId = GetActivityLotteryId(activityData);
		if (activityLotteryId <= 0 || rewards == null || RuntimeConfigs.data?.lotterys == null)
		{
			return;
		}
		foreach (KeyValuePair<int, Lottery> lottery in RuntimeConfigs.data.lotterys)
		{
			Lottery value = lottery.Value;
			if (value != null && value.lotteryid == activityLotteryId)
			{
				int multiplier = ((value.finalReward == 1) ? 1 : Mathf.Max(1, value.max));
				AddItemRewards(value.certain, rewards, multiplier, mergeSameItem: true);
			}
		}
	}

	private static bool AddCollectionRewards(Collection collection, List<ItemUnifierProxy> rewards, int multiplier, bool mergeSameItem)
	{
		if (!AddItemRewards(collection?.certain, rewards, multiplier, mergeSameItem))
		{
			return AddItemRewards(collection?.rewards, rewards, multiplier, mergeSameItem);
		}
		return true;
	}

	private static int GetActivityLotteryId(ActivityData activityData)
	{
		return GetLotteryConfigKv(activityData)?.id ?? 0;
	}

	private static ItemKv GetLotteryConfigKv(ActivityData activityData)
	{
		return GetFirstValidItem(activityData?.lotteryId);
	}

	private static bool AddItemRewards(IEnumerable<ItemKv> itemKvs, List<ItemUnifierProxy> rewards, int multiplier, bool mergeSameItem)
	{
		if (itemKvs == null || rewards == null)
		{
			return false;
		}
		bool result = false;
		int num = Mathf.Max(1, multiplier);
		foreach (ItemKv itemKv in itemKvs)
		{
			if (itemKv != null && itemKv.id > 0)
			{
				result = true;
				int num2 = ToSafeCount((long)Mathf.Max(1, itemKv.count) * (long)num);
				if (mergeSameItem)
				{
					AddOrMergeReward(rewards, itemKv.id, num2);
				}
				else
				{
					rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, num2));
				}
			}
		}
		return result;
	}

	private static void AddOrMergeReward(List<ItemUnifierProxy> rewards, int itemId, int count)
	{
		foreach (ItemUnifierProxy reward in rewards)
		{
			if (reward != null && reward.Id == itemId)
			{
				reward.Count += count;
				return;
			}
		}
		rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemId, count));
	}

	private static ItemKv GetFirstCollectionReward(Collection collection)
	{
		return GetFirstValidItem(collection?.certain) ?? GetFirstValidItem(collection?.rewards);
	}

	private static ItemKv GetFirstValidItem(IEnumerable<ItemKv> itemKvs)
	{
		if (itemKvs == null)
		{
			return null;
		}
		foreach (ItemKv itemKv in itemKvs)
		{
			if (itemKv != null && itemKv.id > 0)
			{
				return itemKv;
			}
		}
		return null;
	}

	private static int ToSafeCount(long count)
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
}
