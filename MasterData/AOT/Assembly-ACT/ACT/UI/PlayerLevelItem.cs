using System.Collections.Generic;
using ACT.Config;
using ACT.Model;
using ACT.Utility;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public struct PlayerLevelItem
{
	public int activityGroupId;

	public int activityChallengeId;

	public int level;

	public List<ItemKv> rewards;

	public bool isFinish;
}
public class playerLevelItem : LoopScrollBaseItem
{
	public PlayerLevelActivity parent;

	public TextMeshProUGUI levelText;

	public TextMeshProUGUI btnText;

	public GameObject needNumConment;

	public Transform needNumRoot;

	public Button rewardBtn;

	private int activityGroupId;

	private int activityChallengeId;

	public override void ScrollCellIndex(int idx)
	{
		gameObject.SetActive(value: true);
		PlayerLevelItem playerLevelItem2 = parent.playerLevelItems[idx];
		activityGroupId = playerLevelItem2.activityGroupId;
		activityChallengeId = playerLevelItem2.activityChallengeId;
		levelText.text = playerLevelItem2.level.FastToString();
		if (!Model<ActivityModel>.Interface.CheckPlayerLevel(playerLevelItem2.activityChallengeId))
		{
			btnText.text = "未达到目标等级";
			rewardBtn.interactable = false;
		}
		else
		{
			btnText.text = (playerLevelItem2.isFinish ? "已领取" : "领取");
			rewardBtn.interactable = !playerLevelItem2.isFinish;
		}
		foreach (ItemKv reward in parent.playerLevelItems[idx].rewards)
		{
			Object.Instantiate(needNumConment, needNumRoot).GetOrAddComponent<ItemNumComponent>().Init(reward.id, reward.count);
		}
	}

	public void ClickReward()
	{
		parent.UpdateRewardState(parent.DataId, activityGroupId, activityChallengeId);
		btnText.text = "已领取";
		rewardBtn.interactable = false;
	}
}
