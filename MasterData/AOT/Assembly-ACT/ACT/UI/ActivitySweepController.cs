using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;

namespace ACT.UI;

public class ActivitySweepController : SubUIViewInputController<ActivitySweep>
{
	public ActivitySweepControllerType ControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == ActivitySweepControllerType.Page1Reward)
			{
				View.ChangeControlType(ActivitySweepControllerType.Page1Main);
			}
			else if (ControlType == ActivitySweepControllerType.Page1Main)
			{
				View.ActivityCenterView.Exit();
			}
			else if (ControlType == ActivitySweepControllerType.Page2Reward)
			{
				View.ChangeControlType(ActivitySweepControllerType.Page2Main);
			}
			else if (ControlType == ActivitySweepControllerType.Page2Main)
			{
				EventSystemHelper.Click(View.backButton);
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value && (ControlType == ActivitySweepControllerType.Page1Main || ControlType == ActivitySweepControllerType.Page2Main))
		{
			View.OpenActivityDetail();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value)
		{
			if (ControlType == ActivitySweepControllerType.Page1Main)
			{
				View.ChangeControlType(ActivitySweepControllerType.Page1Reward);
			}
			else if (ControlType == ActivitySweepControllerType.Page2Main)
			{
				View.ChangeControlType(ActivitySweepControllerType.Page2Reward);
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ButtonWest(bool value)
	{
		if (!value && ControlType == ActivitySweepControllerType.Page2Main)
		{
			View.OpenMissionGroupDetail();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (!value)
		{
			if (ControlType == ActivitySweepControllerType.Page1Main)
			{
				EventSystemHelper.Click(View.confirmButton);
			}
			else if (ControlType == ActivitySweepControllerType.Page2Main)
			{
				View.OnGoto();
			}
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			View.OnConfirm();
		}
	}
}
