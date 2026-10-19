using System;
using ACT.Battle;
using ACT.UI.InputController;

namespace ACT.UI;

public class RogueHudBloodbottleTipSubController : SubUIViewInputController<RogueHudBloodbottleTip>
{
	[GameInputBindingBool("UI/Interact")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			return;
		}
		try
		{
			if (View.BtnBuy.gameObject.activeInHierarchy)
			{
				EventSystemHelper.Click(View.BtnBuy);
			}
			else if (View.BtnGet.gameObject.activeInHierarchy)
			{
				EventSystemHelper.Click(View.BtnGet);
			}
			else if (View.BtnReplace.gameObject.activeInHierarchy)
			{
				EventSystemHelper.Click(View.BtnReplace);
			}
		}
		catch (NullReferenceException)
		{
		}
		catch
		{
			throw;
		}
	}
}
