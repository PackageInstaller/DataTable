using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class DivineEyeInputController : BaseUIViewInputController<DivineEyeView>
{
	private bool _isFocusRewardList;

	private bool _isFocusDropDown;

	private ViewControlRoot _viewControlRoot;

	private ContinuousNavigateData _curNavigateState;

	public bool isFocusRewardList => _isFocusRewardList;

	public bool isFocusDropDown => _isFocusDropDown;

	protected override void OnActivate()
	{
		if ((object)_viewControlRoot == null)
		{
			_viewControlRoot = View.GetComponentInChildren<ViewControlRoot>();
		}
		View.dropdown.onPostShow.AddListener(RefreshDropDownSelection);
		View.dropdown.onHide.AddListener(CloseDropDownFocus);
	}

	protected override void OnDeactivate()
	{
		_curNavigateState?.Reset();
		UnFocusRewardList();
		CloseDropDownFocus();
		View.dropdown.onPostShow.RemoveListener(RefreshDropDownSelection);
		View.dropdown.onHide.RemoveListener(CloseDropDownFocus);
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (View == null)
		{
			return;
		}
		if (_isFocusRewardList)
		{
			if (View.rewardListLayer == null)
			{
				return;
			}
			if (!EventSystemHelper.CurrentSelected || View.rewardListLayer.LastSelect == null)
			{
				RefreshRewardSelection();
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
		}
		if (_isFocusDropDown)
		{
			if (!EventSystemHelper.CurrentSelected || View.dropDownLayer.LastSelect == null)
			{
				RefreshDropDownSelection();
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection duration)
	{
		switch (duration)
		{
		case MoveDirection.Left:
			_viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			_viewControlRoot?.SelectRight();
			break;
		case MoveDirection.Up:
			_viewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			_viewControlRoot?.SelectDown();
			break;
		}
	}

	[GameInputBindingBool("UI/Start")]
	public void OpenDropDown(bool value)
	{
		if (value && !(View == null) && !(View.dropdown == null) && View.dropdown.IsInteractable() && !_isFocusRewardList && !View.dropdown.IsExpanded)
		{
			EventSystemHelper.Click(View.dropdown);
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void ChangePageLeft(bool value)
	{
		if (value)
		{
			return;
		}
		ActButton leftButton = View.leftButton;
		if ((object)leftButton != null && leftButton.interactable)
		{
			GameObject gameObject = leftButton.gameObject;
			if ((object)gameObject != null && gameObject.activeInHierarchy)
			{
				View.leftButton.OnClick?.Invoke();
			}
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void ChangePageRight(bool value)
	{
		if (value)
		{
			return;
		}
		ActButton rightButton = View.rightButton;
		if ((object)rightButton != null && rightButton.interactable)
		{
			GameObject gameObject = rightButton.gameObject;
			if ((object)gameObject != null && gameObject.activeInHierarchy)
			{
				View.rightButton.OnClick?.Invoke();
			}
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			return;
		}
		if (_isFocusDropDown)
		{
			OnNavigateSelect();
			View.dropdown.Hide();
			return;
		}
		if (_isFocusRewardList)
		{
			OnNavigateSelect();
			return;
		}
		ActButton rewardButton = View.rewardButton;
		if ((object)rewardButton != null && rewardButton.interactable)
		{
			EventSystemHelper.Click(View.rewardButton);
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	public void SelectRewardList(bool value)
	{
		if (!value && !_isFocusDropDown)
		{
			RefreshRewardSelection();
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void OpenSystemDes(bool value)
	{
		if (!value)
		{
			ActButton systemDesButton = View.systemDesButton;
			if ((object)systemDesButton != null && systemDesButton.interactable)
			{
				EventSystemHelper.Click(View.systemDesButton);
			}
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (_isFocusDropDown)
			{
				View.dropdown.Hide();
			}
			else if (_isFocusRewardList)
			{
				UnFocusRewardList();
			}
			else
			{
				base.OnBackPressed(value);
			}
		}
	}

	private void RefreshRewardSelection()
	{
		View.rewardListLayer?.Focus();
		_isFocusRewardList = true;
		View.UpdateBtnPromptActive();
	}

	private void RefreshDropDownSelection()
	{
		if (!(View.dropDownLayer == null))
		{
			Transform transform = FindRuntimeDropDownContent();
			if (!(transform == null))
			{
				View.dropDownLayer.SetTargetTransform(transform);
				View.dropDownLayer.Focus();
				_isFocusDropDown = true;
				View.UpdateBtnPromptActive();
			}
		}
	}

	private Transform FindRuntimeDropDownContent()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if ((bool)currentSelected && currentSelected.GetComponentInParent<ViewControlLayer>() == View.dropDownLayer)
		{
			return currentSelected.transform.parent;
		}
		if (!View.dropDownLayer.LastSelect)
		{
			return null;
		}
		return View.dropDownLayer.LastSelect.transform.parent;
	}

	private void UnFocusRewardList()
	{
		if (View?.rewardListLayer != null)
		{
			View.rewardListLayer.UnFocus();
			_isFocusRewardList = false;
			View.UpdateBtnPromptActive();
		}
	}

	private void CloseDropDownFocus()
	{
		View.dropDownLayer?.UnFocus();
		View.dropDownLayer?.SetTargetTransform(null);
		if (View?.dropdown != null && View.dropdown.IsExpanded)
		{
			View.dropdown.Hide();
		}
		_isFocusDropDown = false;
		View.UpdateBtnPromptActive();
	}

	private void OnNavigateSelect()
	{
		if (EventSystemHelper.Available)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if ((bool)currentSelected)
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}
}
