using ACT.Battle;

namespace ACT.UI;

public class TeamRenameWinViewInputController : BaseUIViewInputController<TeamRenameWin>
{
	[GameInputBindingBool("UI/UISpecial4")]
	public void OnSpecial4(bool value)
	{
		if (value && !(View == null))
		{
			View.SelectInputFieldByGamePad();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value && !(View == null))
		{
			View.ConfirmByGamePad();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.CloseByGamePad();
		}
	}
}
