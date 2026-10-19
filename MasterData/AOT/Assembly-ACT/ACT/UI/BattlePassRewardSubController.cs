using ACT.Battle;
using ACT.Model;
using ACT.UI.InputController;
using Bamboo.Chronos;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class BattlePassRewardSubController : TabContentInputController<BattlePassRewardSubPanel>
{
	private ContinuousNavigateData _curNavigateData;

	private Delayer _selectHorizontalHoldDelayer;

	private Looper _selectHorizontalRepeatLooper;

	private int _selectHorizontalRepeatDirection;

	private const int SelectHorizontalHoldDelayMs = 300;

	private const int SelectHorizontalRepeatIntervalMs = 150;

	private BattlePassView BattlePassView => View?.ParentUIView as BattlePassView;

	[GameInputBindingVector2("UI/Navigate")]
	private void Navigate(Vector2 value)
	{
		if (!(BattlePassView == null))
		{
			MoveDirection moveDirection = ContinuousNavigateUtility.DetermineMoveDirection(value.x, value.y, GameLoader.meta.deadZoneOnEnter);
			if (moveDirection == MoveDirection.Left || moveDirection == MoveDirection.Right)
			{
				_curNavigateData?.Reset();
				HandleSelectHorizontalInput((moveDirection != MoveDirection.Left) ? 1 : (-1));
			}
			else
			{
				StopSelectHorizontalRepeat();
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
			}
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (!(BattlePassView == null))
		{
			switch (dir)
			{
			case MoveDirection.Up:
				BattlePassView.NavigateSelectedRewardCellByGamePad(-1);
				break;
			case MoveDirection.Down:
				BattlePassView.NavigateSelectedRewardCellByGamePad(1);
				break;
			case MoveDirection.Left:
				ViewControlRoot?.SelectLeft();
				break;
			case MoveDirection.Right:
				ViewControlRoot?.SelectRight();
				break;
			}
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirm(bool value)
	{
		if (value && !(BattlePassView == null))
		{
			if (EventSystemHelper.CurrentSelected != null)
			{
				EventSystemHelper.ClickCurrent();
			}
			else
			{
				ViewControlRoot?.ReFocus();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	private void OnSpecial1(bool value)
	{
		if (value && !(BattlePassView == null) && Model<BattlePassModel>.Interface.HasUnclaimedRewards())
		{
			Model<BattlePassModel>.Interface.ClaimRewards(0, isPremium: true);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	private void OnSpecial2(bool value)
	{
		if (value && !(BattlePassView == null))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEPASSBUYPREMIUM);
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	private void OnSpecial3(bool value)
	{
		if (value && !(BattlePassView == null))
		{
			BattlePassView.JumpToShopByGamePad();
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	private void OnSpecial5(bool value)
	{
		if (value && !(BattlePassView == null) && BattlePassView.GetStageRewardActive())
		{
			BattlePassView.ChangeBattlePassSubControllerType(BattlePassViewSubControllerType.PremiumReward);
		}
	}

	[GameInputBindingBool("UI/Prev")]
	private void HandlePrev(bool value)
	{
		if (!value || BattlePassView == null)
		{
			BattlePassView?.ChangeBattlePassSubControllerType(BattlePassViewSubControllerType.Reward);
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
		StopSelectHorizontalRepeat();
	}

	private void HandleSelectHorizontalInput(int direction)
	{
		if (_selectHorizontalRepeatDirection != direction || (!_selectHorizontalHoldDelayer.IsValid() && !_selectHorizontalRepeatLooper.IsValid()))
		{
			StartSelectHorizontalRepeat(direction);
		}
	}

	private void StartSelectHorizontalRepeat(int direction)
	{
		StopSelectHorizontalRepeat();
		_selectHorizontalRepeatDirection = direction;
		TriggerSelectHorizontal(direction);
		_selectHorizontalHoldDelayer = UpdateTimer.Default.DelayMs(300, () =>
		{
			if (BattlePassView == null || _selectHorizontalRepeatDirection == 0)
			{
				StopSelectHorizontalRepeat();
			}
			else
			{
				_selectHorizontalRepeatLooper = UpdateTimer.Default.LoopMs(150, () =>
				{
					TriggerSelectHorizontal(_selectHorizontalRepeatDirection);
				});
			}
		});
	}

	private void StopSelectHorizontalRepeat()
	{
		if (_selectHorizontalHoldDelayer.IsValid())
		{
			_selectHorizontalHoldDelayer.Cancel();
		}
		if (_selectHorizontalRepeatLooper.IsValid())
		{
			_selectHorizontalRepeatLooper.Cancel();
		}
		_selectHorizontalRepeatDirection = 0;
	}

	private void TriggerSelectHorizontal(int direction)
	{
		if (BattlePassView == null)
		{
			StopSelectHorizontalRepeat();
		}
		else if (direction < 0)
		{
			BattlePassView.SelectRewardRootByGamePad(-1);
		}
		else if (direction > 0)
		{
			BattlePassView.SelectRewardRootByGamePad(1);
		}
	}
}
