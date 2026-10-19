using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopUpExchangeCodeViewInputController : BaseUIViewInputController<PopUpExchangeCodeView>
{
	private ContinuousNavigateData navData;

	private bool FocusInput { get; set; }

	private bool IsInputFocused
	{
		get
		{
			if (!FocusInput)
			{
				PopUpExchangeCodeView view = View;
				if ((object)view == null)
				{
					return false;
				}
				return view.inputField?.isFocused == true;
			}
			return true;
		}
	}

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

	[GameInputBindingBool("UI/UISpecial1")]
	public void Paste(bool value)
	{
		if (value && !IsInputFocused)
		{
			if (View.CanPaste)
			{
				View.OnPasteClicked();
			}
			else if (View.CanClear)
			{
				View.OnClearClicked();
			}
		}
	}

	[GameInputBindingBool("UI/Esc")]
	public void Focus(bool value)
	{
		if (value)
		{
			View.FocusInput(focus: true);
			View.viewControlLayer.UnFocus();
			FocusInput = true;
			View.ReBindBtnPrompt(hasConfirm: false);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (value)
		{
			if (FocusInput)
			{
				View.FocusInput(focus: false);
				View.viewControlLayer.ReFocus();
				FocusInput = false;
				View.ReBindBtnPrompt(hasConfirm: true);
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
		if (IsInputFocused)
		{
			navData?.Reset();
		}
		else
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (!IsInputFocused)
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
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!IsInputFocused && value)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}
}
