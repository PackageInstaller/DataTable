using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class RogueSettlementViewInputController : BaseUIViewInputController<RogueSettlementView>
{
	private ContinuousNavigateData m_NavigateData;

	private RogueSettlementControlType m_ControlType;

	public override bool BlockElderHandle => true;

	protected override void OnInitView(RogueSettlementView view)
	{
		base.OnInitView(view);
		ResetControlType();
	}

	public void ResetControlType()
	{
		m_ControlType = RogueSettlementControlType.Action;
		m_NavigateData?.Reset();
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		m_NavigateData?.Reset();
		View.FocusControlLayer(m_ControlType, restoreLastSelection: true);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		m_NavigateData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref m_NavigateData, ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (currentSelected != null)
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void OnSelectReward(bool value)
	{
		if (value && m_ControlType == RogueSettlementControlType.Action && View.HasRewards)
		{
			ChangeControlType(RogueSettlementControlType.Reward, restoreLastSelection: false);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (m_ControlType == RogueSettlementControlType.Reward)
			{
				ChangeControlType(RogueSettlementControlType.Action, restoreLastSelection: true);
			}
			else
			{
				View.OnLeave();
			}
		}
	}

	private void ChangeControlType(RogueSettlementControlType controlType, bool restoreLastSelection)
	{
		m_ControlType = controlType;
		m_NavigateData?.Reset();
		View.FocusControlLayer(controlType, restoreLastSelection);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Up:
			View.ViewControlLayer.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.ViewControlLayer.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.ViewControlLayer.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.ViewControlLayer.Root?.SelectRight();
			break;
		}
	}
}
