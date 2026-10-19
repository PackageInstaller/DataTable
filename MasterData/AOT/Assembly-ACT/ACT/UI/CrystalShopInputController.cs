using ACT.Battle;
using ACT.UI.InputController;
using ACT.UI.Interface;
using ACT.UI.ShopSubView;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CrystalShopInputController : TabContentInputController<CrystalShopView>
{
	public static readonly GamePadTipsAction CustomerServiceAction = new GamePadTipsAction
	{
		inputAction = "UI/UISpecial1",
		localizeTable = "Common",
		localizeKey = 2687
	};

	private ContinuousNavigateData _curNavigateState;

	protected override void OnInitView(CrystalShopView view)
	{
		if (!(View == null))
		{
			ViewControlRoot = View.GetComponentInParent<ViewControlRoot>();
			ViewControlLayer = View.loopScrollRect.GetComponentInChildren<ViewControlLayer>();
		}
	}

	public override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		FocusViewControlLayer();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateState?.Reset();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool isPressed)
	{
		if (isPressed)
		{
			return;
		}
		if (!EventSystemHelper.CurrentSelected)
		{
			FocusViewControlLayer();
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if ((bool)currentSelected)
		{
			CrystalItem component = currentSelected.GetComponent<CrystalItem>();
			if ((bool)component)
			{
				EventSystemHelper.ClickPointer(component.buyButton);
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnContactCustomerService(bool isPressed)
	{
		if (!isPressed && (bool)View.connectCustomerServiceBtn)
		{
			EventSystemHelper.ClickPointer(View.connectCustomerServiceBtn);
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
