using ACT;
using ACT.Battle;
using ACT.UI;
using ACT.UI.InputController;
using ACT.UI.ShopSubView.GiftCenterSecondSubView;
using UnityEngine;
using UnityEngine.EventSystems;

public class BundleShopViewInputController : TabContentInputController<BundleShop>
{
	private ContinuousNavigateData _curNavigateState;

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateState?.Reset();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool isPressed)
	{
		if (!isPressed)
		{
			BundleItem component = EventSystemHelper.CurrentSelected.GetComponent<BundleItem>();
			if ((bool)component)
			{
				EventSystemHelper.ClickPointer(component.clickArea);
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void OnSpecialPress(bool isPressed)
	{
		if (!isPressed)
		{
			BundleItem component = EventSystemHelper.CurrentSelected.GetComponent<BundleItem>();
			if ((bool)component)
			{
				EventSystemHelper.Click(component.helpButton);
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (!EventSystemHelper.CurrentSelected)
		{
			FocusViewControlLayer();
		}
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Up:
			ViewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot?.SelectRight();
			break;
		}
	}
}
