using ACT.Battle;

namespace ACT.UI;

public class MonoUseItemViewInputController : BaseUIViewInputController<MonoUseItemView>
{
	public MonoUseItemViewControllerType ControlType;

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == MonoUseItemViewControllerType.Main)
			{
				View.Close();
			}
			else if (ControlType == MonoUseItemViewControllerType.ItemCell)
			{
				View.ChangeUseItemViewControl(MonoUseItemViewControllerType.Main);
			}
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnControllerActivate();
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == MonoUseItemViewControllerType.Main)
		{
			View.LeftStickPress();
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void LeftTrigger(bool value)
	{
		if (value && ControlType == MonoUseItemViewControllerType.Main && View.SubButton.IsInteractable())
		{
			View.OnClickSubBtnHandle();
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void RightTrigger(bool value)
	{
		if (value && ControlType == MonoUseItemViewControllerType.Main && View.AddButton.IsInteractable())
		{
			View.OnClickAddBtnHandle();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ButtonWest(bool value)
	{
		if (value && ControlType == MonoUseItemViewControllerType.Main && View.MaxButton.IsInteractable())
		{
			View.OnClickMaxBtnHandle();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.HandleConfirm();
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.RightStickPress();
		}
	}
}
