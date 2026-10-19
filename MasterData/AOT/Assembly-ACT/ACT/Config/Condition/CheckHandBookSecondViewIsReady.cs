using ACT.UI;
using ACT.UI.Interface;
using Fundamental;
using Sirenix.Serialization;

namespace ACT.Config.Condition;

public class CheckHandBookSecondViewIsReady : GuideStepCondition
{
	private enum SecondViewType
	{
		BaseCultivate,
		BossBattle,
		DataCalibration,
		SkillCultivate
	}

	[OdinSerialize]
	private SecondViewType secondViewType;

	public override bool CheckCondition()
	{
		IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_HANDBOOK);
		if (baseUIView == null || baseUIView.UIController.State != UIState.Opened || Singleton<NewUIManager>.instance.IsActivePanelBusy())
		{
			return false;
		}
		HandBookTab handBookTab = (baseUIView as MonoHandbookView)?.ActiveTab;
		if (handBookTab == null || !(handBookTab.Content is RaidTabView raidTabView))
		{
			return false;
		}
		if (raidTabView.ActiveTab == null)
		{
			return false;
		}
		ITabContent content = raidTabView.ActiveTab.Content;
		if (!(content is BaseCultivateView))
		{
			if (!(content is BossBattleTabView))
			{
				if (!(content is DataCalibrationView))
				{
					if (content is SkillCultivateView)
					{
						return secondViewType == SecondViewType.SkillCultivate;
					}
					return false;
				}
				return secondViewType == SecondViewType.DataCalibration;
			}
			return secondViewType == SecondViewType.BossBattle;
		}
		return secondViewType == SecondViewType.BaseCultivate;
	}
}
