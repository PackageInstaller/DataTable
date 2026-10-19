using ACT.Battle;

namespace ACT.UI;

public class PopUpPlayerLvAndWorldLvViewInputController : BaseUIViewInputController<PopUpPlayerLvAndWorldLvView>
{
	[GameInputBindingFloat("UI/RSUpDownSelect")]
	public void OnRSUpDownSelect(float value)
	{
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.Close();
		}
	}
}
