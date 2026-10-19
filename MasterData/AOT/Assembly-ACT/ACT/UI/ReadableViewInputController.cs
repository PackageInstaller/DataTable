using ACT.Battle;

namespace ACT.UI;

public class ReadableViewInputController : BaseUIViewInputController<ReadableView>
{
	[GameInputBindingBool("UI/CommonSelect")]
	private void OnGamepadSelectImage(bool value)
	{
		if (value && !(View == null))
		{
			View.OnGamepadSelect();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (value && !(View == null))
		{
			View.OnGamepadBack();
		}
	}
}
