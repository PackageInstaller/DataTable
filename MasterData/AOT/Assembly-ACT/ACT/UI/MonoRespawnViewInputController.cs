using ACT.Battle;

namespace ACT.UI;

public class MonoRespawnViewInputController : BaseUIViewInputController<MonoRespawnView>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnActivate()
	{
	}

	protected override void OnDeactivate()
	{
		_curNavigateData?.Reset();
	}

	[GameInputBindingBool("UI/Confirm")]
	protected void Confirm(bool value)
	{
		if (value && !(View == null))
		{
			View.InvokeCloseBtn();
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
	}
}
