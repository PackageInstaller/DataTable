using ACT.Battle;
using ACT.UI.InputController;

namespace ACT.UI;

public class RogueHudCharacterTipSubController : SubUIViewInputController<RogueHudCharacterTip>
{
	[GameInputBindingBool("UI/Interact")]
	public void Confirm(bool value)
	{
		if (value)
		{
			if (View.BtnBuy.gameObject.activeInHierarchy)
			{
				EventSystemHelper.Click(View.BtnBuy);
			}
			else if (View.BtnGet.gameObject.activeInHierarchy)
			{
				EventSystemHelper.Click(View.BtnGet);
			}
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void Detail(bool value)
	{
		if (value)
		{
			View.BtnDetails.OnClick?.Invoke();
		}
	}
}
