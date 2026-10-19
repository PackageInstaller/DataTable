using ACT.Battle;

namespace ACT.UI;

public class PopUpWorldLevelUpgradeViewInputController : BaseUIViewInputController<PopUpWorldLevelUpgradeView>
{
	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirm(bool value)
	{
		if (!value)
		{
			View?.ConfirmByGamePad();
		}
	}
}
