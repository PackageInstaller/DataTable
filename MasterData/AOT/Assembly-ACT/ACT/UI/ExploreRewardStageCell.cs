using System;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.World;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class ExploreRewardStageCell : MonoBehaviour
{
	public GameObject canReward;

	public GameObject rewarded;

	public TextMeshProUGUI explorePercent;

	public ActButton previewButton;

	public int CollectionId { get; set; }

	public void Init(ACT.World.MapArea mapArea, int exploreRewardId, int exploreRatio, Action<ExploreRewardStageCell> previewAction = null)
	{
		gameObject.SetActive(value: true);
		ExplorationReward data = CoreUtils.GetData(exploreRewardId, RuntimeConfigs.data.explorationRewards);
		int rewardProgress = data.rewardProgress;
		explorePercent.SetText("{0:0}%", Mathf.FloorToInt(rewardProgress));
		int areaTab = data.areaTab;
		CollectionId = data.collectionId;
		AreaExploreData areaGroupExploreData = Model<MapModel>.Interface.GetAreaGroupExploreData(mapArea);
		if (areaGroupExploreData == null)
		{
			return;
		}
		if (areaTab == 2)
		{
			if (areaGroupExploreData.GetSubAreaData().TryGetValue(data.areaId, out var value))
			{
				if (value.GetClaimedRewardDic().ContainsKey(exploreRewardId))
				{
					canReward.SetActive(value: false);
					rewarded.SetActive(value: true);
				}
				else
				{
					rewarded.SetActive(value: false);
					canReward.SetActive(exploreRatio >= rewardProgress);
				}
			}
		}
		else if (areaGroupExploreData.GetClaimedRewardDic().ContainsKey(exploreRewardId))
		{
			canReward.SetActive(value: false);
			rewarded.SetActive(value: true);
		}
		else
		{
			rewarded.SetActive(value: false);
			canReward.SetActive(exploreRatio >= rewardProgress);
		}
		if (previewAction != null)
		{
			previewButton?.OnClick.RemoveAllListeners();
			previewButton?.OnClick.AddListener(() =>
			{
				previewAction(this);
			});
		}
	}
}
