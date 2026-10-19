using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class ThirtyFiveDaySignInItem : ActButton
{
	public TextMeshProUGUI Index;

	public BImage Icon;

	public TextMeshProUGUI Count;

	public GameObject Receive;

	public GameObject Received;

	public BetterAnimation BetterAnimation;

	public RectTransform ContentRoot;

	public CanvasGroup ContentCanvasGroup;

	public Color IndexTextColorReceive = Color.black;

	public Color IndexTextColorNormal = Color.black;

	public ActivityChallengeGroup activityChallengeGroup;

	public ActivityCenterModel.ActivityRewardState rewardState;

	public ItemKv itemKv;

	public int _index;

	public void ResetAnimation()
	{
		ContentCanvasGroup.alpha = 0f;
		ContentRoot.rotation = Quaternion.Euler(0f, 88f, 0f);
	}

	public void PlayAnimation()
	{
		BetterAnimation.GetSequence("Show").Play();
	}

	public void RefreshUI(int index, int activityId, int activityGroupId)
	{
		RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityGroupId, out var value);
		_index = index;
		activityChallengeGroup = value;
		Index.text = $"{index + 1:d2}";
		if (value.challengeId.Length == 0)
		{
			return;
		}
		ActivityChallengeData activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[value.challengeId[0]];
		if (activityChallengeData == null)
		{
			return;
		}
		Collection collection = RuntimeConfigs.data.collections[activityChallengeData.challengeReward[0]];
		itemKv = collection.certain[0];
		if (RuntimeConfigs.data.itemDatas.TryGetValue(itemKv.id, out var value2))
		{
			this.GetImageStation().LoadItemIconAsync(value2.iconAddress, Icon);
			TextMeshProUGUI count = Count;
			int count2 = itemKv.count;
			count.text = count2.ToString();
			rewardState = Model<ActivityCenterModel>.Interface.GetSignInGroupRewardState(activityId, value);
			Receive.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Receive);
			Received.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Received);
			if (rewardState == ActivityCenterModel.ActivityRewardState.Receive)
			{
				Index.color = IndexTextColorReceive;
			}
			else
			{
				Index.color = IndexTextColorNormal;
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			int count2 = itemKv.id;
			Debug.LogError("Item id not found: " + count2);
		}
	}
}
