using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TempleBuffSelectInputController : BaseUIViewInputController<TempleBuffSelectView>
{
	private ContinuousNavigateData _curNavigateState;

	protected override void OnActivate()
	{
		RefreshSelection();
	}

	private void RefreshSelection()
	{
		ACT.ViewControl.SelectableEx curBuffCellSelectable = View.GetCurBuffCellSelectable();
		if (curBuffCellSelectable != null)
		{
			View.layer?.SetDefaultSelect(curBuffCellSelectable);
		}
		View.layer?.Focus();
	}

	protected override void OnDeactivate()
	{
		_curNavigateState?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (type == DeviceInputMode.Gamepad)
		{
			RefreshSelection();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			View.confirmBtn.OnClick?.Invoke();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			if (!EventSystemHelper.CurrentSelected || View.layer.LastSelect == null)
			{
				RefreshSelection();
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Left:
			View?.viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			View?.viewControlRoot?.SelectRight();
			break;
		}
		OnNavigateSelect();
	}

	private void OnNavigateSelect()
	{
		GameObject gameObject = View.layer.LastSelect.gameObject;
		if ((bool)gameObject)
		{
			EventSystemHelper.Click(gameObject);
		}
	}

	protected override void OnBackPressed(bool isPress)
	{
	}
}
