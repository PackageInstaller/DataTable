using ACT.Battle;
using ACT.Model;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class BattlePassTaskSubController : TabContentInputController<BattlePassTaskSubPanel>
{
	private ContinuousNavigateData _curNavigateData;

	private BattlePassView BattlePassView => View?.ParentUIView as BattlePassView;

	private bool IsTaskList
	{
		get
		{
			if (BattlePassView != null)
			{
				return BattlePassView.CurSubControllerType == BattlePassViewSubControllerType.Task;
			}
			return false;
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void Navigate(Vector2 value)
	{
		if (!(BattlePassView == null))
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (BattlePassView == null)
		{
			return;
		}
		if (!IsTaskList)
		{
			switch (dir)
			{
			case MoveDirection.Up:
				BattlePassView.NavigateTaskToggleByGamePad(-1);
				break;
			case MoveDirection.Down:
				BattlePassView.NavigateTaskToggleByGamePad(1);
				break;
			case MoveDirection.Left:
				ViewControlRoot?.SelectLeft();
				break;
			case MoveDirection.Right:
				ViewControlRoot?.SelectRight();
				break;
			}
		}
		else
		{
			switch (dir)
			{
			case MoveDirection.Up:
				ViewControlRoot?.SelectUp();
				break;
			case MoveDirection.Down:
				ViewControlRoot?.SelectDown();
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
			if (!IsTaskList)
			{
				BattlePassView.ConfirmTaskToggleByGamePad();
			}
			else
			{
				BattlePassView.ConfirmTaskCellByGamePad();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	private void OnSpecial1(bool value)
	{
		if (value && !(BattlePassView == null) && IsTaskList && (Model<BattlePassModel>.Interface.HasClaimableDailyTask() || Model<BattlePassModel>.Interface.HasClaimableRoundTask()))
		{
			Model<BattlePassModel>.Interface.ClaimTasks(0, 0, null);
		}
	}

	[GameInputBindingBool("UI/Prev")]
	private void HandlePrev(bool pressed)
	{
		if (!pressed && IsTaskList)
		{
			BattlePassView?.ChangeBattlePassSubControllerType(BattlePassViewSubControllerType.TaskToggle);
		}
	}

	[GameInputBindingBool("UI/Next")]
	private void HandleNext(bool pressed)
	{
		if (!pressed && !IsTaskList)
		{
			BattlePassView?.ConfirmTaskToggleByGamePad();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}
}
