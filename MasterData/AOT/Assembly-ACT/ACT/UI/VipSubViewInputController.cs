using ACT.Battle;
using ACT.UI.InputController;
using ACT.UI.ShopSubView;

namespace ACT.UI;

public class VipSubViewInputController : SubUIViewInputController<VipSubShopView>
{
	[GameInputBindingBool("UI/Confirm")]
	public void OnSwitchPageLeft(bool isPressed)
	{
		if (!isPressed)
		{
			EventSystemHelper.ClickPointer(View.buyBtn);
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void OnView(bool isPressed)
	{
		if (!isPressed)
		{
			EventSystemHelper.ClickPointer(View.helpBtn);
		}
	}
}
