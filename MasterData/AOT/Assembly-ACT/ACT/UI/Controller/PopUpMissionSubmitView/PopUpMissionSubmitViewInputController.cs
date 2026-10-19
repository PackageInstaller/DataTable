namespace ACT.UI.Controller.PopUpMissionSubmitView;

public class PopUpMissionSubmitViewInputController : BaseUIViewInputController<MonoPopUpMissionSubmitView>
{
	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.OnBtnDown(needSubmit: false);
		}
	}
}
