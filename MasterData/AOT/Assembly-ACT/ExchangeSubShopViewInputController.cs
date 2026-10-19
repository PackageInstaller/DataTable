using System;
using ACT;
using ACT.Battle;
using ACT.UI;
using ACT.UI.InputController;
using ACT.UI.Interface;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;

public class ExchangeSubShopViewInputController : TabContentInputController<ExchangeShop>
{
	private bool _focusAfterItemBagUpdate;

	private ContinuousNavigateData _curNavigateState;

	protected override void OnActivate()
	{
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateState?.Reset();
	}

	public override void OnTabActive(ITabItem tabItem)
	{
		if (!(View?.itemBag == null))
		{
			CommonScrollBagComponent itemBag = View.itemBag;
			itemBag.OnUpdateEnd = (Action)Delegate.Remove(itemBag.OnUpdateEnd, new Action(OnItemBagUpdateEnd));
			CommonScrollBagComponent itemBag2 = View.itemBag;
			itemBag2.OnUpdateEnd = (Action)Delegate.Combine(itemBag2.OnUpdateEnd, new Action(OnItemBagUpdateEnd));
			_focusAfterItemBagUpdate = true;
		}
	}

	public override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		_focusAfterItemBagUpdate = false;
		if (View?.itemBag != null)
		{
			CommonScrollBagComponent itemBag = View.itemBag;
			itemBag.OnUpdateEnd = (Action)Delegate.Remove(itemBag.OnUpdateEnd, new Action(OnItemBagUpdateEnd));
		}
		if (View != null)
		{
			View.FocusOut();
		}
	}

	private void OnItemBagUpdateEnd()
	{
		if (_focusAfterItemBagUpdate)
		{
			_focusAfterItemBagUpdate = false;
			ViewControlLayer?.Focus();
			View.FocusIn();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool isPressed)
	{
		if (!isPressed)
		{
			ExchangeShopItemUIComponent component = EventSystemHelper.CurrentSelected.GetComponent<ExchangeShopItemUIComponent>();
			if ((bool)component)
			{
				EventSystemHelper.ClickPointer(component);
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
