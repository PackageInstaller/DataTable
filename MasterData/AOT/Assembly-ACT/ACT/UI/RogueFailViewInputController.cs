using ACT.Battle;

namespace ACT.UI;

public class RogueFailViewInputController : BaseUIViewInputController<RogueFailView>
{
	protected override void OnActivate()
	{
		base.OnActivate();
		View.viewControlLayer.ReFocus();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.BtnLeave.OnClick?.Invoke();
		}
	}
}
