using ACT.Battle;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SevendaySignInController : SubUIViewInputController<SevenDaySignIn>
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

	[GameInputBindingBool("LargeMapView/MapTemple")]
	public void ButtonWest(bool value)
	{
		if (value)
		{
			View.ButtonWest();
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

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.ActivityCenterView.Exit();
		}
	}
}
