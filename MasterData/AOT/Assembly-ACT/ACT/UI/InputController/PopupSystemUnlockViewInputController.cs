using ACT.Battle;

namespace ACT.UI.InputController;

public class PopupSystemUnlockViewInputController : BaseUIViewInputController<PopupSystemUnlockView>
{
	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value && !(View == null))
		{
			View.ConfirmByGamePad();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (value && !(View == null))
		{
			View.ConfirmByGamePad();
		}
	}
}
