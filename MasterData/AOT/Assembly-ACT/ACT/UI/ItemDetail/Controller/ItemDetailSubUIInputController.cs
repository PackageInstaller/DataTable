using ACT.Battle;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI.ItemDetail.Controller;

public class ItemDetailSubUIInputController : SubUIViewInputController<CommonItemDetail>
{
	private ContinuousNavigateData _continuousNavigateData;

	private ViewControlLayer _itemDetailViewControlLayer;

	protected override void OnInitView(CommonItemDetail view)
	{
		base.OnInitView(view);
		_itemDetailViewControlLayer = View.GetComponentInChildren<ViewControlLayer>();
		view.UpdateGamepadStyle();
	}

	public void RefreshController()
	{
		_itemDetailViewControlLayer = View.GetComponentInChildren<ViewControlLayer>();
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void OnLockPressed(bool value)
	{
		if (!value)
		{
			IBagItem source = View.ItemUnifierProxy.Source;
			if (source is Equip || source is Gem)
			{
				EventSystemHelper.ClickPointer(View._commonStyle.lockBtn.lockBtn);
			}
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			IBagItem source = View.ItemUnifierProxy.Source;
			if ((source is Item || source is GiftPackage) && View.InputState == ItemDetailGamePadInputState.Item_FocusJumpPart)
			{
				View.InputState = ItemDetailGamePadInputState.Item_NoFocus;
				_itemDetailViewControlLayer.UnFocus();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void OnViewPressed(bool value)
	{
		IBagItem source = View.ItemUnifierProxy.Source;
		if (!(source is Item) && !(source is GiftPackage))
		{
			if (!(source is Equip))
			{
				if (source is Gem)
				{
					View._gemStyle.gemBuffDetail.OpenBuffDetail(playClickSound: true);
				}
			}
			else
			{
				View._equipStyle.equipBuffDetail.OpenBuffDetail(playClickSound: true);
			}
		}
		else if (value && View.InputState == ItemDetailGamePadInputState.Item_NoFocus)
		{
			View.InputState = ItemDetailGamePadInputState.Item_FocusJumpPart;
			_itemDetailViewControlLayer?.Focus();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnSubmitPressed(bool value)
	{
		if (value)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ItemSource component = currentSelected.GetComponent<ItemSource>();
			if (!(component == null))
			{
				EventSystemHelper.ClickPointer(component.btn);
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null) && View.InputState == ItemDetailGamePadInputState.Item_FocusJumpPart)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _continuousNavigateData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection obj)
	{
		switch (obj)
		{
		case MoveDirection.Up:
			View.viewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			View.viewControlRoot.SelectDown();
			break;
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_continuousNavigateData?.Reset();
	}
}
