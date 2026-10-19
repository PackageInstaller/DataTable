namespace ACT.UI;

public class ViewportViewInputController : BaseUIViewInputController<ViewportView>
{
	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.Close();
		}
	}
}
