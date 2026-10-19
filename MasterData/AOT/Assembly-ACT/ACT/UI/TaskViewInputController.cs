using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TaskViewInputController : BaseUIViewInputController<TaskPanel>
{
	private ContinuousNavigateData navData;

	public bool InDetail { get; set; }

	protected override void OnActivate()
	{
		base.OnActivate();
		if (InDetail)
		{
			View.listControlLayer.UnFocus();
			View.detailControlLayer.Focus();
		}
		else
		{
			View.detailControlLayer.UnFocus();
			View.listControlLayer.ReFocus();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navData?.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		if (value)
		{
			if (InDetail)
			{
				View.detailControlLayer.UnFocus();
				View.listControlLayer.ReFocus();
				InDetail = false;
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void ToDetail(bool value)
	{
		if (value)
		{
			View.listControlLayer.UnFocus();
			View.detailControlLayer.Focus();
			InDetail = true;
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnTrack(bool value)
	{
		if (value)
		{
			View.Track();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void PrevTab(bool value)
	{
		if (value)
		{
			View.CycleTab(forward: false);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void NextTab(bool value)
	{
		if (value)
		{
			View.CycleTab(forward: true);
		}
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void OnScroll(Vector2 value)
	{
		View.Scroll(value);
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (InDetail)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
			return;
		}
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			EventSystemHelper.Click(currentSelected);
			View.RefreshRightStickScrollForbid();
			View.ReBindBtnPrompt();
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			View.listControlLayer.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.listControlLayer.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.listControlLayer.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.listControlLayer.Root?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (value)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}
}
