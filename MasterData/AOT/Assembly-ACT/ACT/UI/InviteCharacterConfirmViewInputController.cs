using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class InviteCharacterConfirmViewInputController : BaseUIViewInputController<UI_InviteCharacterConfirmView>
{
	private const float NavigateHorizontalDeadZone = 0.35f;

	[GameInputBindingBool("UI/Confirm")]
	private void OnGamepadConfirm(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamepadSubmit();
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		StopActionPropagation("UI/Back");
		if (!(View == null) && !value)
		{
			View.HandleGamepadCancel();
		}
	}

	[GameInputBindingFloat("UI/LSLeftRightSelect")]
	private void OnLeftStickHorizontal(float value)
	{
		View?.HandleGamepadLeftStickHorizontal(value);
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void OnNavigate(Vector2 value)
	{
		if (!(View == null) && !(Mathf.Abs(value.x) < 0.35f))
		{
			View.HandleGamepadLeftStickHorizontal(value.x);
		}
	}
}
