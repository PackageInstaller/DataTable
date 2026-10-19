using ACT.Battle;

namespace ACT.UI;

public class ActivityCenterViewInputController : BaseUIViewInputController<ActivityCenterView>
{
	[GameInputBindingBool("UI/LeftSwitchRole")]
	public void LeftShoulder(bool value)
	{
		if (value)
		{
			View.LeftShoulder();
		}
	}

	[GameInputBindingBool("UI/RightSwitchRole")]
	public void RightShoulder(bool value)
	{
		if (value)
		{
			View.RightShoulder();
		}
	}
}
