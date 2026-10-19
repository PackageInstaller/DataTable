using ACT.Battle;

namespace ACT.UI;

public class BottleLevelUpSubController : SubUIViewInputController<BloodIBottleLevelUp>
{
	private BloodBottleView parentView => View.ParentUIView as BloodBottleView;

	[GameInputBindingBool("UI/Confirm")]
	public void ClickLevelUp(bool value)
	{
		if (!value && View.levelUpBtn != null && View.levelUpBtn.IsInteractable())
		{
			View.levelUpBtn.OnClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void Back(bool value)
	{
		if (parentView != null && !value)
		{
			parentView.CloseEvent();
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void OnRightStickPress(bool value)
	{
		if (!value)
		{
			View.haveCoin?.InputClick();
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	public void OnLeftStackPress(bool value)
	{
		if (!value)
		{
			View.costItem?.onToggleClick?.Invoke();
		}
	}
}
