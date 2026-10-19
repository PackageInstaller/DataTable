using System;
using System.Collections.Generic;
using ACT.Core;
using Newtonsoft.Json;

namespace ACT.MissionSystem;

public class MissionData
{
	private static Dictionary<int, MissionConditionData> ConditionDictBuffer = new Dictionary<int, MissionConditionData>();

	private static Dictionary<int, MissionActionData> ActionDictBuffer = new Dictionary<int, MissionActionData>();

	private readonly MissionConfig m_Config;

	private readonly string m_EnvAssetKey;

	private MissionStageData m_Failure;

	private MissionStageData m_Extra;

	private MissionStageData[] m_Stages;

	private SerializedMissionData m_SerializedData;

	private List<MissionData> preMissionList = new List<MissionData>();

	private List<MissionData> nextMissionList = new List<MissionData>();

	private HashSet<MissionData> preMissions = new HashSet<MissionData>();

	private HashSet<MissionData> nextMissions = new HashSet<MissionData>();

	private bool m_Initialized;

	private static SerializedMissionStage DefaultEmptyStage = new SerializedMissionStage
	{
		conditionActionPairs = new SerializedMissionConditionGroup[1]
		{
			new SerializedMissionConditionGroup()
		}
	};

	public MissionConfig Config => m_Config;

	public int Id => m_Config.MissionId;

	public string EnvAssetKey => m_EnvAssetKey;

	public MissionStageData Failure
	{
		get
		{
			TryInitialize();
			return m_Failure;
		}
	}

	public MissionStageData Extra
	{
		get
		{
			TryInitialize();
			return m_Extra;
		}
	}

	public IReadOnlyList<MissionStageData> Stages
	{
		get
		{
			TryInitialize();
			return m_Stages;
		}
	}

	public IReadOnlyList<MissionData> PreMissions => preMissionList;

	public IReadOnlyList<MissionData> NextMissions => nextMissionList;

	public MissionData(MissionConfig missionConfig)
	{
		m_Config = missionConfig;
		m_EnvAssetKey = $"Mission_{m_Config.MissionId}";
	}

	public void AddPreMission(MissionData mission)
	{
		if (preMissions.Add(mission))
		{
			preMissionList.Add(mission);
		}
	}

	public void AddNextMission(MissionData mission)
	{
		if (nextMissions.Add(mission))
		{
			nextMissionList.Add(mission);
		}
	}

	private void TryInitialize()
	{
		if (!m_Initialized)
		{
			m_Initialized = true;
			SerializedMissionData serializedMissionData = new SerializedMissionData();
			serializedMissionData.detail = JsonConvert.DeserializeObject<SerializedMissionDetailData>(m_Config.MissionDetail.flow);
			if (serializedMissionData.detail == null)
			{
				throw new InvalidOperationException($"Mission flow deserialize failed, missionId={Id}");
			}
			SerializedMissionDetailData detail = serializedMissionData.detail;
			if (detail.failure == null)
			{
				detail.failure = DefaultEmptyStage;
			}
			detail = serializedMissionData.detail;
			if (detail.extra == null)
			{
				detail.extra = DefaultEmptyStage;
			}
			detail = serializedMissionData.detail;
			if (detail.accept == null)
			{
				detail.accept = DefaultEmptyStage;
			}
			detail = serializedMissionData.detail;
			if (detail.start == null)
			{
				detail.start = DefaultEmptyStage;
			}
			detail = serializedMissionData.detail;
			if (detail.flows == null)
			{
				detail.flows = Array.Empty<SerializedMissionStage>();
			}
			m_Failure = CreateMissionStageData(MissionStageType.Fail, serializedMissionData.detail.failure);
			m_Extra = CreateMissionStageData(MissionStageType.Extra, serializedMissionData.detail.extra);
			m_Stages = new MissionStageData[serializedMissionData.detail.flows.Length + 2];
			m_Stages[0] = CreateMissionStageData(MissionStageType.Stage, serializedMissionData.detail.accept);
			m_Stages[1] = CreateMissionStageData(MissionStageType.Stage, serializedMissionData.detail.start);
			for (int i = 0; i < serializedMissionData.detail.flows.Length; i++)
			{
				SerializedMissionStage serializedStageData = serializedMissionData.detail.flows[i];
				m_Stages[i + 2] = CreateMissionStageData(MissionStageType.Stage, serializedStageData);
			}
		}
	}

	private MissionStageData CreateMissionStageData(MissionStageType stageType, SerializedMissionStage serializedStageData)
	{
		if (serializedStageData == null)
		{
			throw new InvalidOperationException("Serialized mission stage data is null.");
		}
		MissionStageData missionStageData = new MissionStageData(stageType, serializedStageData);
		Dictionary<int, MissionConditionData> conditionDictBuffer = ConditionDictBuffer;
		Dictionary<int, MissionActionData> actionDictBuffer = ActionDictBuffer;
		conditionDictBuffer.Clear();
		actionDictBuffer.Clear();
		for (int i = 0; i < serializedStageData.conditionActionPairs.Length; i++)
		{
			if (i >= 30)
			{
				throw new InvalidOperationException($"Condition group count exceeds supported limit(30), index={i}");
			}
			SerializedMissionConditionGroup serializedMissionConditionGroup = serializedStageData.conditionActionPairs[i];
			MissionConditionGroupData missionConditionGroupData = (missionStageData.conditionGroups[i] = new MissionConditionGroupData(serializedMissionConditionGroup));
			for (int j = 0; j < serializedMissionConditionGroup.conditions.Length; j++)
			{
				int key = serializedMissionConditionGroup.conditions[j];
				if (RuntimeConfigs.data.missionConditions.TryGetValue(key, out var value))
				{
					RuntimeConfigs.data.missionConditionActionEnums.TryGetValue(value.enumID, out var value2);
					if (!conditionDictBuffer.TryGetValue(key, out var value3))
					{
						value3 = (conditionDictBuffer[key] = new MissionConditionData(value2, value));
						missionStageData.conditions.Add(value3);
					}
					value3.Tags |= MissionFlow.BuildGroupBit(i);
					missionConditionGroupData.conditions[j] = value3;
				}
			}
			for (int k = 0; k < serializedMissionConditionGroup.actions.Length; k++)
			{
				int key2 = serializedMissionConditionGroup.actions[k];
				if (RuntimeConfigs.data.missionActions.TryGetValue(key2, out var value4))
				{
					RuntimeConfigs.data.missionConditionActionEnums.TryGetValue(value4.enumID, out var value5);
					if (!actionDictBuffer.TryGetValue(key2, out var value6))
					{
						value6 = (actionDictBuffer[key2] = new MissionActionData(value5, value4));
						missionStageData.actions.Add(value6);
					}
					value6.Tags |= MissionFlow.BuildGroupBit(i);
					missionConditionGroupData.actions[k] = value6;
				}
			}
		}
		conditionDictBuffer.Clear();
		actionDictBuffer.Clear();
		return missionStageData;
	}
}
