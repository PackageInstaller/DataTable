using ACT.Battle;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ActivityTempleChallengeController : SubUIViewInputController<ActivityTempleChallenge>
{
	public ActivityTempleChallengeControlType ControlType;

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
		if (ControlType == ActivityTempleChallengeControlType.Reward)
		{
			View.ExecuteNavigate(moveDirection);
			return;
		}
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

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.RightStickPress();
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

	[GameInputBindingBool("UI/SelectItemCell")]
	protected void OnSelectItemCell(bool value)
	{
		if (!value && ControlType == ActivityTempleChallengeControlType.Main)
		{
			View.ChangeControlType(ActivityTempleChallengeControlType.Reward);
		}
	}
}
