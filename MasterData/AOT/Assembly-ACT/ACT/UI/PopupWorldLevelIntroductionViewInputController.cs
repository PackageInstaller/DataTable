namespace ACT.UI;

public class PopupWorldLevelIntroductionViewInputController : BaseUIViewInputController<PopUpWorldLevelIntroductionView>
{
	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.Close();
		}
	}
}
