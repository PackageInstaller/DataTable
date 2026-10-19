using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TextLibraryViewInputController : BaseUIViewInputController<TextLibraryView>
{
	private ContinuousNavigateData _curNavigateState;

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void LBSwitchTab(bool value)
	{
		if (value && !(View == null) && !View.IsInputFieldTriggered() && !View.inputField.isFocused)
		{
			View.SelectTab(0);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void RbSwitchTab(bool value)
	{
		if (value && !(View == null) && !View.IsInputFieldTriggered() && !View.inputField.isFocused)
		{
			View.SelectTab(1);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!(View == null) && (!(View.inputField != null) || !View.inputField.isFocused) && value)
		{
			View.OnInputConfirm();
		}
	}

	[GameInputBindingBool("UI/SearchSubmit")]
	public void ButtonNorth(bool value)
	{
		if (!(View == null) && value)
		{
			View.OnButtonNorthClick();
		}
	}

	[GameInputBindingBool("UI/TriggerSearchInPutField")]
	public void LeftStickPress(bool value)
	{
		if (!(View == null) && value && !View.isSearching)
		{
			View.TriggerInputField();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null) && (!(View.inputField != null) || !View.inputField.isFocused))
		{
			OnNavigate(value);
		}
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void RightNavigate(Vector2 value)
	{
		if (!(View == null) && (!(View.inputField != null) || !View.inputField.isFocused))
		{
			OnRightNavigate(value);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (value && !(View == null))
		{
			if (View.IsInputFieldTriggered() || View.isSearching)
			{
				View.UntriggerInputField();
			}
			else
			{
				View.Close();
			}
		}
	}

	private void OnRightNavigate(Vector2 value)
	{
		if (!View.IsInputFieldTriggered())
		{
			View.OnRightStickScroll(value);
		}
	}

	private void OnNavigate(Vector2 value)
	{
		if (!View.IsInputFieldTriggered())
		{
			if (!EventSystemHelper.CurrentSelected || View.viewPortControlLayer.LastSelect == null || View.viewPortControlLayer.LastSelect.gameObject != EventSystemHelper.CurrentSelected)
			{
				View.RefreshScrollViewSelection();
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			View.viewPortControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			View.viewPortControlRoot.SelectDown();
			break;
		}
		OnNavigateSelect();
	}

	public void StopNavigate()
	{
		_curNavigateState?.Reset();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		StopNavigate();
	}

	private void OnNavigateSelect()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		bool flag = (object)currentSelected?.GetComponentInParent<TextLibraryCell>() != null;
		if (!flag && View.curSelectedCell != null && View.curSelectedCell.isSelected)
		{
			View.curSelectedCell.SetSelectedState(active: false);
		}
		View.RefreshConfirmPromptState((bool)currentSelected && !flag);
		if (flag)
		{
			EventSystemHelper.Click(currentSelected);
		}
	}
}
