using ACT.Battle;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SkinSubInputController : SubUIViewInputController<SubSkinView>, ISubInputController, IInputController, IGameInputBindingHandle
{
	private ContinuousNavigateData _curNavigateState;

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateState?.Reset();
	}

	[GameInputBindingBool("UI/Back")]
	public void OnBack(bool value)
	{
		if (!value)
		{
			View.Close();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (!View.IsGamepadFocusInText)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
		}
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

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!View.IsGamepadFocusInText && !value)
		{
			View.OnGamepadConfirm();
		}
	}

	[GameInputBindingBool("UI/UISpecial4")]
	public void OnSpecial4(bool value)
	{
		if (!View.IsGamepadFocusInText && !value)
		{
			View.OnGamepadSpecial4();
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void OnSwitchPageUp(bool value)
	{
		if (!View.IsGamepadFocusInText && !value)
		{
			View.OnGamepadLessen();
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void OnSwitchPageDown(bool value)
	{
		if (!View.IsGamepadFocusInText && !value)
		{
			View.OnGamepadZoom();
		}
	}

	[GameInputBindingFloat("UI/RSLeftRightSelect")]
	public void OnRSLeftRightSelect(float value)
	{
	}

	[GameInputBindingFloat("UI/RSUpDownSelect")]
	public void OnRSUpDownSelect(float value)
	{
	}
}
