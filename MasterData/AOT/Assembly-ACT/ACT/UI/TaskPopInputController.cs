using ACT.Battle;
using ACT.UI.InputController;

namespace ACT.UI;

public class TaskPopInputController : BaseUIViewInputController<MonoTaskPopView>
{
	protected override void OnBackPressed(bool value)
	{
		Confirm(value);
	}

	[GameInputBindingBool("UI/Confirm")]
	protected void Confirm(bool value)
	{
		if (value && !(View == null))
		{
			EventSystemHelper.Click(View.btnClose);
		}
	}
}
