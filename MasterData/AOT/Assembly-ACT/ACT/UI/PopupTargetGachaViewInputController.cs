using ACT.Battle;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopupTargetGachaViewInputController : BaseUIViewInputController<PopupTargetGachaView>
{
	private ContinuousNavigateData navigateData;

	private ViewControlRoot viewControlRoot;

	private bool previousPagePressed;

	private bool nextPagePressed;

	protected override void OnInitView(PopupTargetGachaView view)
	{
		base.OnInitView(view);
		viewControlRoot = view.viewControlRoot;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		navigateData?.Reset();
		previousPagePressed = false;
		nextPagePressed = false;
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			View?.FocusSelectedTargetCharacter();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navigateData?.Reset();
		previousPagePressed = false;
		nextPagePressed = false;
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			View?.FocusSelectedTargetCharacter();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref navigateData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Left:
			viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			viewControlRoot?.SelectRight();
			break;
		}
		View?.RefreshSelectedCharacterByGamepad();
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirm(bool value)
	{
		if (value)
		{
			StopActionPropagation("UI/Confirm");
			View?.HandleGamepadConfirm();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	private void OnPreviousPage(bool value)
	{
		if (previousPagePressed != value)
		{
			previousPagePressed = value;
			if (value)
			{
				StopActionPropagation("UI/SwitchPageUp");
				View?.HandleGamepadSwitchTab(next: false);
			}
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	private void OnNextPage(bool value)
	{
		if (nextPagePressed != value)
		{
			nextPagePressed = value;
			if (value)
			{
				StopActionPropagation("UI/SwitchPageDown");
				View?.HandleGamepadSwitchTab(next: true);
			}
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		StopActionPropagation("UI/Back");
		if (!value)
		{
			View?.HandleGamepadCancel();
		}
	}
}
