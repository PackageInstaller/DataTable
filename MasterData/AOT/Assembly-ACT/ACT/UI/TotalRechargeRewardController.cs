using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class TotalRechargeRewardController : SubUIViewInputController<TotalRechargeReward>
{
	private ContinuousNavigateData _curNavigateData;

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

	[GameInputBindingBool("UI/OpenTIps")]
	protected void OnOpenTips(bool value)
	{
		if (value)
		{
			View.OnClickActivityDetail();
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
		if (!value)
		{
			View.OnGamepadConfirm();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ReceiveWelcomeReward(bool value)
	{
		if (!value)
		{
			View.OnGamepadReceiveWelcomeReward();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void GotoShop(bool value)
	{
		if (!value)
		{
			View.OnGamepadGotoShop();
		}
	}
}
