using ACT.Battle;
using ACT.UI.InputController;
using ACT.UI.ShopSubView;

namespace ACT.UI;

public class CharacterSkinSubShopInputController : SubUIViewInputController<CharacterSkinSubShopView>
{
	[GameInputBindingBool("UI/Confirm")]
	public void OnSwitchPageLeft(bool isPressed)
	{
		if (!isPressed)
		{
			EventSystemHelper.ClickPointer(View.buyButton);
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void OnView(bool isPressed)
	{
		if (!isPressed)
		{
			EventSystemHelper.ClickPointer(View.helpButton);
		}
	}
}
