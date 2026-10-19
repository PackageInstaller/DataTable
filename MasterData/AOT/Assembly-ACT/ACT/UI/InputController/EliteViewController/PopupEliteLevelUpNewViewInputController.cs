using ACT.Battle;
using UnityEngine;

namespace ACT.UI.InputController.EliteViewController;

public class PopupEliteLevelUpNewViewInputController : BaseUIViewInputController<PopupEliteLevelUpNewView>
{
	private const float LeftStickDeadZone = 0.35f;

	private const float LeftStickReleaseZone = 0.15f;

	private const float LeftStickNavCooldown = 0.12f;

	private int _lastLeftStickXDirection;

	private int _lastLeftStickYDirection;

	private float _nextLeftStickXConsumeTime;

	private float _nextLeftStickYConsumeTime;

	protected override void OnActivate()
	{
		base.OnActivate();
		ResetLeftStickConsumeState();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		ResetLeftStickConsumeState();
	}

	[GameInputBindingBool("LargeMapView/Select")]
	private void OnGamePadSelect(bool value)
	{
		if (value && !(View == null))
		{
			switch (View.GetCurrentPromptControllerType())
			{
			case EliteViewSubControllerType.SelectEliteCurrency:
				View.HandleGamepadSubmitEliteCurrency();
				break;
			case EliteViewSubControllerType.SelectReinforcedMaterial:
				View.HandleGamepadSubmitInSelectMaterial();
				break;
			case EliteViewSubControllerType.ElitePointUpGarde:
				View.eliteLevelUpPanelNew?.HandleGamepadUpgradeShortcut();
				break;
			}
		}
	}

	[GameInputBindingBool("LargeMapView/Return")]
	private void OnGamePadReturn(bool value)
	{
		if (value && !(View == null))
		{
			StopActionPropagation("LargeMapView/Return");
			StopActionPropagation("UI/Back");
			if (View.IsSelectConsumeItemMode())
			{
				View.HandleGamepadCancelInSelectMaterial();
			}
			else if (View.IsSelectEliteCurrencyMode())
			{
				View.ExitEliteCurrencyMode();
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingBool("UI/View")]
	private void OnGamePadView(bool value)
	{
		if (value && !(View == null))
		{
			EliteViewSubControllerType currentPromptControllerType = View.GetCurrentPromptControllerType();
			if (currentPromptControllerType == EliteViewSubControllerType.ElitePointUpGarde)
			{
				View.EliteDisc?.HandleGamePadSelectViewBtnInput(currentPromptControllerType);
			}
		}
	}

	[GameInputBindingBool("UI/LongPressX")]
	private void OnGamePadX(bool value)
	{
		if (!(View == null))
		{
			View.HandleGamepadXPressed(value, View.GetCurrentPromptControllerType());
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	private void OnGamePadRightStickPress(bool value)
	{
		if (!value && !(View == null) && View.GetCurrentPromptControllerType() == EliteViewSubControllerType.ElitePointUpGarde)
		{
			View.EnterEliteCurrencyMode();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	private void OnGamePadLeftStickClick(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamepadLeftStickClick(View.GetCurrentPromptControllerType());
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void OnGamePadNavigate(Vector2 value)
	{
		if (View == null)
		{
			return;
		}
		EliteViewSubControllerType currentPromptControllerType = View.GetCurrentPromptControllerType();
		if (currentPromptControllerType == EliteViewSubControllerType.SelectEliteCurrency)
		{
			bool flag = TryConsumeLeftStickX(value.x, out var filteredValue);
			bool flag2 = TryConsumeLeftStickY(value.y, out var filteredValue2);
			if (flag | flag2)
			{
				View.HandleGamepadEliteCurrencyNavigate(flag ? filteredValue : filteredValue2);
			}
			return;
		}
		if (TryConsumeLeftStickX(value.x, out var filteredValue3))
		{
			if (currentPromptControllerType == EliteViewSubControllerType.SelectReinforcedMaterial)
			{
				View.HandleGamepadLeftStickHorizontalInSelectMaterial(filteredValue3);
			}
			else
			{
				View.EliteDisc?.HandleGamePadSelectLeftStickXBtnInput(currentPromptControllerType, filteredValue3);
			}
		}
		if (TryConsumeLeftStickY(value.y, out var filteredValue4))
		{
			if (currentPromptControllerType == EliteViewSubControllerType.SelectReinforcedMaterial)
			{
				View.HandleGamepadLeftStickVerticalInSelectMaterial(filteredValue4);
			}
			else
			{
				View.EliteDisc?.HandleGamePadSelectLeftStickYBtnInput(currentPromptControllerType, filteredValue4);
			}
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		if (View == null)
		{
			return;
		}
		StopActionPropagation("UI/Back");
		StopActionPropagation("LargeMapView/Return");
		if (!value)
		{
			if (View.IsSelectConsumeItemMode())
			{
				View.HandleGamepadCancelInSelectMaterial();
			}
			else if (View.IsSelectEliteCurrencyMode())
			{
				View.ExitEliteCurrencyMode();
			}
			else
			{
				View.Close();
			}
		}
	}

	private bool TryConsumeLeftStickX(float value, out float filteredValue)
	{
		filteredValue = 0f;
		return TryConsumeLeftStickAxis(value, ref _lastLeftStickXDirection, ref _nextLeftStickXConsumeTime, out filteredValue);
	}

	private bool TryConsumeLeftStickY(float value, out float filteredValue)
	{
		filteredValue = 0f;
		return TryConsumeLeftStickAxis(value, ref _lastLeftStickYDirection, ref _nextLeftStickYConsumeTime, out filteredValue);
	}

	private void ResetLeftStickConsumeState()
	{
		_lastLeftStickXDirection = 0;
		_lastLeftStickYDirection = 0;
		_nextLeftStickXConsumeTime = 0f;
		_nextLeftStickYConsumeTime = 0f;
	}

	private static bool TryConsumeLeftStickAxis(float value, ref int lastDirection, ref float nextConsumeTime, out float filteredValue)
	{
		filteredValue = 0f;
		float num = Mathf.Abs(value);
		if (num < 0.15f)
		{
			lastDirection = 0;
			return false;
		}
		if (num < 0.35f)
		{
			return false;
		}
		int num2 = ((value > 0f) ? 1 : (-1));
		if (num2 == lastDirection)
		{
			return false;
		}
		float unscaledTime = Time.unscaledTime;
		if (unscaledTime < nextConsumeTime)
		{
			return false;
		}
		lastDirection = num2;
		nextConsumeTime = unscaledTime + 0.12f;
		filteredValue = num2;
		return true;
	}
}
