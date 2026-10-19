using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopupItemCraftViewInputController : BaseUIViewInputController<MonoPopupItemCraftView>
{
	private const float TriggerLongPressHoldDelay = 0.3f;

	private const float TriggerLongPressRepeatInterval = 0.15f;

	private ViewControlRoot m_ViewControlRoot;

	private ContinuousNavigateData _curNavigateData;

	private bool _ltPressed;

	private bool _rtPressed;

	protected override void OnInitView(MonoPopupItemCraftView view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateData?.Reset();
		View.gridControlLayer?.ReFocus();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
		_ltPressed = false;
		_rtPressed = false;
	}

	protected override void OnBackPressed(bool value)
	{
		if (value)
		{
			return;
		}
		if (MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse)
		{
			base.OnBackPressed(value: false);
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if ((object)currentSelected == null || !currentSelected.transform.IsChildOf(View.ScrollRect.transform))
		{
			View.rightControlLayer.UnFocus();
			View.gridControlLayer.ReFocus();
		}
		else
		{
			base.OnBackPressed(value: false);
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void LeftTrigger(bool value)
	{
		if (_ltPressed != value)
		{
			_ltPressed = value;
			if (value)
			{
				View.ClickMinusBtn();
				Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/LeftTrigger", View.ClickMinusBtn, 0.3f, -1, 0.15f);
			}
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void RightTrigger(bool value)
	{
		if (_rtPressed != value)
		{
			_rtPressed = value;
			if (value)
			{
				View.ClickAddBtn();
				Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/RightTrigger", View.ClickAddBtn, 0.3f, -1, 0.15f);
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void Upgrade(bool value)
	{
		if (value && View.confirmBtn.interactable)
		{
			View.Craft();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			if (currentSelected.transform.IsChildOf(View.ScrollRect.transform))
			{
				View.rightControlLayer.Focus();
				View.FocusBtnOpenDetail();
			}
			else
			{
				EventSystemHelper.Click(currentSelected);
				currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
			}
		}
	}

	[GameInputBindingBool("UI/ShowCoinDetail")]
	public void ShowCostCoinDetail(bool value)
	{
		if (value)
		{
			ShowCostCoinDetail();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			m_ViewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			m_ViewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			m_ViewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			m_ViewControlRoot?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null) && currentSelected.transform.IsChildOf(View.ScrollRect.transform))
		{
			EventSystemHelper.Click(currentSelected);
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
		}
	}

	public void ShowCostCoinDetail()
	{
		if ((bool)View.topCoinComponent)
		{
			EventSystemHelper.ClickPointer(View.topCoinComponent);
		}
	}
}
