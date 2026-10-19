namespace ACT.UI;

public class SystemGuideViewInputController : BaseUIViewInputController<SystemGuideView>
{
	protected override void OnBackPressed(bool value)
	{
		if (!value && View.GetBookViewOSA() != null)
		{
			if (View.GetBookViewOSA().RightPanelIsActive())
			{
				View.GetBookViewOSA().OnCloseRightPanel();
			}
			else
			{
				View.Close();
			}
		}
	}
}
