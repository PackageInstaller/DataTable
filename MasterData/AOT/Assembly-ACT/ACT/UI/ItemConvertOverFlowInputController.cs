using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ItemConvertOverFlowInputController : BaseUIViewInputController<ItemConvertOverflowView>
{
	private ContinuousNavigateData _navigateData;

	private ViewControlRoot _viewControlRoot;

	private static readonly GamePadTipsAction SelectItemAction = new GamePadTipsAction
	{
		inputAction = "UI/SelectItemCell",
		localizeTable = "Common",
		localizeKey = 774
	};

	private static readonly GamePadTipsAction ItemDetailAction = new GamePadTipsAction
	{
		inputAction = "UI/Confirm",
		localizeTable = "Common",
		localizeKey = 1642
	};

	protected override void OnInitView(ItemConvertOverflowView view)
	{
		base.OnInitView(view);
		_viewControlRoot = view?.viewControlRoot;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_navigateData?.Reset();
		MonoECS instance = MonoECS.instance;
		if ((object)instance != null && instance.InputMode == DeviceInputMode.Gamepad)
		{
			FocusButtonLayer();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_navigateData?.Reset();
		View?.itemControlLayer?.UnFocus();
		View?.btnGroupControlLayer?.UnFocus();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (View == null)
		{
			return;
		}
		if (type == DeviceInputMode.Gamepad)
		{
			if (_viewControlRoot?.CurrentFocusLayer == View.itemControlLayer)
			{
				FocusItemLayer();
			}
			else
			{
				FocusButtonLayer();
			}
		}
		else
		{
			_navigateData?.Reset();
			View.gamePadTipsComp?.ClearAllPrompts();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null) && !(_viewControlRoot == null))
		{
			ViewControlLayer currentFocusLayer = _viewControlRoot.CurrentFocusLayer;
			if (!(currentFocusLayer != View.itemControlLayer) || !(currentFocusLayer != View.btnGroupControlLayer))
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref _navigateData, ExecuteNavigate);
			}
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void SelectItemCell(bool value)
	{
		if (value && !(View == null) && IsLayerReady(View.btnGroupControlLayer))
		{
			FocusItemLayer();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value || View == null || !EventSystemHelper.Available || _viewControlRoot == null)
		{
			return;
		}
		ViewControlLayer currentFocusLayer = _viewControlRoot.CurrentFocusLayer;
		if (currentFocusLayer != View.itemControlLayer && currentFocusLayer != View.btnGroupControlLayer)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			if (currentFocusLayer == View.itemControlLayer)
			{
				EventSystemHelper.Click(currentSelected.GetComponent<ItemUIComponentBase>() ?? currentSelected.GetComponentInParent<ItemUIComponentBase>());
			}
			else
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value && !(View == null))
		{
			ViewControlLayer itemControlLayer = View.itemControlLayer;
			if ((object)itemControlLayer != null && itemControlLayer.IsFocused)
			{
				FocusButtonLayer();
			}
			else
			{
				View.Close();
			}
		}
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		if (_viewControlRoot == null)
		{
			_viewControlRoot = View?.viewControlRoot;
		}
		switch (direction)
		{
		case MoveDirection.Left:
			_viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			_viewControlRoot?.SelectRight();
			break;
		case MoveDirection.Up:
			_viewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			_viewControlRoot?.SelectDown();
			break;
		}
	}

	private void FocusButtonLayer()
	{
		if (View == null || !IsLayerReady(View.btnGroupControlLayer))
		{
			return;
		}
		_navigateData?.Reset();
		if (View.btnGroupControlLayer.LastSelect != null && View.btnGroupControlLayer.LastSelect.IsValid())
		{
			View.btnGroupControlLayer.ReFocus();
		}
		else
		{
			ACT.ViewControl.SelectableEx selectableEx = View.confirmButton?.GetComponent<ACT.ViewControl.SelectableEx>();
			if (selectableEx != null)
			{
				View.btnGroupControlLayer.SetDefaultSelect(selectableEx);
			}
			View.btnGroupControlLayer.Focus();
		}
		UpdateGamepadTips();
	}

	private void FocusItemLayer()
	{
		if (!(View == null) && IsLayerReady(View.itemControlLayer))
		{
			_navigateData?.Reset();
			if (View.itemControlLayer.LastSelect != null && View.itemControlLayer.LastSelect.IsValid())
			{
				View.itemControlLayer.ReFocus();
			}
			else
			{
				View.itemControlLayer.Focus();
			}
			UpdateGamepadTips();
		}
	}

	private bool IsLayerReady(ViewControlLayer layer)
	{
		if (layer != null && _viewControlRoot != null)
		{
			return layer.Root == _viewControlRoot;
		}
		return false;
	}

	private void UpdateGamepadTips()
	{
		if (!(View?.gamePadTipsComp == null))
		{
			if (View.itemControlLayer != null && View.itemControlLayer.IsFocused)
			{
				View.gamePadTipsComp.RegisterInputActions(ItemDetailAction, GamePadTipHelper.BackAction);
			}
			else
			{
				View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction, SelectItemAction);
			}
		}
	}
}
