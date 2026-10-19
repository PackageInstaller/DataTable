using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public sealed class MissionStage : IMissionStage
{
	private readonly MissionStageData m_Data;

	private readonly MissionCondition[] m_ConditionList;

	private readonly Dictionary<int, MissionCondition> m_ConditionDict;

	private readonly MissionAction[] m_ActionList;

	private readonly Dictionary<int, MissionAction> m_ActionDict;

	private readonly MissionConditionGroup[] m_ConditionGroups;

	private MissionFlow m_Flow;

	private int m_StageIndex;

	private bool m_Active;

	public MissionStageData Data => m_Data;

	public int StageIndex => m_StageIndex;

	public MissionStageType StageType => m_Data.stageType;

	public MissionFlow Flow => m_Flow;

	public bool IsActive => m_Active;

	public int ConditionCount => m_ConditionList.Length;

	public int ActionCount => m_ActionList.Length;

	public int ConditionGroupCount => m_ConditionGroups.Length;

	public MissionStage(MissionStageData data)
	{
		m_Data = data;
		m_ConditionList = new MissionCondition[data.conditions.Count];
		m_ConditionDict = new Dictionary<int, MissionCondition>(data.conditions.Count);
		m_ActionList = new MissionAction[data.actions.Count];
		m_ActionDict = new Dictionary<int, MissionAction>(data.actions.Count);
		m_ConditionGroups = new MissionConditionGroup[data.conditionGroups.Length];
		for (int i = 0; i < data.conditions.Count; i++)
		{
			MissionConditionData missionConditionData = data.conditions[i];
			MissionCondition missionCondition = ConditionDefine.CreateConditionProcessor(missionConditionData);
			m_ConditionList[i] = missionCondition;
			m_ConditionDict[missionConditionData.Id] = missionCondition;
		}
		for (int j = 0; j < data.actions.Count; j++)
		{
			MissionActionData missionActionData = data.actions[j];
			MissionAction missionAction = ActionDefine.CreateActionProcessor(missionActionData);
			m_ActionList[j] = missionAction;
			m_ActionDict[missionActionData.Id] = missionAction;
		}
		for (int k = 0; k < m_ConditionGroups.Length; k++)
		{
			MissionConditionGroupData missionConditionGroupData = m_Data.conditionGroups[k];
			MissionConditionGroup missionConditionGroup = (m_ConditionGroups[k] = new MissionConditionGroup(k, missionConditionGroupData));
			missionConditionGroup.Conditions = new MissionCondition[missionConditionGroupData.conditions.Length];
			missionConditionGroup.Actions = new MissionAction[missionConditionGroupData.actions.Length];
			for (int l = 0; l < missionConditionGroupData.conditions.Length; l++)
			{
				MissionConditionData missionConditionData2 = missionConditionGroupData.conditions[l];
				missionConditionGroup.Conditions[l] = m_ConditionDict.GetValueOrDefault(missionConditionData2.Id);
			}
			for (int m = 0; m < missionConditionGroupData.actions.Length; m++)
			{
				MissionActionData missionActionData2 = missionConditionGroupData.actions[m];
				missionConditionGroup.Actions[m] = m_ActionDict.GetValueOrDefault(missionActionData2.Id);
			}
		}
	}

	public void Init(MissionFlow flow, int stageIndex)
	{
		m_Flow = flow;
		m_StageIndex = stageIndex;
		for (int i = 0; i < m_ConditionGroups.Length; i++)
		{
			m_ConditionGroups[i].Init(this);
		}
		for (int j = 0; j < m_ConditionList.Length; j++)
		{
			m_ConditionList[j].SetMissionStage(this);
		}
		for (int k = 0; k < m_ActionList.Length; k++)
		{
			m_ActionList[k].SetMissionStage(this);
		}
		MissionConditionGroup[] conditionGroups = m_ConditionGroups;
		foreach (MissionConditionGroup missionConditionGroup in conditionGroups)
		{
			MissionCondition[] conditions = missionConditionGroup.Conditions;
			for (int m = 0; m < conditions.Length; m++)
			{
				conditions[m].SetConditionGroup(missionConditionGroup);
			}
		}
	}

	public MissionCondition GetConditionByIndex(int index)
	{
		if (index >= m_ConditionList.Length)
		{
			return null;
		}
		return m_ConditionList[index];
	}

	public MissionCondition GetConditionById(int id)
	{
		return m_ConditionDict.GetValueOrDefault(id);
	}

	public MissionAction GetActionByIndex(int index)
	{
		if (index >= m_ActionList.Length)
		{
			return null;
		}
		return m_ActionList[index];
	}

	public MissionAction GetActionById(int id)
	{
		return m_ActionDict.GetValueOrDefault(id);
	}

	public MissionConditionGroup GetConditionGroupByIndex(int index)
	{
		if (index >= m_ConditionGroups.Length)
		{
			return null;
		}
		return m_ConditionGroups[index];
	}

	public void SetActive(bool active)
	{
		if (m_Active != active)
		{
			m_Active = active;
			RefreshConditionActivation();
		}
	}

	public void RefreshConditionActivation()
	{
		IReadOnlyStageState stageState = (m_Active ? GetState() : null);
		MissionConditionGroup[] conditionGroups = m_ConditionGroups;
		foreach (MissionConditionGroup missionConditionGroup in conditionGroups)
		{
			missionConditionGroup.SetActive(m_Active && missionConditionGroup.NeedsConditions(stageState));
		}
		MissionCondition[] conditionList = m_ConditionList;
		foreach (MissionCondition missionCondition in conditionList)
		{
			if (!m_Active)
			{
				missionCondition.SetActive(active: false);
				continue;
			}
			bool isFinished = missionCondition.IsFinished;
			bool active = false;
			for (int j = 0; j < missionCondition.ConditionGroups.Count; j++)
			{
				MissionConditionGroup missionConditionGroup2 = missionCondition.ConditionGroups[j];
				if (missionConditionGroup2.IsActive && (!isFinished || (missionConditionGroup2.IsRepeatGroup && missionCondition.AllowRepeat)))
				{
					active = true;
					break;
				}
			}
			missionCondition.SetActive(active);
		}
	}

	internal bool IsConditionRequired(MissionCondition condition)
	{
		IReadOnlyStageState state = GetState();
		for (int i = 0; i < condition.ConditionGroups.Count; i++)
		{
			if (condition.ConditionGroups[i].NeedsConditions(state))
			{
				return true;
			}
		}
		return false;
	}

	private IReadOnlyStageState GetState()
	{
		IReadOnlyMissionState readOnlyMissionState = Singleton<MissionManager>.instance.MissionDatabase.QueryMissionState(Flow.Id);
		return StageType switch
		{
			MissionStageType.Stage => readOnlyMissionState.StageStates[StageIndex], 
			MissionStageType.Fail => readOnlyMissionState.FailureState, 
			MissionStageType.Extra => readOnlyMissionState.ExtraState, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}

	public void UpdateInBlockedMap()
	{
		for (int i = 0; i < m_ConditionList.Length; i++)
		{
			m_ConditionList[i].SyncInBlockedMap();
		}
	}

	public void UpdateInMissionWorld()
	{
		for (int i = 0; i < m_ConditionList.Length; i++)
		{
			m_ConditionList[i].SyncInMissionWorld();
		}
	}

	public void UpdateTracing()
	{
		for (int i = 0; i < m_ConditionList.Length; i++)
		{
			m_ConditionList[i].SyncTracing();
		}
	}

	public async UniTask ExecuteActions(int conditionGroupIndex, IReadOnlyConditionGroupState conditionGroupState, CancellationToken token)
	{
		await m_ConditionGroups[conditionGroupIndex].ExecuteActions(conditionGroupState, token);
	}

	public ConditionPriority GetPriority()
	{
		if (ConditionCount == 0)
		{
			return ConditionPriority.Normal;
		}
		ConditionPriority conditionPriority = ConditionPriority.Post;
		for (int i = 0; i < ConditionCount; i++)
		{
			MissionCondition conditionByIndex = GetConditionByIndex(i);
			if (conditionByIndex.Priority < conditionPriority)
			{
				conditionPriority = conditionByIndex.Priority;
			}
		}
		return conditionPriority;
	}
}
