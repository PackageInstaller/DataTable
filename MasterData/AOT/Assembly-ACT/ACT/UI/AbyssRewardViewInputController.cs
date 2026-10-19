using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class AbyssRewardViewInputController : BaseUIViewInputController<MonoAbyssRewardView>
{
	public AbyssRewardViewControllerType ControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(MonoAbyssRewardView view)
	{
		base.OnInitView(view);
		ControlType = AbyssRewardViewControllerType.Tab;
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == AbyssRewardViewControllerType.Tab)
			{
				View.Close();
			}
			else if (ControlType == AbyssRewardViewControllerType.Item)
			{
				View.ChangeInventoryViewControl(AbyssRewardViewControllerType.Tab);
			}
			else if (ControlType == AbyssRewardViewControllerType.ItemReward)
			{
				View.ChangeInventoryViewControl(AbyssRewardViewControllerType.Item);
			}
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnControllerActivate();
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

	[GameInputBindingBool("UI/SearchSubmit")]
	public void ButtonNorth(bool value)
	{
		if (value && ControlType == AbyssRewardViewControllerType.Tab)
		{
			View.OnClickReceiveAllRewardButtonHandle();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == AbyssRewardViewControllerType.Item)
		{
			View.ChangeInventoryViewControl(AbyssRewardViewControllerType.ItemReward);
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
}
