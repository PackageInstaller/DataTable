using ACT.Battle;

namespace ACT.UI;

public class DeparturePackageViewInputController : BaseUIViewInputController<DeparturePackageView>
{
	protected override void OnActivate()
	{
		base.OnActivate();
		View?.OnActivate();
	}

	protected override void OnBackPressed(bool value)
	{
		base.OnBackPressed(value);
		if (!value)
		{
			View?.Close();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			View?.OnConfirm();
		}
	}
}
