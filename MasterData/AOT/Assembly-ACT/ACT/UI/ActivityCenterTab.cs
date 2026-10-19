using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class ActivityCenterTab : MonoBehaviour
{
	[Serializable]
	public class SpriteInfo
	{
		public int ActivityType;

		public Sprite Sprite;
	}

	public GameObject SelectBG;

	public GameObject SelectBG2;

	public BImage Icon;

	public TextMeshProUGUI Name;

	public GameObject MaskNormal;

	public Button ItemButton;

	public RedDotItem redDot;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private Action<int> _callBack;

	private ActivityData _activityData;

	private bool _isSelect;

	public int ActivityId => _activityData?.id ?? 0;

	public void UpdateTabView(ImageAssetStation station, ActivityData activityData)
	{
		if (activityData != null)
		{
			ItemButton.SetBtnClick(OnClickTabButtonHandle, "event:/UI/Interface/Activity/Tab_Left");
			_activityData = activityData;
			RefreshRedDot();
			Name.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, activityData.activityName);
			station.LoadImage(197, activityData.id, Icon);
			SetSelect(value: false);
		}
	}

	public void SetSelect(bool value)
	{
		_isSelect = value;
		SelectBG.SetActive(value);
		SelectBG2.SetActive(value);
		MaskNormal.SetActive(!value);
		if (value)
		{
			SetRedpointState();
		}
		if (_betterAnimation != null)
		{
			_betterAnimation.GetSequence(value ? "Selected" : "Normal").Play();
		}
	}

	public void SetClickCallBack(Action<int> callBack)
	{
		_callBack = callBack;
	}

	public void OnClickTabButtonHandle()
	{
		_callBack?.Invoke(_activityData.id);
	}

	public void RefreshRedDot()
	{
		if (redDot == null || _activityData == null)
		{
			return;
		}
		if (Model<ActivityCenterModel>.Interface.GetActivityTabRedpointState(_activityData.id))
		{
			redDot.redDotType = RedDotType.New;
			redDot.displayAction = new ActivityCenterTabAction();
			redDot.fullPath = (RedDotPathDefine.ActivityCenter + $"|{_activityData.id}").Split("|").ToList();
			redDot.BindTrieNode();
			redDot.UpdateDisplay();
			return;
		}
		List<string> redDotPath = GetRedDotPath(_activityData);
		RedDotDisplayAction redDotDisplayAction = GetRedDotDisplayAction(_activityData.id, _activityData.activityType, _activityData.prefabType);
		if (redDotPath != null)
		{
			redDot.redDotType = RedDotType.Dot;
			redDot.fullPath = redDotPath;
			redDot.displayAction = redDotDisplayAction;
			redDot.BindTrieNode();
			redDot.UpdateDisplay();
		}
	}

	private List<string> GetRedDotPath(ActivityData activityData)
	{
		return (ActivityType)activityData.activityType switch
		{
			ActivityType.PlayerLevel => RedDotPathDefine.Activity_PlayerLevel.Split("|").ToList(), 
			ActivityType.SignIn => activityData.prefabType switch
			{
				1 => RedDotPathDefine.Activity_SevenDaySignIn.Split("|").ToList(), 
				2 => string.Format(RedDotPathDefine.Activity_TenDaySignIn, activityData.id).Split("|").ToList(), 
				3 => RedDotPathDefine.Activity_ThirtyFiveDaySignIn.Split("|").ToList(), 
				_ => null, 
			}, 
			ActivityType.ActivityAbyss => RedDotPathDefine.Activity_Abyss.Split("|").ToList(), 
			ActivityType.ExploringChallenge => RedDotPathDefine.Activity_ChallengeRewardTab.Split("|").ToList(), 
			ActivityType.TempleChallenge => RedDotPathDefine.Activity_Temple.Split("|").ToList(), 
			ActivityType.CharacterTrial => string.Format(RedDotPathDefine.Activity_CharacterTrial, activityData.id).Split("|").ToList(), 
			ActivityType.DailyLottery => RedDotPathDefine.Activity_DailyLottery.Split("|").ToList(), 
			ActivityType.SkinTrial => string.Format(RedDotPathDefine.Activity_SkinTrial, activityData.id).Split("|").ToList(), 
			ActivityType.TotalRecharge => RedDotPathDefine.Activity_TotalRecharge.Split("|").ToList(), 
			ActivityType.OneTreat => RedDotPathDefine.Activity_OneTreat.Split("|").ToList(), 
			ActivityType.MainlineMotivation => RedDotPathDefine.Activity_MainlineMotivation.Split("|").ToList(), 
			ActivityType.LimitedTimeMapExploration => RedDotPathDefine.Activity_LimitedTimeMapExploration.Split("|").ToList(), 
			ActivityType.CompanionMission => RedDotPathDefine.Activity_CompanionMission.Split("|").ToList(), 
			ActivityType.RaidDoubleReward => RedDotPathDefine.Activity_RaidDoubleReward.Split("|").ToList(), 
			ActivityType.MultiDevice => RedDotPathDefine.Activity_MultiDevice.Split("|").ToList(), 
			_ => null, 
		};
	}

	private RedDotDisplayAction GetRedDotDisplayAction(int activityId, int activityType, int prefabType)
	{
		return (ActivityType)activityType switch
		{
			ActivityType.PlayerLevel => new ActivityPlayerLevelChallangeRewardOnTab(), 
			ActivityType.SignIn => prefabType switch
			{
				1 => (RedDotDisplayAction)new ActivitySevenDaySignInRewardOnTab(activityId), 
				2 => new ActivityTenDaySignInRewardOnTab(activityId), 
				3 => new Activity35DaySignInRewardOnTab(activityId), 
				_ => null, 
			}, 
			ActivityType.ActivityAbyss => new ActivityAbyssInRewardOnTab(), 
			ActivityType.ExploringChallenge => new ActivityCharacterExploreChallengeOnTab(), 
			ActivityType.TempleChallenge => new ActivityTempleRewardOnTab(), 
			ActivityType.CharacterTrial => new ActivityCharacterTrialOnTab(activityId), 
			ActivityType.DailyLottery => new ActivityDailyLotteryOnTab(), 
			ActivityType.SkinTrial => new ActivitySkinTrialRewardOnTab(activityId), 
			ActivityType.TotalRecharge => new SelfNodeActive(), 
			ActivityType.OneTreat => new SelfNodeActive(), 
			ActivityType.MainlineMotivation => new SelfNodeActive(), 
			ActivityType.LimitedTimeMapExploration => new SelfNodeActive(), 
			ActivityType.CompanionMission => new SelfNodeActive(), 
			_ => null, 
		};
	}

	private void SetRedpointState()
	{
		if (_activityData != null && Model<ActivityCenterModel>.Interface.GetActivityTabRedpointState(_activityData.id))
		{
			G.localPlayer.redPoints.Activitys[_activityData.id] = false;
			RedPoints redPoints = new RedPoints();
			redPoints.Activitys.Add(_activityData.id, value: false);
			G.service.RefreshRedDot(redPoints, (bool value) =>
			{
				Model<ActivityCenterModel>.Interface.RefreshRedDot();
				RefreshRedDot();
			});
		}
	}

	public void PlayInitAnimation()
	{
		if (_betterAnimation != null)
		{
			_betterAnimation.GetSequence(_isSelect ? "SelectedShow" : "NormalShow").Play();
		}
	}
}
