using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class PlayerLevelRangeCondition : MissionCondition
{
	private LocalizedString m_Description;

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		object param = Param;
		if (!(param is PlayerLevelRangeConditionParam { guideSystemIds: not null } param2))
		{
			yield break;
		}
		if (Desc != 0)
		{
			if (m_Description == null)
			{
				m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
			}
			yield return new ConditionDescription
			{
				HaveContent = (Desc != 0),
				DescriptionContent = m_Description
			};
		}
		foreach (int guideSystemId in param2.guideSystemIds)
		{
			SystemOpen data = CoreUtils.GetData(guideSystemId, RuntimeConfigs.data.systemOpens);
			if (data != null)
			{
				yield return new ConditionDescription
				{
					HaveHyperLink = true,
					HyperLinkTextId = data.localNameId,
					HyperLinkTextTable = LocalizationUtility.localizeTableName_shortcommon,
					HyperLinkLogic = PermissionLevelCondition.CreateHyperLink(guideSystemId)
				};
			}
		}
	}

	protected override async void OnInMissionWorld()
	{
		if (IsRepeat)
		{
			do
			{
				if (CheckCondition())
				{
					MarkSuccess();
				}
				await UniTask.Yield();
			}
			while (InMissionWorld);
			return;
		}
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		int playerLevel = SystemUnlockManager.playerLevel;
		PlayerLevelRangeConditionParam playerLevelRangeConditionParam = Param as PlayerLevelRangeConditionParam;
		int num = ((playerLevelRangeConditionParam.minLevel == 0) ? int.MinValue : playerLevelRangeConditionParam.minLevel);
		int num2 = ((playerLevelRangeConditionParam.maxLevel == 0) ? int.MaxValue : playerLevelRangeConditionParam.maxLevel);
		if (playerLevel >= num && playerLevel <= num2)
		{
			return true;
		}
		return false;
	}
}
