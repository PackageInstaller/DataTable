using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PowerAddViewInputController : BaseUIViewInputController<MonoPowerAddView>
{
	public void RefreshSelection()
	{
		if ((MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse || MonoECS.instance.InputMode == DeviceInputMode.Gamepad) && !(View == null))
		{
			if (!View.viewControlRoot.ReFocus())
			{
				FocusButtonControlLayer();
			}
			else
			{
				UpdatePromptActive();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(value != Vector2.zero))
		{
			return;
		}
		if (IsCurrentSelectedInCurrentFocusLayer())
		{
			AxisEventData axisEventData = new AxisEventData(EventSystemHelper.Shared);
			axisEventData.Reset();
			axisEventData.moveVector = value;
			axisEventData.moveDir = ContinuousNavigateUtility.DetermineMoveDirection(value.x, value.y, 0.6f);
			if (axisEventData.moveDir != MoveDirection.None)
			{
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, axisEventData, ExecuteEvents.moveHandler);
			}
		}
		else
		{
			RefreshSelection();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void SwitchPageLeft(bool value)
	{
		if (!(View == null) && value && !IsCostControlLayerFocused())
		{
			View.SelectLeftItem();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void SwitchPageRight(bool value)
	{
		if (!(View == null) && value && !IsCostControlLayerFocused())
		{
			View.SelectRightItem();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Submit(bool value)
	{
		if (!value)
		{
			if (IsCurrentSelectedInCurrentFocusLayer())
			{
				EventSystemHelper.ClickCurrent();
			}
			else
			{
				RefreshSelection();
			}
		}
	}

	private bool IsCurrentSelectedInCurrentFocusLayer()
	{
		if (!EventSystemHelper.Available || EventSystemHelper.CurrentSelected == null)
		{
			return false;
		}
		if (View?.viewControlRoot == null)
		{
			return false;
		}
		ViewControlLayer currentFocusLayer = View.viewControlRoot.CurrentFocusLayer;
		if (currentFocusLayer == null || currentFocusLayer.LastSelect == null)
		{
			return false;
		}
		return EventSystemHelper.CurrentSelected == currentFocusLayer.LastSelect.gameObject;
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void TriggerClickCostCell(bool value)
	{
		if (!value && View != null && !IsCostControlLayerFocused())
		{
			FocusCostControlLayer();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (IsCostControlLayerFocused())
			{
				FocusButtonControlLayer();
			}
			else
			{
				View.Close();
			}
		}
	}

	public void UnFocus()
	{
		View.buttonControlLayer?.UnFocus();
		View.costControlLayer?.UnFocus();
	}

	private bool IsCostControlLayerFocused()
	{
		if (View?.viewControlRoot != null)
		{
			return View.viewControlRoot.CurrentFocusLayer == View.costControlLayer;
		}
		return false;
	}

	private void FocusButtonControlLayer()
	{
		if (!(View == null))
		{
			View.costControlLayer?.UnFocus();
			View.buttonControlLayer?.Focus();
			UpdatePromptActive();
		}
	}

	private void FocusCostControlLayer()
	{
		if (!(View == null))
		{
			View.buttonControlLayer?.UnFocus();
			View.costControlLayer?.Focus();
			UpdatePromptActive();
		}
	}

	private void UpdatePromptActive()
	{
		if (!(View == null))
		{
			bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
			bool flag2 = IsCostControlLayerFocused();
			View.UpdateBtnPromptActive(flag && !flag2);
			View.UpdateBottomPromptActive(flag & flag2);
		}
	}
}
