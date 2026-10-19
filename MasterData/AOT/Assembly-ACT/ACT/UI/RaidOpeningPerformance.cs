using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.Chronos;
using Fundamental;
using Runtime.Battle.ChaseBattle;
using TMPro;

namespace ACT.UI;

public class RaidOpeningPerformance : BaseUIComponent, IBattleMainComponent
{
	public TextMeshProUGUI Title;

	public TextMeshProUGUI Description;

	public const int CloseTime = 2000;

	public BetterAnimation betterAnimation;

	private Delayer duration;

	private const int TEMPLE_TITLE_LOCALIZE = 2265;

	private const int TEMPLE_CONTENT_LOCALIZE = 2271;

	private const int ABYSS_TITLE_LOCALIZE = 2261;

	private const int ABYSS_CONTENT_LOCALIZE = 2269;

	private const int TEAM_CHALLENGE_KILL_TITLE_LOCALIZE = 2262;

	private const int TEAM_CHALLENGE_INTERACT_TITLE_LOCALIZE = 2260;

	private const int TEAM_CHALLENGE_COLLECT_TITLE_LOCALIZE = 2883;

	private const int TEAM_CHALLENGE_SURVIVE_TITLE_LOCALIZE = 2884;

	public void Init(RaidOpeningPerformanceComponentData data, Action onShowFail)
	{
		try
		{
			gameObject.SetActive(value: true);
			RefreshDisplay(data);
			PlayAnim();
			if (!duration.IsValid())
			{
				duration = UpdateTimer.Default.DelayMs(2000, Close);
			}
			onClose = () =>
			{
				Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.UpperMiddle);
			};
		}
		catch (Exception)
		{
			onShowFail?.Invoke();
			Close();
			throw;
		}
	}

	private void RefreshDisplay(RaidOpeningPerformanceComponentData data)
	{
		if (data != null)
		{
			Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, data.titleLocalizeId);
			Description.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, data.descriptionLocalizeId);
			return;
		}
		int num = 0;
		int num2 = 0;
		HudType hudType = Model<BattleMainModel>.Interface.hudType;
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		ACT.Config.Raid value = null;
		bool flag = currentRaidId > 0 && RuntimeConfigs.data.raids.TryGetValue(currentRaidId, out value);
		RaidEntranceData value2 = null;
		if (flag && value != null)
		{
			RuntimeConfigs.data.raidEntranceDatas.TryGetValue(value.belongEntranceData, out value2);
		}
		if (flag && TryRefreshTeamTeachingDisplay(value, value2))
		{
			return;
		}
		if (hudType == HudType.RaidType || hudType == HudType.TeamTeaching)
		{
			if (!flag || value2 == null)
			{
				Close();
				return;
			}
			if (value2.raidTipTitile <= 0 || value2.raidTip <= 0)
			{
				Close();
				return;
			}
			Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value2.raidTipTitile);
			Description.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, value2.raidTip);
			return;
		}
		if (MonoECS.instance.sceneStatus == SceneStatus.Temple)
		{
			TempleData curChallengeTempleData = Model<TempleModel>.Interface.GetCurChallengeTempleData();
			if (curChallengeTempleData != null && RuntimeConfigs.data.instanceDungeonTypes.TryGetValue(curChallengeTempleData.staticData.type, out var value3))
			{
				if (value3.instanceDungeonTipsTitile <= 0 || value3.instanceDungeonTips <= 0)
				{
					Close();
					return;
				}
				Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value3.instanceDungeonTipsTitile);
				Description.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, value3.instanceDungeonTips);
			}
			return;
		}
		if (MonoECS.instance.sceneStatus == SceneStatus.Abyss)
		{
			num = 2261;
			num2 = 2269;
		}
		else if (Singleton<ChaseBattleManager>.instance.IsInChaseBattle)
		{
			num = 2265;
			num2 = 2271;
		}
		if (num <= 0 || num2 <= 0)
		{
			Close();
			return;
		}
		Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, num);
		Description.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, num2);
	}

	private bool TryRefreshTeamTeachingDisplay(ACT.Config.Raid raidConfig, RaidEntranceData raidEntranceConfig)
	{
		if (!IsTeamTeachingRaid(raidConfig?.id ?? 0))
		{
			return false;
		}
		int teamTeachingTitleLocalizeId = GetTeamTeachingTitleLocalizeId(raidConfig, out var titleParameter);
		int teamTeachingDescriptionLocalizeId = GetTeamTeachingDescriptionLocalizeId(raidConfig);
		if (teamTeachingTitleLocalizeId <= 0 || teamTeachingDescriptionLocalizeId <= 0)
		{
			return false;
		}
		string text = ((titleParameter >= 0) ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, teamTeachingTitleLocalizeId, new List<object> { titleParameter }) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, teamTeachingTitleLocalizeId));
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, teamTeachingDescriptionLocalizeId);
		Title.text = text;
		Description.text = localizeString;
		return true;
	}

	private static bool IsTeamTeachingRaid(int raidId)
	{
		if (raidId <= 0 || RuntimeConfigs.data?.trainingContentss == null)
		{
			return false;
		}
		foreach (TrainingContents value in RuntimeConfigs.data.trainingContentss.Values)
		{
			if (value.raidID == raidId)
			{
				return true;
			}
		}
		return false;
	}

	private static int GetTeamTeachingTitleLocalizeId(ACT.Config.Raid raidConfig, out int titleParameter)
	{
		titleParameter = -1;
		if (raidConfig?.firstReward == null || RuntimeConfigs.data?.ruless == null)
		{
			return 2262;
		}
		for (int i = 0; i < raidConfig.firstReward.Count; i++)
		{
			int num = raidConfig.firstReward[i]?.id ?? 0;
			if (num > 0 && RuntimeConfigs.data.ruless.TryGetValue(num, out var value) && value != null)
			{
				switch ((ChallengeTargetRuleId)value.rulesId)
				{
				case ChallengeTargetRuleId.InteractFinish:
					return 2260;
				case ChallengeTargetRuleId.CollectAll:
					return 2883;
				case ChallengeTargetRuleId.SurviveTime:
					titleParameter = value.number;
					return 2884;
				}
			}
		}
		return 2262;
	}

	private static int GetTeamTeachingDescriptionLocalizeId(ACT.Config.Raid raidConfig)
	{
		if (raidConfig?.firstReward == null || RuntimeConfigs.data?.ruless == null)
		{
			return 2268;
		}
		for (int i = 0; i < raidConfig.firstReward.Count; i++)
		{
			int num = raidConfig.firstReward[i]?.id ?? 0;
			if (num > 0 && RuntimeConfigs.data.ruless.TryGetValue(num, out var value) && value != null)
			{
				ChallengeTargetRuleId rulesId = (ChallengeTargetRuleId)value.rulesId;
				if ((uint)(rulesId - 38) <= 2u)
				{
					return 2267;
				}
			}
		}
		return 2268;
	}

	private void Close()
	{
		if (duration.IsValid())
		{
			duration.Cancel();
		}
		onClose?.Invoke();
		onClose = null;
		gameObject.SetActive(value: false);
	}

	private void PlayAnim()
	{
		betterAnimation.GetSequence("Show").Play();
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
	}

	public void OpenComponent()
	{
	}

	public void UnInitialize()
	{
		Close();
	}
}
