using ACT.Battle;

namespace ACT.UI;

public class CharacterTrialTipsViewController : BaseUIViewInputController<CharacterTrialTipsView>
{
	protected override void OnBackPressed(bool value)
	{
		base.OnBackPressed(value);
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnControllerActivate();
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void LeftTrigger(bool value)
	{
		if (value)
		{
			View.SwitchPageLeft();
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void RightTrigger(bool value)
	{
		if (value)
		{
			View.SwitchPageRight();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.OnConfirm();
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void Select(bool value)
	{
		if (value)
		{
			View.OnSelect();
		}
	}
}
