using ACT.UI;
using Fundamental;

namespace ACT.Config.Condition;

public class CheckCharacterSecondViewIsReady : GuideStepCondition
{
	public CharacterViewScene.CvSceneType secondViewType;

	public override bool CheckCondition()
	{
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI == null || topActiveUI.UIType != UI_TYPE.UI_CHARACTER)
		{
			return false;
		}
		IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CHARACTER);
		bool num = baseUIView != null && baseUIView.UIController.State == UIState.Opened && !Singleton<NewUIManager>.instance.IsActivePanelBusy();
		bool flag = false;
		if (num)
		{
			flag = (baseUIView as CharacterView).GetSecondViewAniState(secondViewType);
		}
		return num & flag;
	}
}
