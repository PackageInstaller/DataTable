using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class TempleEntranceViewInputController : BaseUIViewInputController<TempleEntranceView>
{
	public TempleEntranceViewControlType ControlType;

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

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == TempleEntranceViewControlType.Reward)
			{
				View.ChangeControlType(TempleEntranceViewControlType.Main);
			}
			else if (ControlType == TempleEntranceViewControlType.Main)
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

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.HandleConfirm();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == TempleEntranceViewControlType.Main)
		{
			View.ChangeControlType(TempleEntranceViewControlType.Reward);
		}
	}
}
