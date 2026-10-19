using ACT.Battle;

namespace ACT.UI.ShopViewInputController;

public class ShopViewInputController : BaseUIViewInputController<ShopView>
{
	[GameInputBindingBool("UI/UISpecial2")]
	public void ButtonWest(bool value)
	{
		if (value)
		{
			View.OnGamepadOpenTotalRechargeActivity();
		}
	}
}
