using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;

namespace ACT.UI;

public class CharacterPresentationViewInputController : BaseUIViewInputController<CharacterPresentationView>
{
	private float lastPressTime;

	public CharacterPresentationViewControlType ViewControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(CharacterPresentationView view)
	{
		base.OnInitView(view);
		ViewControlType = CharacterPresentationViewControlType.Main;
		View.ChangeViewControlType(ViewControlType);
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		UpdateGamepadTips();
		View.ChangeViewControlType(ViewControlType);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			UpdateGamepadTips();
			View.ChangeViewControlType(ViewControlType);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (View.IsHide)
			{
				View.CancelHideUI();
			}
			else if (View.IsMoreDropdownOpen)
			{
				View.CloseMoreDropdown();
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	public void LeftStackPress(bool value)
	{
		if (!View.IsHide && value)
		{
			View.OnClickCopyUIDButtonHandle();
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void RightTrigger(bool value)
	{
		if (!View.IsHide && value && Time.unscaledTime - lastPressTime > 0.5f)
		{
			lastPressTime = Time.unscaledTime;
			View.OnClickMoreRenameButtonHandle();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!View.IsHide && value)
		{
			EventSystemHelper.ClickCurrent();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void BtnEdit(bool value)
	{
		if (!View.IsHide && !value)
		{
			EventSystemHelper.Click(View.BtnEdit);
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void OnSwitchPageUp(bool value)
	{
		if (!View.IsHide && !value)
		{
			View.SwitchItemUp();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void OnSwitchPageDown(bool value)
	{
		if (!View.IsHide && !value)
		{
			View.SwitchItemDown();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (View.IsHide)
		{
			_curNavigateData?.Reset();
		}
		else
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
		}
	}

	private void UpdateGamepadTips()
	{
		View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnHideUI(bool value)
	{
		if (!value)
		{
			View.ToggleHideUI();
		}
	}
}
