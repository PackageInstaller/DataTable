using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class AccomplishmentDetailsViewInputController : BaseUIViewInputController<MonoAccomplishmentDetailsView>
{
	public enum AccomplishmentDetailsViewControllerType
	{
		SecondAchieveGroupList,
		TopAchieveGroup,
		AchieveContentList,
		TopAchieveGroupItem
	}

	private GameObject m_CurSelectItem;

	private bool _ignoreConfirmUntilRelease;

	private bool _ignoreBackUntilRelease;

	public ContinuousNavigateData curNavigateState;

	public AccomplishmentDetailsViewControllerType ControllerType { get; private set; }

	protected override void OnInitView(MonoAccomplishmentDetailsView view)
	{
		base.OnInitView(view);
		m_CurSelectItem = null;
		ControllerType = AccomplishmentDetailsViewControllerType.SecondAchieveGroupList;
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null) && !View.inputTriggerInputField && (View.IsSearching || !(View.inputField != null) || !View.inputField.isFocused) && (ControllerType == AccomplishmentDetailsViewControllerType.SecondAchieveGroupList || (View.viewPortControlLayers != null && !(View.viewPortControlRoot == null))))
		{
			if (ControllerType != AccomplishmentDetailsViewControllerType.SecondAchieveGroupList && !EventSystemHelper.CurrentSelected)
			{
				View.RefreshScrollViewSelection();
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		if (ControllerType == AccomplishmentDetailsViewControllerType.SecondAchieveGroupList && direction == MoveDirection.Right)
		{
			View.ChangeControllerType(AccomplishmentDetailsViewControllerType.AchieveContentList);
		}
		else if (ControllerType == AccomplishmentDetailsViewControllerType.AchieveContentList && direction == MoveDirection.Left)
		{
			View.ChangeControllerType(AccomplishmentDetailsViewControllerType.SecondAchieveGroupList);
		}
		else if ((ControllerType != AccomplishmentDetailsViewControllerType.AchieveContentList || !View.MoveAchievementContentSelection(direction)) && (ControllerType != AccomplishmentDetailsViewControllerType.SecondAchieveGroupList || !View.NavigateSelectedGroup(direction)) && ControllerType != AccomplishmentDetailsViewControllerType.TopAchieveGroup && ControllerType != AccomplishmentDetailsViewControllerType.TopAchieveGroupItem)
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
	public void LbSwitchTab(bool value)
	{
		if (value && !(View == null) && !View.inputTriggerInputField && (View.IsSearching || !(View.inputField != null) || !View.inputField.isFocused))
		{
			View.SelectTab((View.CurrSelectIndex - 1 >= 0) ? (View.CurrSelectIndex - 1) : 0);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void RbSwitchTab(bool value)
	{
		if (value && !(View == null) && !View.inputTriggerInputField && (View.IsSearching || !(View.inputField != null) || !View.inputField.isFocused))
		{
			int activeToggleCount = View.toggleGroup.GetActiveToggleCount();
			View.SelectTab((View.CurrSelectIndex + 1 <= activeToggleCount) ? (View.CurrSelectIndex + 1) : activeToggleCount);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			_ignoreConfirmUntilRelease = false;
		}
		else
		{
			if (View == null || View.inputTriggerInputField || (!View.IsSearching && View.inputField != null && View.inputField.isFocused) || _ignoreConfirmUntilRelease)
			{
				return;
			}
			if (ControllerType == AccomplishmentDetailsViewControllerType.SecondAchieveGroupList)
			{
				_ignoreConfirmUntilRelease = true;
				View.ChangeControllerType(AccomplishmentDetailsViewControllerType.AchieveContentList);
			}
			else if (ControllerType != AccomplishmentDetailsViewControllerType.AchieveContentList || !View.TryClaimSelectedAchievementContentReward())
			{
				GameObject currentSelected = EventSystemHelper.CurrentSelected;
				if (currentSelected != null)
				{
					EventSystemHelper.Click(currentSelected);
				}
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ButtonWest(bool value)
	{
		if (!(View == null) && value && !View.inputTriggerInputField && ControllerType == AccomplishmentDetailsViewControllerType.AchieveContentList && View.HasCurrentTopGroupReward())
		{
			View.ChangeControllerType(AccomplishmentDetailsViewControllerType.TopAchieveGroup);
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void SelectItemCell(bool value)
	{
		if (!(View == null) && value && !View.inputTriggerInputField)
		{
			View.OnSelectItemCell();
		}
	}

	[GameInputBindingBool("UI/TriggerSearchInPutField")]
	public void TriggerInputField(bool value)
	{
		if (!(View == null) && value && ControllerType == AccomplishmentDetailsViewControllerType.SecondAchieveGroupList)
		{
			StopNavigation();
			View.InputTriggerInputField();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			_ignoreBackUntilRelease = false;
		}
		else if (!(View == null) && !_ignoreBackUntilRelease)
		{
			if (View.inputTriggerInputField)
			{
				View.UntriggerInputField();
			}
			else if (ControllerType == AccomplishmentDetailsViewControllerType.TopAchieveGroupItem)
			{
				View.ChangeControllerType(AccomplishmentDetailsViewControllerType.TopAchieveGroup);
			}
			else if (ControllerType == AccomplishmentDetailsViewControllerType.TopAchieveGroup)
			{
				View.ChangeControllerType(AccomplishmentDetailsViewControllerType.AchieveContentList);
			}
			else if (ControllerType == AccomplishmentDetailsViewControllerType.AchieveContentList)
			{
				View.ChangeControllerType(AccomplishmentDetailsViewControllerType.SecondAchieveGroupList);
			}
			else if (View.IsSearching)
			{
				View.ClearSearchByGamepad();
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
			View?.RefreshGamepadCellStates();
		}
	}

	public void ChangeControllerType(AccomplishmentDetailsViewControllerType controllerType)
	{
		ControllerType = controllerType;
		m_CurSelectItem = null;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_ignoreBackUntilRelease = true;
		View?.OnControllerActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		curNavigateState?.Reset();
	}
}
