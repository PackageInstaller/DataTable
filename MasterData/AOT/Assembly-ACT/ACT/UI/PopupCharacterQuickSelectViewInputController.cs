using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopupCharacterQuickSelectViewInputController : BaseUIViewInputController<PopupCharacterQuickSelectView>
{
	private ViewControlRoot _viewControlRoot;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(PopupCharacterQuickSelectView view)
	{
		base.OnInitView(view);
		_viewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnSelectionNavigate(Vector2 value)
	{
		if (View != null)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value && !(View == null))
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (currentSelected != null)
			{
				EventSystemHelper.Click(currentSelected);
			}
			else
			{
				View.RefreshGamePadFocus();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnSpecial1(bool value)
	{
		if (value && !(View == null))
		{
			View.SaveByGamePad();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.CloseByGamePad();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		RefreshRoot();
		EnsureCurrentFocusLayer();
		switch (dir)
		{
		case MoveDirection.Down:
			_viewControlRoot.SelectDown();
			break;
		case MoveDirection.Up:
			_viewControlRoot.SelectUp();
			break;
		}
		switch (dir)
		{
		case MoveDirection.Left:
			_viewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			_viewControlRoot.SelectRight();
			break;
		}
	}

	private void EnsureCurrentFocusLayer()
	{
		if (!(_viewControlRoot == null) && !(_viewControlRoot.CurrentFocusLayer != null))
		{
			View.GamePadControlLayer.Focus();
		}
	}

	private void RefreshRoot()
	{
		if ((object)_viewControlRoot == null)
		{
			_viewControlRoot = View?.GetComponentInChildren<ViewControlRoot>();
		}
	}
}
