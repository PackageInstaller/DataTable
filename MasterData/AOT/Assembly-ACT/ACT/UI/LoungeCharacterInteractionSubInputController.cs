using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class LoungeCharacterInteractionSubInputController : SubUIViewInputController<LoungeCharacterInteractionSubView>
{
	private const float NavigateDeadZone = 0.45f;

	private const float NavigateReleaseZone = 0.2f;

	private const float NavigateConsumeInterval = 0.15f;

	private int _lastVerticalDirection;

	private float _nextNavigateConsumeTime;

	private bool IsGamepadInputBlocked
	{
		get
		{
			if (!(View?.Owner == null) && !View.Owner.IsGamepadBlockedByCameraTransition && !View.Owner.IsAllUiHidden())
			{
				return View.Owner.IsRestoringHiddenUiThisFrame();
			}
			return true;
		}
	}

	protected override void OnActivate()
	{
		_lastVerticalDirection = 0;
		_nextNavigateConsumeTime = 0f;
		View?.OnInteractionChoicesReady();
	}

	protected override void OnDeactivate()
	{
		_lastVerticalDirection = 0;
		_nextNavigateConsumeTime = 0f;
		View?.Owner?.ForceReleaseGamepadConfirmConsume();
		base.OnDeactivate();
	}

	[GameInputBindingBool("UI/Back")]
	private void OnBack(bool value)
	{
	}

	[GameInputBindingBool("UI/UISpecial2")]
	private void OnGamepadX(bool value)
	{
		if (value && !(View?.Owner == null) && !IsGamepadInputBlocked)
		{
			View.Owner.ToggleInteractionChoicePanel();
		}
	}

	[GameInputBindingBool("UI/PressAnyKey")]
	private void OnPressAnyKey(bool value)
	{
		if (value && !(View?.Owner == null))
		{
			View.Owner.TryHandlePressAnyKeyByGamepad();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirm(bool value)
	{
		if (!(View?.Owner == null) && !View.Owner.ShouldConsumeGamepadConfirm(value) && value && !IsGamepadInputBlocked && View.Owner.IsInteractionChoicePanelVisible && View.HasGamepadChoices && (MonoECS.instance.InputMode != DeviceInputMode.KeyboardAndMouse || !View.EnsureFirstChoiceSelected()))
		{
			View.ExecuteSelectedGamepadChoice();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void OnNavigate(Vector2 value)
	{
		if (!(View?.Owner == null) && !IsGamepadInputBlocked && View.Owner.IsInteractionChoicePanelVisible && View.HasGamepadChoices && TryConsumeNavigateVertical(value, out var direction) && (MonoECS.instance.InputMode != DeviceInputMode.KeyboardAndMouse || !View.EnsureFirstChoiceSelected()))
		{
			View.MoveGamepadChoiceSelection(direction);
		}
	}

	private bool TryConsumeNavigateVertical(Vector2 value, out int direction)
	{
		direction = 0;
		float num = Mathf.Abs(value.x);
		float num2 = Mathf.Max(Mathf.Abs(value.y) - num, 0f);
		if (num2 < 0.2f)
		{
			_lastVerticalDirection = 0;
			return false;
		}
		if (num2 < 0.45f)
		{
			return false;
		}
		int num3 = ((!(value.y > 0f)) ? 1 : (-1));
		if (num3 == _lastVerticalDirection || Time.unscaledTime < _nextNavigateConsumeTime)
		{
			return false;
		}
		_lastVerticalDirection = num3;
		_nextNavigateConsumeTime = Time.unscaledTime + 0.15f;
		direction = num3;
		return true;
	}
}
