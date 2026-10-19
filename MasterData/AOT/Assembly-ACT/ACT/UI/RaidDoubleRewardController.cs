using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class RaidDoubleRewardController : SubUIViewInputController<RaidDoubleReward>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(RaidDoubleReward view)
	{
		base.OnInitView(view);
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnInputModeChange(MonoECS.instance.InputMode);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		View.OnInputModeChange(type);
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.OnClose();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void ButtonSouth(bool value)
	{
		if (!value)
		{
			View.OnGoto();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.TimeAndDesItem.OnClickActivityDetailButtonHandle();
		}
	}
}
