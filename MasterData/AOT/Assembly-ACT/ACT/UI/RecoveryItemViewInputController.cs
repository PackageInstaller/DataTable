using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;

namespace ACT.UI;

public class RecoveryItemViewInputController : BaseUIViewInputController<RecoveryItemView>
{
	public RecoveryItemViewControlType ControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == RecoveryItemViewControlType.Reward)
			{
				View.ChangeControlType(RecoveryItemViewControlType.Main);
			}
			else
			{
				View.Close();
			}
		}
	}

	protected override void OnEscPressed(bool value)
	{
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == RecoveryItemViewControlType.Main)
		{
			View.ChangeControlType(RecoveryItemViewControlType.Reward);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value && !(EventSystemHelper.CurrentSelected == null))
		{
			EventSystemHelper.ClickCurrent();
		}
	}
}
