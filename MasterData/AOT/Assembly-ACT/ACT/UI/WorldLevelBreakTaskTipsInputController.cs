using ACT.Battle;

namespace ACT.UI;

public class WorldLevelBreakTaskTipsInputController : SubUIViewInputController<WorldLevelBreakTaskTips>
{
	[GameInputBindingBool("UI/WorldLevelBreakTips")]
	public void JumpToWorldLevelView(bool value)
	{
		if (value)
		{
			View.JumpToWorldLevelView();
		}
	}
}
