using ACT.UI;
using Fundamental;

namespace ACT.Config.Condition;

public class CheckGachaViewRootIsOpen : GuideStepCondition
{
	public override bool CheckCondition()
	{
		if (!(Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CARDDRAW) is CardDrawView cardDrawView) || cardDrawView.UIController.State != UIState.Opened || Singleton<NewUIManager>.instance.IsActivePanelBusy())
		{
			return false;
		}
		if (cardDrawView.GachaViewRoot != null)
		{
			return cardDrawView.GachaViewRoot.activeSelf;
		}
		return false;
	}
}
