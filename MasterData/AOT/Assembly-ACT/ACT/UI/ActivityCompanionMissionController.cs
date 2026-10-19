using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class ActivityCompanionMissionController : SubUIViewInputController<ActivityCompanionMission>
{
	private ContinuousNavigateData _curNavigateData;

	public ActivityCompanionMissionControlType ControlType { get; set; }

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnActivate();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		View.OnInputDeviceChange(type);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value && ControlType == ActivityCompanionMissionControlType.Main)
		{
			View.OpenActivityDetail();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value)
		{
			View.OnSelectReward();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (!value)
		{
			View.OnGoto();
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

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == ActivityCompanionMissionControlType.Reward)
			{
				View.ChangeControlType(ActivityCompanionMissionControlType.Main);
			}
			else
			{
				View.ActivityCenterView.Exit();
			}
		}
	}
}
