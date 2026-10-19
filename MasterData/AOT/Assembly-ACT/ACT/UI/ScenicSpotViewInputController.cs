using ACT.Battle;

namespace ACT.UI;

public class ScenicSpotViewInputController : BaseUIViewInputController<ScenicSpotView>
{
	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value && !(View == null))
		{
			View.ConfirmByGamePad();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value && !(View == null))
		{
			View.CloseByGamePad();
		}
	}
}
