using ACT.Battle;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class DecorationSubInputController : SubUIViewInputController<DecorationView>, ISubInputController, IInputController, IGameInputBindingHandle
{
	private ContinuousNavigateData _curNavigateState;

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateState?.Reset();
		UpdateGamepadTips();
	}

	[GameInputBindingBool("UI/Back")]
	public void OnBack(bool value)
	{
		if (!value)
		{
			View.Close();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			View.OnGamepadConfirm();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Left:
		case MoveDirection.Up:
			View.SelectSkinByOffset(-1);
			break;
		case MoveDirection.Right:
		case MoveDirection.Down:
			View.SelectSkinByOffset(1);
			break;
		}
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		SetScatteredGamepadTipsVisible(type == DeviceInputMode.Gamepad);
		if (type == DeviceInputMode.Gamepad)
		{
			UpdateGamepadTips();
		}
	}

	private void UpdateGamepadTips()
	{
		View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.BackAction);
	}

	private void SetScatteredGamepadTipsVisible(bool visible)
	{
		if (View.gamepadTips == null)
		{
			return;
		}
		foreach (GameObject gamepadTip in View.gamepadTips)
		{
			if (gamepadTip != null)
			{
				gamepadTip.SetActive(visible);
			}
		}
	}
}
