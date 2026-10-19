using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class EquipBuffFilterViewInputController : BaseUIViewInputController<EquipBuffFilterView>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnActivate()
	{
		base.OnActivate();
		FocusFeatureLayer();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		View?.equipFeatureViewControlLayer.UnFocus();
		_curNavigateData?.Reset();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (!(View == null))
		{
			if (EventSystemHelper.Available && EventSystemHelper.CurrentSelected != null)
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
			}
			else if (View.viewControlRoot == null || !View.viewControlRoot.ReFocus())
			{
				FocusFeatureLayer();
			}
		}
	}

	private void ExecuteNavigate(MoveDirection moveDirection)
	{
		if (!(View?.viewControlRoot == null))
		{
			switch (moveDirection)
			{
			case MoveDirection.Up:
				View.viewControlRoot.SelectUp();
				break;
			case MoveDirection.Down:
				View.viewControlRoot.SelectDown();
				break;
			case MoveDirection.Left:
				View.viewControlRoot.SelectLeft();
				break;
			case MoveDirection.Right:
				View.viewControlRoot.SelectRight();
				break;
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnClear(bool value)
	{
		if (!value)
		{
			View?.ClearSelectedFeatures();
			FocusFeatureLayer();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnApplyFilter(bool value)
	{
		if (!value)
		{
			View?.ConfirmSelectedFeatures();
		}
	}

	private void FocusFeatureLayer()
	{
		if (!(View == null) && (!(View.viewControlRoot != null) || !View.viewControlRoot.ReFocus()))
		{
			View.equipFeatureViewControlLayer?.Focus();
		}
	}
}
