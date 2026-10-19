using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class BottleShowSubController : SubUIViewInputController<BloodIBottleShow>
{
	private ContinuousNavigateData curNavigateState;

	private BloodBottleView parentView => View.ParentUIView as BloodBottleView;

	private void RefreshSelection()
	{
		ACT.ViewControl.SelectableEx curBottleCellSelectable = View.GetCurBottleCellSelectable();
		if (curBottleCellSelectable != null)
		{
			View.bottleLayer?.SetDefaultSelect(curBottleCellSelectable);
		}
		View.bottleLayer?.Focus();
	}

	protected override void OnActivate()
	{
	}

	protected override void OnDeactivate()
	{
		curNavigateState?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			if (!EventSystemHelper.CurrentSelected || View.bottleLayer.LastSelect == null)
			{
				RefreshSelection();
			}
			else
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, ExecuteNavigate);
			}
		}
	}

	private void ExecuteNavigate(MoveDirection duration)
	{
		switch (duration)
		{
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
	public void GoToLevelUp(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamePadSpecial1();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnSpecial2(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamePadSpecial2();
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void Back(bool value)
	{
		if (parentView != null && !value)
		{
			parentView.CloseEvent();
		}
	}

	private void OnNavigateSelect()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if ((bool)currentSelected)
		{
			EventSystemHelper.Click(currentSelected);
		}
	}
}
