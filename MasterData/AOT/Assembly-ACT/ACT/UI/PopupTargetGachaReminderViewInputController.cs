using ACT.Battle;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopupTargetGachaReminderViewInputController : BaseUIViewInputController<PopupTargetGachaReminderView>
{
	private ContinuousNavigateData navigateData;

	private ViewControlRoot viewControlRoot;

	private ViewControlLayer viewControlLayer;

	protected override void OnInitView(PopupTargetGachaReminderView view)
	{
		base.OnInitView(view);
		viewControlRoot = view.viewControlRoot;
		viewControlLayer = view.viewControlLayer;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		navigateData?.Reset();
		viewControlLayer?.Focus();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navigateData?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			viewControlLayer?.Focus();
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
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirm(bool value)
	{
		if (value)
		{
			StopActionPropagation("UI/Confirm");
			View?.HandleGamepadSubmit();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	private void OnSpecial2(bool value)
	{
		if (value)
		{
			StopActionPropagation("UI/UISpecial2");
			View?.HandleGamepadToggleSilence();
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
