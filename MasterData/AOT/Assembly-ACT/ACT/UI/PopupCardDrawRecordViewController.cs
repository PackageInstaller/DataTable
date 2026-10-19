using ACT.Battle;

namespace ACT.UI;

public class PopupCardDrawRecordViewController : BaseUIViewInputController<PopupCardDrawRecordView>
{
	protected override void OnBackPressed(bool value)
	{
		if (!View.isEmpty && !value)
		{
			View.CloseFromGamepad();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void OnSwitchTabPrev(bool value)
	{
		if (!value)
		{
			View.SwitchTab(next: false);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void OnSwitchTabNext(bool value)
	{
		if (!value)
		{
			View.SwitchTab(next: true);
		}
	}

	[GameInputBindingBool("UI/Prev")]
	public void OnPrev(bool value)
	{
		if (!value)
		{
			View.OnPrevPage();
		}
	}

	[GameInputBindingBool("UI/Next")]
	public void OnNext(bool value)
	{
		if (!value)
		{
			View.OnNextPage();
		}
	}
}
