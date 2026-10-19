using ACT.Battle;

namespace ACT.UI;

public class PopUpWildBossCountdownViewInputController : BaseUIViewInputController<PopUpWildBossCountdownView>
{
	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			View.ConfirmByGamePad();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.CloseByGamePad();
		}
	}
}
