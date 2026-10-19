using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.EventSystems;

public class ActivityCharacterTrialItem : ActToggle
{
	[Serializable]
	public class QualityInfo
	{
		public int quality;

		public GameObject obj;
	}

	[SerializeField]
	public List<QualityInfo> Qualitys;

	public BImage CharacterIcon;

	public GameObject RedDot;

	public GameObject Hover;

	public int challengeGroupId;

	protected override void Awake()
	{
		base.Awake();
		AddListener();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		RemoveListener();
	}

	private void AddListener()
	{
		onToggleClick.AddListener(OnClick);
	}

	private void RemoveListener()
	{
		onToggleClick.RemoveListener(OnClick);
	}

	private void OnClick()
	{
		SetIsOn(!IsOn);
	}

	public void RefreshUI(int challengeGroupId, ImageAssetStation station)
	{
		this.challengeGroupId = challengeGroupId;
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[challengeGroupId];
		int num = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]].extraParm[0];
		station.LoadImage(178, num, CharacterIcon);
		EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[num];
		foreach (QualityInfo quality in Qualitys)
		{
			quality.obj.SetActive(quality.quality == entityCharacterData.stars);
		}
		ActivityCenterModel.ActivityRewardState activityCharacterTrialRewardState = Model<ActivityCenterModel>.Interface.GetActivityCharacterTrialRewardState(challengeGroupId);
		RedDot.SetActive(activityCharacterTrialRewardState == ActivityCenterModel.ActivityRewardState.Receive);
	}

	public override void OnPointerEnter(PointerEventData eventData)
	{
		base.OnPointerEnter(eventData);
		Hover.SetActive(value: true);
	}

	public override void OnPointerExit(PointerEventData eventData)
	{
		base.OnPointerExit(eventData);
		Hover.SetActive(value: false);
	}
}
