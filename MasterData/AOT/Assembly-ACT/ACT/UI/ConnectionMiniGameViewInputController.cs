using System.Collections.Generic;
using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ConnectionMiniGameViewInputController : BaseUIViewInputController<ConnectionMiniGameView>
{
	private ContinuousNavigateData _continuousNavigateData;

	private readonly List<ACT.ViewControl.SelectableEx> _selectableListeners = new List<ACT.ViewControl.SelectableEx>();

	private int _currentConfirmTipKey = -1;

	private int selectIndex => View.separateSegment.CurrentSelect;

	private ViewControlLayer _viewControlLayer => View.viewControlLayer;

	private ViewControlRoot _viewControlRoot => View.viewControlRoot;

	protected override void OnActivate()
	{
		base.OnActivate();
		SubscribeSelectChanged();
		View.separateSegment.OnCurrentSelectChanged -= RefreshGamePadTips;
		View.separateSegment.OnCurrentSelectChanged += RefreshGamePadTips;
		ApplyInputMode(MonoECS.instance.InputMode);
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		ApplyInputMode(type);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_continuousNavigateData?.Reset();
		View.separateSegment.OnCurrentSelectChanged -= RefreshGamePadTips;
		UnsubscribeSelectChanged();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			View.separateSegment.SelectCurrent();
			RefreshGamePadTips();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (selectIndex >= 0)
			{
				View.separateSegment.UnSelected();
				RefreshGamePadTips();
			}
			else
			{
				View.Fail();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			if (_viewControlLayer != null && !_viewControlLayer.IsFocused)
			{
				FocusLayer();
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _continuousNavigateData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection obj)
	{
		switch (obj)
		{
		case MoveDirection.Up:
			_viewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			_viewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			_viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			_viewControlRoot?.SelectRight();
			break;
		}
		RefreshGamePadTips();
	}

	private void FocusLayer()
	{
		if (!(_viewControlLayer == null))
		{
			if (_viewControlLayer.IsFocused)
			{
				_viewControlLayer.ReFocus();
			}
			else
			{
				_viewControlLayer.Focus();
			}
		}
	}

	private void DeFocusLayer()
	{
		View.separateSegment.UnSelected();
		_continuousNavigateData?.Reset();
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null && currentSelected.GetComponentInParent<ViewControlLayer>() == _viewControlLayer)
		{
			EventSystemHelper.SetSelectedGameObject(null);
		}
		_viewControlLayer?.UnFocus();
	}

	private void ApplyInputMode(DeviceInputMode type)
	{
		if (type == DeviceInputMode.Gamepad)
		{
			FocusLayer();
			RefreshGamePadTips(force: true);
		}
		else
		{
			DeFocusLayer();
			UpdateGamePadTips(visible: false);
		}
	}

	private void RefreshGamePadTips()
	{
		RefreshGamePadTips(force: false);
	}

	private void RefreshGamePadTips(bool force)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			UpdateGamePadTips(visible: true, force);
		}
	}

	private void UpdateGamePadTips(bool visible)
	{
		UpdateGamePadTips(visible, force: false);
	}

	private void UpdateGamePadTips(bool visible, bool force)
	{
		GamePadTipsComp gamePadTipsComp = (View.gamePadTipsComp ? View.gamePadTipsComp : View.GetComponentInChildren<GamePadTipsComp>(includeInactive: true));
		if (gamePadTipsComp == null)
		{
			return;
		}
		View.gamePadTipsComp = gamePadTipsComp;
		if (visible)
		{
			GamePadTipsAction confirmGamePadTipsAction = GetConfirmGamePadTipsAction();
			if (force || _currentConfirmTipKey != confirmGamePadTipsAction.localizeKey)
			{
				_currentConfirmTipKey = confirmGamePadTipsAction.localizeKey;
				gamePadTipsComp.RegisterInputActions(confirmGamePadTipsAction, GamePadTipHelper.BackAction);
			}
		}
		else
		{
			_currentConfirmTipKey = -1;
			gamePadTipsComp.ClearAllPrompts();
		}
	}

	private GamePadTipsAction GetConfirmGamePadTipsAction()
	{
		GamePadTipsAction confirmAction = GamePadTipHelper.ConfirmAction;
		confirmAction.localizeKey = GetConfirmTipLocalizeKey();
		return confirmAction;
	}

	private int GetConfirmTipLocalizeKey()
	{
		int currentPointIndex = GetCurrentPointIndex();
		if (currentPointIndex < 0 || selectIndex < 0)
		{
			return 774;
		}
		if (currentPointIndex != selectIndex)
		{
			return 51;
		}
		return 41000045;
	}

	private int GetCurrentPointIndex()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		Point point = (currentSelected ? currentSelected.GetComponentInParent<Point>() : null);
		if (!(point != null) || !point.gameObject.activeInHierarchy)
		{
			return -1;
		}
		return point.Index;
	}

	private void SubscribeSelectChanged()
	{
		UnsubscribeSelectChanged();
		if (_viewControlLayer == null)
		{
			return;
		}
		foreach (ACT.ViewControl.SelectableEx selectable in _viewControlLayer.Selectables)
		{
			if (!(selectable == null))
			{
				selectable.OnSelectChanged.AddListener(OnSelectableSelectChanged);
				_selectableListeners.Add(selectable);
			}
		}
	}

	private void UnsubscribeSelectChanged()
	{
		for (int i = 0; i < _selectableListeners.Count; i++)
		{
			if (!(_selectableListeners[i] == null))
			{
				_selectableListeners[i].OnSelectChanged.RemoveListener(OnSelectableSelectChanged);
			}
		}
		_selectableListeners.Clear();
	}

	private void OnSelectableSelectChanged(bool selected)
	{
		RefreshGamePadTips();
	}
}
