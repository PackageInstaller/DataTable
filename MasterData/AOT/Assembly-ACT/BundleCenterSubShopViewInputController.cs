using ACT.Battle;
using ACT.UI;
using ACT.UI.InputController;
using ACT.UI.ShopSubView;

public class BundleCenterSubShopViewInputController : SubUIViewInputController<BundleCenterSubShopView>
{
	[GameInputBindingBool("UI/Confirm")]
	public void OnSwitchPageLeft(bool isPressed)
	{
		if (!isPressed)
		{
			EventSystemHelper.ClickPointer(View.buyBtn);
		}
	}
}
