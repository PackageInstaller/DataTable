using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ShareViewInputController : BaseUIViewInputController<ShareView>
{
	private ContinuousNavigateData navData;

	protected override void OnActivate()
	{
		View.viewControlLayer?.ReFocus();
		base.OnActivate();
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void SaveImage(bool value)
	{
		if (value)
		{
			View.BtnSaveLocal?.ControllerClick();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			View.viewControlLayer.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.viewControlLayer.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.viewControlLayer.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.viewControlLayer.Root?.SelectRight();
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
