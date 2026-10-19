using System;
using ACT.Battle;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TeamTeachingViewInputController : BaseUIViewInputController<TeamTeachingView>
{
	private ContinuousNavigateData _navigateData;

	private readonly Action<MoveDirection> _navigateAction;

	public TeamTeachingViewInputController()
	{
		_navigateAction = ExecuteNavigate;
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _navigateData, _navigateAction);
		}
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		View?.NavigateGamePad(direction);
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		HandleReturnInput(value, "UI/Back");
	}

	private void HandleReturnInput(bool value, string inputAction)
	{
		StopActionPropagation(inputAction);
		if (!value)
		{
			TeamTeachingView view = View;
			if ((object)view != null && view.ReturnFromGamePadSubState())
			{
				Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
			}
			else
			{
				View?.OnClose();
			}
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	private void SwitchPageUp(bool value)
	{
		if (!value)
		{
			TeamTeachingView view = View;
			if ((object)view != null && view.IsGamePadListState)
			{
				View.SwitchMainTab(-1);
			}
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	private void SwitchPageDown(bool value)
	{
		if (!value)
		{
			TeamTeachingView view = View;
			if ((object)view != null && view.IsGamePadListState)
			{
				View.SwitchMainTab(1);
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	private void OpenTeamCharacterDetail(bool value)
	{
		if (!value)
		{
			View?.OpenSelectedTeamCharacterDetail();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	private void SelectRewardItem(bool value)
	{
		if (!value)
		{
			View?.FocusRewardItems();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void Confirm(bool value)
	{
		if (!value)
		{
			View?.ConfirmGamePadSelection();
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View?.RestoreGamePadInputState();
	}

	protected override void OnDeactivate()
	{
		_navigateData?.Reset();
		base.OnDeactivate();
	}
}
