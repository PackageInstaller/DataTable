using ACT.Battle;
using TMPro;

namespace ACT.UI;

public class AccountDecorationChangeNameInputController : BaseUIViewInputController<PopUpAccountDecorationChangeNameView>
{
	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		View?.UnselectInputFieldByGamePad();
	}

	[GameInputBindingBool("UI/UISpecial4")]
	public void SelectInputField(bool value)
	{
		if (value)
		{
			View?.SelectInputFieldByGamePad();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if ((View == null) | value)
		{
			return;
		}
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			View.ConfirmByGamePad();
			return;
		}
		TMP_InputField inputName = View.inputName;
		if ((object)inputName == null || !inputName.isFocused)
		{
			View.ConfirmByGamePad();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.CloseByGamePad();
		}
	}
}
