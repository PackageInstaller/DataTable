using System.Collections.Generic;

namespace ACT.MissionSystem;

public class ConditionGroupState : IReadOnlyConditionGroupState
{
	private readonly MissionConditionGroupData m_ConditionGroup;

	public ConditionState[] ConditionStates;

	public ActionState[] ActionStates;

	public Dictionary<int, ConditionState> ConditionStateDict = new Dictionary<int, ConditionState>();

	public Dictionary<int, ActionState> ActionStateDict = new Dictionary<int, ActionState>();

	IReadOnlyList<IReadOnlyConditionState> IReadOnlyConditionGroupState.ConditionStates => ConditionStates;

	IReadOnlyList<IReadonlyActionState> IReadOnlyConditionGroupState.ActionStates => ActionStates;

	public ConditionGroupState(MissionConditionGroupData conditionGroupData)
	{
		m_ConditionGroup = conditionGroupData;
	}

	public void Reset()
	{
		ActionState[] actionStates = ActionStates;
		for (int i = 0; i < actionStates.Length; i++)
		{
			actionStates[i].Reset();
		}
	}

	public bool IsAchieve()
	{
		return m_ConditionGroup.LogicMode switch
		{
			MissionStageCheckMode.Or => AnyConditionFinished(), 
			MissionStageCheckMode.And => AllConditionsFinished(), 
			_ => false, 
		};
	}

	public bool IsCompleted()
	{
		if (IsAchieve())
		{
			return AllActionsFinished();
		}
		return false;
	}

	public bool AnyConditionFinished()
	{
		if (ConditionStates == null)
		{
			return true;
		}
		if (ConditionStates.Length == 0)
		{
			return true;
		}
		ConditionState[] conditionStates = ConditionStates;
		for (int i = 0; i < conditionStates.Length; i++)
		{
			if (conditionStates[i].Finished)
			{
				return true;
			}
		}
		return false;
	}

	public bool AllConditionsFinished()
	{
		if (ConditionStates == null)
		{
			return true;
		}
		if (ConditionStates.Length == 0)
		{
			return true;
		}
		ConditionState[] conditionStates = ConditionStates;
		for (int i = 0; i < conditionStates.Length; i++)
		{
			if (!conditionStates[i].Finished)
			{
				return false;
			}
		}
		return true;
	}

	public bool AllActionsFinished()
	{
		if (ActionStates == null)
		{
			return true;
		}
		if (ActionStates.Length == 0)
		{
			return true;
		}
		ActionState[] actionStates = ActionStates;
		foreach (ActionState actionState in actionStates)
		{
			if (actionState != null && !actionState.Finished)
			{
				return false;
			}
		}
		return true;
	}

	IReadOnlyConditionState IReadOnlyConditionGroupState.GetConditionState(int conditionId)
	{
		return ConditionStateDict.GetValueOrDefault(conditionId);
	}

	IReadonlyActionState IReadOnlyConditionGroupState.GetActionState(int actionId)
	{
		return ActionStateDict.GetValueOrDefault(actionId);
	}
}
