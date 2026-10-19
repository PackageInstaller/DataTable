using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class MainlineMotivationController : SubUIViewInputController<MainlineMotivationView>
{
	public MainlineMotivationControllerType ControlType;

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
			if (ControlType == MainlineMotivationControllerType.Reward)
			{
				View.ChangeControlType(MainlineMotivationControllerType.Item, reFocus: true);
			}
			else
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

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value && ControlType == MainlineMotivationControllerType.Item)
		{
			View.OpenActivityDetail();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == MainlineMotivationControllerType.Item)
		{
			View.ChangeControlType(MainlineMotivationControllerType.Reward);
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (!value && ControlType == MainlineMotivationControllerType.Item)
		{
			View.GoToFirstUncompleted();
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
