using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class ActivitySkinTrialController : SubUIViewInputController<ActivitySkinTrial>
{
	private ContinuousNavigateData _curNavigateData;

	public ActivitySkinTrialControlType ControlType { get; set; }

	protected override void OnInitView(ActivitySkinTrial view)
	{
		base.OnInitView(view);
		ControlType = ActivitySkinTrialControlType.Main;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		View.OnInputDeviceChange(type);
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == ActivitySkinTrialControlType.Reward)
			{
				View.ChangeControlType(ActivitySkinTrialControlType.Main);
			}
			else
			{
				View.OnClose();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.OnConfirm();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value && ControlType == ActivitySkinTrialControlType.Main)
		{
			View.OnRightStickPress();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (value && ControlType == ActivitySkinTrialControlType.Main)
		{
			View.OnClickGotoTrialHandle();
		}
	}

	[GameInputBindingBool("UI/Start")]
	public void Start(bool value)
	{
		if (value && ControlType == ActivitySkinTrialControlType.Main)
		{
			View.OnClickGotoShopBtnHandle();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == ActivitySkinTrialControlType.Main)
		{
			View.ChangeControlType(ActivitySkinTrialControlType.Reward);
		}
	}
}
