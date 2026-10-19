using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Bamboo.Chronos;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopUpWildBossBuyRewardViewInputController : BaseUIViewInputController<PopUpWildBossBuyRewardView>
{
	private ViewControlRoot _viewControlRoot;

	private ViewControlLayer _viewControlLayer;

	private ContinuousNavigateData _curNavigateData;

	private Delayer _switchPageHoldDelayer;

	private Looper _switchPageRepeatLooper;

	private int _switchPageRepeatDirection;

	private const int SwitchPageHoldDelayMs = 300;

	private const int SwitchPageRepeatIntervalMs = 150;

	protected override void OnInitView(PopUpWildBossBuyRewardView view)
	{
		base.OnInitView(view);
		_viewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
		_viewControlLayer = view.GetComponentInChildren<ViewControlLayer>();
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateData?.Reset();
		RefreshDefaultSelect();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshDefaultSelect();
	}

	internal void RefreshDefaultSelect()
	{
		ACT.ViewControl.SelectableEx defaultSelect = (View.IsBuyBtnInteractable ? View.BuyBtnSelectableEx : View.CancelBtnSelectableEx);
		_viewControlLayer.SetDefaultSelect(defaultSelect);
		_viewControlLayer.Focus();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value && !(View == null) && EventSystemHelper.CurrentSelected != null)
		{
			EventSystemHelper.ClickCurrent();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnSpecial2(bool value)
	{
		if (value && !(View == null))
		{
			View.SetBuyCountToMaxByGamePad();
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void OnSwitchPageLeft(bool value)
	{
		HandleSwitchPageInput(value, -1);
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void OnSwitchPageRight(bool value)
	{
		HandleSwitchPageInput(value, 1);
	}

	[GameInputBindingBool("UI/ShowCoinDetail")]
	public void ShowCoinDetail(bool value)
	{
		if (value && !(View == null))
		{
			View.ShowDetailPanelByGamePad();
		}
	}

	private void HandleSwitchPageInput(bool value, int direction)
	{
		if (!value)
		{
			StopSwitchPageRepeat();
			return;
		}
		if (View == null)
		{
			StopSwitchPageRepeat();
			return;
		}
		TriggerSwitchPageInput(direction);
		StartSwitchPageRepeat(direction);
	}

	private void StartSwitchPageRepeat(int direction)
	{
		StopSwitchPageRepeat();
		_switchPageRepeatDirection = direction;
		_switchPageHoldDelayer = UpdateTimer.Default.DelayMs(300, () =>
		{
			if (View == null)
			{
				StopSwitchPageRepeat();
			}
			else
			{
				_switchPageRepeatLooper = UpdateTimer.Default.LoopMs(150, () =>
				{
					TriggerSwitchPageInput(_switchPageRepeatDirection);
				});
			}
		});
	}

	private void StopSwitchPageRepeat()
	{
		if (_switchPageHoldDelayer.IsValid())
		{
			_switchPageHoldDelayer.Cancel();
		}
		if (_switchPageRepeatLooper.IsValid())
		{
			_switchPageRepeatLooper.Cancel();
		}
		_switchPageRepeatDirection = 0;
	}

	private void TriggerSwitchPageInput(int direction)
	{
		if (View == null)
		{
			StopSwitchPageRepeat();
		}
		else if (direction < 0)
		{
			View.ReduceBuyCountByGamePad();
		}
		else if (direction > 0)
		{
			View.AddBuyCountByGamePad();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (!(_viewControlRoot == null))
		{
			switch (dir)
			{
			case MoveDirection.Up:
				_viewControlRoot.SelectUp();
				break;
			case MoveDirection.Down:
				_viewControlRoot.SelectDown();
				break;
			case MoveDirection.Left:
				_viewControlRoot.SelectLeft();
				break;
			case MoveDirection.Right:
				_viewControlRoot.SelectRight();
				break;
			}
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.CloseByGamePad();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
		StopSwitchPageRepeat();
	}
}
