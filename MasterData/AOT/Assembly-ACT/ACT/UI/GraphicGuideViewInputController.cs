using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class GraphicGuideViewInputController : BaseUIViewInputController<GraphicGuideView>
{
	private GameObject m_CurSelectItem;

	public ContinuousNavigateData curNavigateState;

	protected override void OnInitView(GraphicGuideView view)
	{
		base.OnInitView(view);
		m_CurSelectItem = null;
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null) && !View.inputTriggerInputField && (View.isSearching || !View.inputField.isFocused))
		{
			if (!EventSystemHelper.CurrentSelected || View.viewPortControlLayer.DefaultSelect == null)
			{
				View.RefreshScrollViewSelection();
			}
			else
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, ExecuteNavigate);
			}
		}
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Up:
			View.viewPortControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			View.viewPortControlRoot?.SelectDown();
			break;
		}
		OnNavigateSelect();
	}

	public void StopNavigation()
	{
		curNavigateState?.Reset();
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void RightNavigate(Vector2 value)
	{
		if (!(View == null) && !View.inputTriggerInputField)
		{
			View.OnRightStickScroll(value);
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

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void LBSwitchTab(bool value)
	{
		if (value && !(View == null) && !View.inputTriggerInputField && (View.isSearching || !View.inputField.isFocused))
		{
			SwitchActiveTab(-1);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void RbSwitchTab(bool value)
	{
		if (value && !(View == null) && !View.inputTriggerInputField && (View.isSearching || !View.inputField.isFocused))
		{
			SwitchActiveTab(1);
		}
	}

	private void SwitchActiveTab(int direction)
	{
		for (int i = View.selectToggleIndex + direction; i >= 0 && i < View.toggles.Length; i += direction)
		{
			if (View.toggles[i].activeInHierarchy)
			{
				View.SelectTab(i);
				break;
			}
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void SwitchPageLeft(bool value)
	{
		if (!(View == null) && value && !View.inputTriggerInputField && (View.isSearching || !View.inputField.isFocused) && !(View.tutorialInfo == null))
		{
			View.tutorialInfo.SetToPreIndex();
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void SwitchPageRight(bool value)
	{
		if (!(View == null) && value && !View.inputTriggerInputField && (View.isSearching || !View.inputField.isFocused) && !(View.tutorialInfo == null))
		{
			View.tutorialInfo.SetToNextIndex();
		}
	}

	[GameInputBindingBool("UI/TriggerSearchInPutField")]
	public void TriggerInputField(bool value)
	{
		if (!(View == null) && value)
		{
			StopNavigation();
			View.InputTriggerInputField();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!(View == null) && value)
		{
			if (View.inputTriggerInputField || View.isSearching)
			{
				View.UntriggerInputField();
			}
			else
			{
				View.Close();
			}
		}
	}

	private void OnNavigateSelect()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if ((bool)currentSelected && m_CurSelectItem != currentSelected)
		{
			EventSystemHelper.Click(currentSelected);
			m_CurSelectItem = currentSelected;
			if (View != null)
			{
				View.UpdateRightScrollPromptActive();
			}
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		curNavigateState?.Reset();
	}
}
