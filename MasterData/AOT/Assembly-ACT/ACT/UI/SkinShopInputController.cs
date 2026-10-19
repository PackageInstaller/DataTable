using ACT.Battle;
using ACT.UI.InputController;
using ACT.UI.ShopSubView;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SkinShopInputController : TabContentInputController<SkinView>
{
	private ContinuousNavigateData _curNavigateState;

	protected override void OnInitView(SkinView view)
	{
		if (!(View == null))
		{
			ViewControlRoot = View.GetComponentInParent<ViewControlRoot>();
			ViewControlLayer = View.skinLoopScrollRect.GetComponentInChildren<ViewControlLayer>();
		}
	}

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
			ACT.UI.ShopSubView.SkinItem component = EventSystemHelper.CurrentSelected.GetComponent<ACT.UI.ShopSubView.SkinItem>();
			if ((bool)component)
			{
				EventSystemHelper.ClickPointer(component.actButton);
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
		case MoveDirection.Left:
			ViewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot?.SelectRight();
			break;
		}
	}
}
