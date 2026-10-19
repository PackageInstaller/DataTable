using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Bamboo.Chronos;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class BattlePassBuyLevelViewInputController : BaseUIViewInputController<PopUpBattlePassBuyLevelView>
{
	private ViewControlRoot _viewControlRoot;

	private ContinuousNavigateData _curNavigateData;

	private BattlePassBuyLevelViewSubControllerType _subControllerType;

	private Delayer _switchPageHoldDelayer;

	private Looper _switchPageRepeatLooper;

	private int _switchPageRepeatDirection;

	private const int SwitchPageHoldDelayMs = 300;

	private const int SwitchPageRepeatIntervalMs = 150;

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		View.ChangeSubControllerType(_subControllerType);
	}

	protected override void OnInitView(PopUpBattlePassBuyLevelView view)
	{
		base.OnInitView(view);
		_subControllerType = BattlePassBuyLevelViewSubControllerType.Main;
		_viewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
	}

	public void SetBattlePassBuyLevelViewSubControllerType(BattlePassBuyLevelViewSubControllerType type)
	{
		if (_subControllerType != type)
		{
			_subControllerType = type;
			_curNavigateData?.Reset();
			StopSwitchPageRepeat();
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateData?.Reset();
		EnsureViewControlRoot();
		_viewControlRoot?.ReFocus();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value && !(View == null))
		{
			if (_subControllerType == BattlePassBuyLevelViewSubControllerType.Reward)
			{
				View.OpenSelectedRewardItemDetail();
				return;
			}
			if (EventSystemHelper.CurrentSelected != null)
			{
				EventSystemHelper.ClickCurrent();
				return;
			}
			EnsureViewControlRoot();
			_viewControlRoot?.ReFocus();
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void OnSpecial5(bool value)
	{
		if (value && !(View == null) && _subControllerType != BattlePassBuyLevelViewSubControllerType.Reward)
		{
			View.ChangeSubControllerType(BattlePassBuyLevelViewSubControllerType.Reward);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnSpecial2(bool value)
	{
		if (value && !(View == null) && _subControllerType == BattlePassBuyLevelViewSubControllerType.Main)
		{
			View.SetBuyCountToMaxByGamePad();
		}
	}

	[GameInputBindingBool("UI/ShowCoinDetail")]
	public void ShowCoinDetail(bool value)
	{
		if (value && !(View == null) && _subControllerType == BattlePassBuyLevelViewSubControllerType.Main)
		{
			View.OpenSupplementView();
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

	private void HandleSwitchPageInput(bool value, int direction)
	{
		if (!value)
		{
			StopSwitchPageRepeat();
			return;
		}
		if (View == null || _subControllerType != BattlePassBuyLevelViewSubControllerType.Main)
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
			if (View == null || _subControllerType != BattlePassBuyLevelViewSubControllerType.Main)
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
		if (View == null || _subControllerType != BattlePassBuyLevelViewSubControllerType.Main)
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

	private void ExecuteNavigate(MoveDirection dir)
	{
		EnsureViewControlRoot();
		if (_viewControlRoot == null)
		{
			return;
		}
		if (_subControllerType == BattlePassBuyLevelViewSubControllerType.Reward)
		{
			switch (dir)
			{
			case MoveDirection.Left:
				View.SelectRewardByGamePad(-1);
				break;
			case MoveDirection.Right:
				View.SelectRewardByGamePad(1);
				break;
			}
			return;
		}
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

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (_subControllerType == BattlePassBuyLevelViewSubControllerType.Reward)
			{
				View.ChangeSubControllerType(BattlePassBuyLevelViewSubControllerType.Main);
			}
			else
			{
				View.Close();
			}
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
		StopSwitchPageRepeat();
	}

	private void EnsureViewControlRoot()
	{
		if (_viewControlRoot == null)
		{
			_viewControlRoot = View?.GetComponentInChildren<ViewControlRoot>();
		}
	}
}
