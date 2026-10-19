using ACT.Battle;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ActivityAbyssController : SubUIViewInputController<ActivityAbyss>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection moveDirection)
	{
		switch (moveDirection)
		{
		case MoveDirection.Left:
			View.Left();
			break;
		case MoveDirection.Right:
			View.Right();
			break;
		case MoveDirection.Up:
			View.Up();
			break;
		case MoveDirection.Down:
			View.Down();
			break;
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value)
		{
			View.LeftStickPress();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.RightStickPress();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (value)
		{
			View.ButtonNorth();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void ButtonSouth(bool value)
	{
		if (value)
		{
			View.ButtonSouth();
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.ButtonEast();
		}
	}
}
