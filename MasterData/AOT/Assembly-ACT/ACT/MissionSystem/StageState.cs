using System.Collections.Generic;

namespace ACT.MissionSystem;

public class StageState : IReadOnlyStageState
{
	private readonly MissionStageData m_MissionStage;

	public ConditionGroupState[] ConditionGroupStates;

	public ConditionState[] ConditionStates;

	public Dictionary<int, ConditionState> ConditionStateDict = new Dictionary<int, ConditionState>();

	IReadOnlyList<IReadOnlyConditionGroupState> IReadOnlyStageState.ConditionGroupStates => ConditionGroupStates;

	IReadOnlyList<IReadOnlyConditionState> IReadOnlyStageState.ConditionStates => ConditionStates;

	IReadOnlyConditionState IReadOnlyStageState.GetConditionState(int conditionId)
	{
		return ConditionStateDict.GetValueOrDefault(conditionId);
	}

	public StageState(MissionStageData stageData)
	{
		m_MissionStage = stageData;
	}

	public void Reset()
	{
		ConditionState[] conditionStates = ConditionStates;
		for (int i = 0; i < conditionStates.Length; i++)
		{
			conditionStates[i].Reset();
		}
		ConditionGroupState[] conditionGroupStates = ConditionGroupStates;
		for (int i = 0; i < conditionGroupStates.Length; i++)
		{
			conditionGroupStates[i]?.Reset();
		}
	}

	public bool IsArchive()
	{
		return m_MissionStage.LogicMode switch
		{
			MissionStageCheckMode.Or => AnyConditionGroupArchive(), 
			MissionStageCheckMode.And => AllConditionGroupsArchive(), 
			_ => false, 
		};
	}

	public bool IsCompleted()
	{
		return m_MissionStage.LogicMode switch
		{
			MissionStageCheckMode.Or => AnyConditionGroupCompleted(), 
			MissionStageCheckMode.And => AllConditionGroupsCompleted(), 
			_ => false, 
		};
	}

	public bool AnyConditionGroupArchive()
	{
		if (ConditionStates == null)
		{
			return true;
		}
		if (ConditionGroupStates.Length == 0)
		{
			return true;
		}
		ConditionGroupState[] conditionGroupStates = ConditionGroupStates;
		for (int i = 0; i < conditionGroupStates.Length; i++)
		{
			if (conditionGroupStates[i].IsAchieve())
			{
				return true;
			}
		}
		return false;
	}

	public bool AllConditionGroupsArchive()
	{
		if (ConditionStates == null)
		{
			return true;
		}
		if (ConditionGroupStates.Length == 0)
		{
			return true;
		}
		ConditionGroupState[] conditionGroupStates = ConditionGroupStates;
		for (int i = 0; i < conditionGroupStates.Length; i++)
		{
			if (!conditionGroupStates[i].IsAchieve())
			{
				return false;
			}
		}
		return true;
	}

	public bool AnyConditionGroupCompleted()
	{
		if (ConditionStates == null)
		{
			return true;
		}
		if (ConditionGroupStates.Length == 0)
		{
			return true;
		}
		ConditionGroupState[] conditionGroupStates = ConditionGroupStates;
		for (int i = 0; i < conditionGroupStates.Length; i++)
		{
			if (conditionGroupStates[i].IsCompleted())
			{
				return true;
			}
		}
		return false;
	}

	public bool AllConditionGroupsCompleted()
	{
		if (ConditionStates == null)
		{
			return true;
		}
		if (ConditionGroupStates.Length == 0)
		{
			return true;
		}
		ConditionGroupState[] conditionGroupStates = ConditionGroupStates;
		for (int i = 0; i < conditionGroupStates.Length; i++)
		{
			if (!conditionGroupStates[i].IsCompleted())
			{
				return false;
			}
		}
		return true;
	}
}
