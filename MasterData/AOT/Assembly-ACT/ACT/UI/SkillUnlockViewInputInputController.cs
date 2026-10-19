using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SkillUnlockViewInputInputController : BaseUIViewInputController<SkillUnlockView>
{
	private bool inSelection;

	private ContinuousNavigateData navData;

	public bool IsSelectingItems => inSelection;

	public override bool BlockElderHandle => true;

	private bool IsCoinOperating
	{
		get
		{
			if (View != null && View.coinGroup != null)
			{
				return View.coinGroup.IsOperating;
			}
			return false;
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.coinGroup?.FocusIn();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navData?.Reset();
		View.coinGroup?.FocusOut();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value || IsCoinOperating)
		{
			return;
		}
		if (inSelection)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
		else if (View.confirmButton.interactable && View.submitPrompt.gameObject.activeSelf)
		{
			View.OnConfirmClick();
		}
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void Scroll(Vector2 value)
	{
		View.Scroll(value);
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void LeftBtnClick(bool isPress)
	{
		if (!isPress && !IsCoinOperating)
		{
			EventSystemHelper.Click(View.leftButton);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void RightBtnClick(bool isPress)
	{
		if (!isPress && !IsCoinOperating)
		{
			EventSystemHelper.Click(View.rightButton);
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	public void SelectItem(bool value)
	{
		if (value && !IsCoinOperating)
		{
			View.iconViewControlLayer.Focus();
			View.submitPrompt.gameObject.SetActive(value: false);
			inSelection = true;
			View.ReBindBtnPrompt(showConfirm: true);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value && !IsCoinOperating)
		{
			if (inSelection)
			{
				View.iconViewControlLayer.UnFocus();
				View.baseViewControlLayer.Focus();
				View.submitPrompt.gameObject.SetActive(value: true);
				inSelection = false;
				View.ReBindBtnPrompt(showConfirm: false);
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (!IsCoinOperating)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			View.iconViewControlLayer.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.iconViewControlLayer.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.iconViewControlLayer.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.iconViewControlLayer.Root?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
		}
	}
}
