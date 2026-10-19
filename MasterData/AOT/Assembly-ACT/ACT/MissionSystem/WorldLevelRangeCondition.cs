using System.Collections.Generic;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class WorldLevelRangeCondition : MissionCondition, IConditionDescriptionHyperLink
{
	private LocalizedString m_HyperlinkText;

	private LocalizedString m_Description;

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		if (CoreUtils.GetData(1003, RuntimeConfigs.data.systemOpens) != null)
		{
			if (m_Description == null)
			{
				m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
			}
			if (m_HyperlinkText == null)
			{
				m_HyperlinkText = new LocalizedString(LocalizationUtility.localizeTableName_Common, 41000210L);
				m_HyperlinkText["0"] = new LocalizedString(LocalizationUtility.localizeTableName_Common, 2233L);
			}
			yield return new ConditionDescription
			{
				HaveContent = (Desc != 0),
				DescriptionContent = m_Description,
				HaveHyperLink = true,
				HyperLinkText = m_HyperlinkText,
				HyperLinkLogic = this
			};
		}
	}

	void IConditionDescriptionHyperLink.OnClick()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONOJOURNEYTRACESVIEW);
	}

	protected override async void OnInMissionWorld()
	{
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
		WorldLevelRangeConditionParam worldLevelRangeConditionParam = Param as WorldLevelRangeConditionParam;
		int curWorldLevel = Model<WorldLevelModel>.Interface.GetCurWorldLevel();
		if (curWorldLevel >= worldLevelRangeConditionParam.minLevel)
		{
			return curWorldLevel <= worldLevelRangeConditionParam.maxLevel;
		}
		return false;
	}
}
