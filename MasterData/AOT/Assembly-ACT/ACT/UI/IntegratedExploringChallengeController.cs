using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class IntegratedExploringChallengeController : SubUIViewInputController<IntegratedExploringChallengeView>
{
	public IntegratedExploringChallengeControlType ControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnActivate()
	{
		base.OnActivate();
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
			if (ControlType == IntegratedExploringChallengeControlType.Reward)
			{
				View.ChangeControlType(IntegratedExploringChallengeControlType.Item, reFocus: true);
			}
			else if (ControlType == IntegratedExploringChallengeControlType.Item)
			{
				View.Close();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void LeftTrigger(bool value)
	{
		if (value && ControlType == IntegratedExploringChallengeControlType.Item)
		{
			View.SwitchPageLeft();
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void RightTrigger(bool value)
	{
		if (value)
		{
			View.SwitchPageRight();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value && ControlType == IntegratedExploringChallengeControlType.Item)
		{
			View.OpenActivityDetail();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == IntegratedExploringChallengeControlType.Item)
		{
			View.ChangeControlType(IntegratedExploringChallengeControlType.Reward);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ButtonWest(bool value)
	{
		if (!value && ControlType == IntegratedExploringChallengeControlType.Item)
		{
			View.OpenShop();
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
