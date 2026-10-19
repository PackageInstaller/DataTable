using ACT.UI;
using Fundamental;

namespace ACT.Config.Condition;

public class CheckViewIsReady : GuideStepCondition
{
	public UI_TYPE UIType;

	public override bool CheckCondition()
	{
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI == null || topActiveUI.UIType != UIType)
		{
			return false;
		}
		IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UIType);
		if (baseUIView?.UIController != null && baseUIView.UIController.State == UIState.Opened)
		{
			return !Singleton<NewUIManager>.instance.IsActivePanelBusy();
		}
		return false;
	}
}
