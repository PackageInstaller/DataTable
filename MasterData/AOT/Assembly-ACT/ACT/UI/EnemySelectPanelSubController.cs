using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class EnemySelectPanelSubController : SubUIViewInputController<EnemySelectPanel>
{
	private ContinuousNavigateData _curNavigateState;

	protected override void OnActivate()
	{
		RefreshSelection();
	}

	protected override void OnDeactivate()
	{
		_curNavigateState?.Reset();
		View.controlLayer?.UnFocus();
	}

	private void RefreshSelection()
	{
		ACT.ViewControl.SelectableEx curEnemyCellSelectable = View.GetCurEnemyCellSelectable();
		if (curEnemyCellSelectable != null)
		{
			View.controlLayer?.SetDefaultSelect(curEnemyCellSelectable);
		}
		View.controlLayer?.Focus();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if ((bool)currentSelected && View.controlLayer.LastSelect != null)
			{
				EventSystemHelper.Click(currentSelected);
				(View.ParentUIView as TrainingGroundView)?.GetController()?.RefreshSelection();
			}
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void Back(bool value)
	{
		if (!value)
		{
			View.Close();
			(View.ParentUIView as TrainingGroundView)?.GetController()?.RefreshSelection();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			if (!EventSystemHelper.CurrentSelected || View.controlLayer.LastSelect == null)
			{
				RefreshSelection();
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection duration)
	{
		switch (duration)
		{
		case MoveDirection.Up:
			View.controlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			View.controlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			View.controlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.controlRoot?.SelectRight();
			break;
		}
	}
}
