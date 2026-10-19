using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class TreasureAdditionsViewInputController : BaseUIViewInputController<TreasureAdditionsView>
{
	private ContinuousNavigateData _curNavigateData;

	public TreasureAdditionsViewControlType ControlType { get; set; }

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

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void LeftShoulder(bool value)
	{
		if (value)
		{
			View.SwitchPageUp();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void RightShoulder(bool value)
	{
		if (value)
		{
			View.SwitchPageDown();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.HandleConfirm();
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void LeftTrigger(bool value)
	{
		if (value && ControlType == TreasureAdditionsViewControlType.CharacterProperty)
		{
			View.OnGlobalPropertyHandle();
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void RightTrigger(bool value)
	{
		if (value && ControlType == TreasureAdditionsViewControlType.GlobalProperty)
		{
			View.OnCharacterPropertyHandle();
		}
	}
}
