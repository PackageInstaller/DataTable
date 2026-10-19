using ACT.Battle;

namespace ACT.UI;

public class TreasureGetHudTipsInputController : SubUIViewInputController<TreasureGetHudTips>
{
	[GameInputBindingBool("UI/GuideToturial")]
	public void LookTreasure(bool value)
	{
		if (value)
		{
			View.JumpTreasure();
		}
	}
}
