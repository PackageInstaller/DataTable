using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class GiveGiftViewInputInputController : BaseUIViewInputController<UI_GiveGiftView>
{
	public ContinuousNavigateData curNavigateState;

	protected override void OnDeactivate()
	{
		curNavigateState?.Reset();
		View?.ClearGamepadGiftListSelectionOnClose();
		base.OnDeactivate();
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirm(bool value)
	{
		if (!value && !(View == null))
		{
			View.TryAddFocusedGiftByGamepad();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (value && !(View == null))
		{
			if (View.IsGamepadMode)
			{
				View.TryCloseByGamepad();
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	private void OnSendGift(bool value)
	{
		if (!value && !(View == null))
		{
			View.TrySendGiftByGamepad();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	private void OnHideUi(bool value)
	{
		if (!value && !(View == null))
		{
			View.TryToggleHideViewByGamepad();
		}
	}

	[GameInputBindingBool("UI/PressAnyKey")]
	private void OnPressAnyKey(bool value)
	{
		if (!value && !(View == null))
		{
			View.TryHandlePressAnyKeyByGamepad();
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	private void OnReduceGift(bool value)
	{
		if (!value && !(View == null))
		{
			View.TryReduceFocusedGiftByGamepad();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			if (EventSystemHelper.CurrentSelected == null)
			{
				View.RefreshGamepadScrollSelection();
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		View?.ExecuteGamepadNavigate(direction);
	}
}
