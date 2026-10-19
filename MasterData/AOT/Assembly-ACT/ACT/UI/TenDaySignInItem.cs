using System;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class TenDaySignInItem : ActButton
{
	public TextMeshProUGUI Index;

	public BImage Icon;

	public TextMeshProUGUI Count;

	public GameObject Receive;

	public GameObject Received;

	public BetterAnimation betterAnimation;

	public CanvasGroup CanvasGroup;

	[SerializeField]
	private Color _canReceiveColor;

	[SerializeField]
	private Color _normalColor;

	[SerializeField]
	private GameObject toSignObj;

	[NonSerialized]
	public ActivityChallengeGroup activityChallengeGroup;

	[NonSerialized]
	public ActivityCenterModel.ActivityRewardState rewardState;

	[NonSerialized]
	public ItemKv itemKv;

	[NonSerialized]
	public int _index;

	public void RefreshUI(int index, int activityId, int activityGroupId, ImageAssetStation Station)
	{
		RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityGroupId, out var value);
		_index = index;
		activityChallengeGroup = value;
		Index.text = $"{index + 1:d2}";
		if (value.challengeId.Length != 0)
		{
			ActivityChallengeData activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[value.challengeId[0]];
			if (activityChallengeData != null)
			{
				Collection collection = RuntimeConfigs.data.collections[activityChallengeData.challengeReward[0]];
				itemKv = collection.certain[0];
				ItemData itemData = RuntimeConfigs.data.itemDatas[itemKv.id];
				Station.LoadItemIconAsync(itemData.iconAddress, Icon);
				TextMeshProUGUI count = Count;
				int count2 = itemKv.count;
				count.text = "X" + count2;
				rewardState = Model<ActivityCenterModel>.Interface.GetSignInGroupRewardState(activityId, value);
				Receive.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Receive);
				Received.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Received);
				toSignObj.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Normal);
				Count.color = ((rewardState == ActivityCenterModel.ActivityRewardState.Receive) ? _canReceiveColor : _normalColor);
			}
		}
	}

	public void PlayItemAnimation(bool isLeft)
	{
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence(isLeft ? "Show_Left" : "Show_Right").Play();
		}
	}
}
