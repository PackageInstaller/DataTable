using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class RogueReplacementItemViewInputController : BaseUIViewInputController<RogueReplacementItemView>
{
	private ContinuousNavigateData navData;

	protected override void OnActivate()
	{
		base.OnActivate();
		View.viewControlLayer.ReFocus();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navData?.Reset();
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
			EventSystemHelper.Click(currentSelected);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnReplace(bool value)
	{
		if (value && View.BtnReplace.gameObject.activeInHierarchy && View.BtnReplace.interactable)
		{
			View.BtnReplace.OnClick?.Invoke();
		}
	}
}
