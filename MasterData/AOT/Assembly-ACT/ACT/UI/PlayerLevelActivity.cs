using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.Collections;
using Pb;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class PlayerLevelActivity : ChangePageBase
{
	private BList<PlayerLevelItem> m_playerLevelItems;

	[Header("UI组件")]
	public LoopHorizontalScrollRect itemList;

	public BList<PlayerLevelItem> playerLevelItems => m_playerLevelItems;

	public override void Init()
	{
		m_playerLevelItems = BListPool<PlayerLevelItem>.Default.Get();
		SetData();
		itemList.ClearCells();
		itemList.totalCount = m_playerLevelItems.Count;
		itemList.RefillCells();
		base.Init();
	}

	private void SetData()
	{
		int[] activityChallengGroup = CoreUtils.GetData(DataId, RuntimeConfigs.data.activityDatas).activityChallengGroup;
		for (int i = 0; i < activityChallengGroup.Length; i++)
		{
			int num = CoreUtils.GetData(activityChallengGroup[i], RuntimeConfigs.data.activityChallengeGroups).challengeId[0];
			ActivityChallengeData data = CoreUtils.GetData(num, RuntimeConfigs.data.activityChallengeDatas);
			List<ItemKv> certain = CoreUtils.GetData(data.challengeReward[0], RuntimeConfigs.data.collections).certain;
			PlayerLevelItem item = new PlayerLevelItem
			{
				activityGroupId = activityChallengGroup[i],
				activityChallengeId = num,
				level = data.challengeConditionParm[0],
				rewards = certain,
				isFinish = Model<ActivityModel>.Interface.CheckGotReward(DataId, num)
			};
			m_playerLevelItems.Add(item);
		}
	}

	[Obsolete("已弃用，使用ActivityModel.Interface.CheckGotReward")]
	private bool AlreadyRewarded(int activityGroupId, int activityId)
	{
		if (G.localPlayer.playerLevelActivity.ContainsKey(DataId))
		{
			using IEnumerator<ActivityGroup> enumerator = G.localPlayer.playerLevelActivity[DataId].GetEnumerator();
			if (enumerator.MoveNext())
			{
				ActivityGroup current = enumerator.Current;
				return current.ActivityGroupId == activityGroupId && current.ActivityChallengeIds.Contains(activityId);
			}
		}
		return false;
	}

	public void UpdateRewardState(int activityId, int activityGroupId, int activityChallengeId)
	{
		ActivityChallengeData activityData = CoreUtils.GetData(activityChallengeId, RuntimeConfigs.data.activityChallengeDatas);
		PlayerLevelItem item = m_playerLevelItems.FirstOrDefault((PlayerLevelItem x) => x.level == activityData.challengeConditionParm[0]);
		G.service.SendActivityGainReward(activityId, activityGroupId, activityChallengeId, (ActivityGetLevelRewardAck b) =>
		{
			item.isFinish = true;
			List<Item> list = new List<Item>();
			foreach (ItemKv reward in item.rewards)
			{
				list.Add(new Item
				{
					Id = reward.id,
					Count = reward.count
				});
			}
			GameUtility.OpenPopReward(GameUtility.ToUniversalItems(list));
		});
	}

	[Obsolete("已弃用，使用ActivityModel.Interface.CheckPlayerLevel")]
	public override void UnInit()
	{
		BListPool<PlayerLevelItem>.Default.Recycle(m_playerLevelItems);
	}
}
