using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class BottleMatChangeSubController : SubUIViewInputController<BloodIBottleMatChange>
{
	private ContinuousNavigateData curNavigateState;

	private GameObject curSelect;

	private BloodBottleView parentView => View.ParentUIView as BloodBottleView;

	private void RefreshSelection()
	{
		ACT.ViewControl.SelectableEx curMaterialCellSelectable = View.GetCurMaterialCellSelectable();
		if (curMaterialCellSelectable != null)
		{
			View.materialsLayer?.SetDefaultSelect(curMaterialCellSelectable);
		}
		View.materialsLayer?.Focus();
	}

	protected override void OnActivate()
	{
		RefreshSelection();
	}

	protected override void OnDeactivate()
	{
		curNavigateState?.Reset();
	}

	[GameInputBindingBool("UI/Back")]
	public void Back(bool value)
	{
		if (parentView != null && !value)
		{
			parentView.CloseEvent();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			if (!EventSystemHelper.CurrentSelected || View.materialsLayer.LastSelect == null)
			{
				RefreshSelection();
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection duration)
	{
		switch (duration)
		{
		case MoveDirection.Up:
			parentView?.viewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			parentView?.viewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			parentView?.viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			parentView?.viewControlRoot?.SelectRight();
			break;
		}
		OnNavigateSelect();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void ClickChangeBottleMat(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamePadSpecial2();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void SelectSlotUp(bool value)
	{
		if (value && !(View == null))
		{
			View.SelectSlotUp();
			RefreshSelection();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void SelectSlotDown(bool value)
	{
		if (value && !(View == null))
		{
			View.SelectSlotDown();
			RefreshSelection();
		}
	}

	private void OnNavigateSelect()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if ((bool)currentSelected && !currentSelected.Equals(curSelect))
		{
			curSelect = currentSelected;
			EventSystemHelper.Click(currentSelected);
		}
	}
}
