using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class PopUpChangePlayerIconInputController : BaseUIViewInputController<MonoPopUpChangePlayerIcon>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateData?.Reset();
		View?.RefreshGamepadFocus();
		View?.RefreshGamePadHints();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		View?.RefreshGamepadFocus();
		View?.RefreshGamePadHints();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void SwitchPageUp(bool value)
	{
		if (value)
		{
			View.SwitchTabByGamepad(-1);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void SwitchPageDown(bool value)
	{
		if (value)
		{
			View.SwitchTabByGamepad(1);
		}
	}

	[GameInputBindingFloat("UI/RSUpDownSelect")]
	public void RightStickScrollPrompt(float value)
	{
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.OnSubmit();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.Close();
		}
	}
}
