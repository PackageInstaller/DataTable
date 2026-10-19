using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Game;
using ACT.Game.Data;
using Cysharp.Threading.Tasks;
using Google.Protobuf;
using Pb;
using UnityEngine;

namespace ACT.MissionSystem;

public sealed class MissionLocalDatabase : IMissionDatabase
{
	private const float ServerVerifyTimeoutSeconds = 10f;

	private bool m_LocalMode;

	private int m_ExplicitTrackingMission;

	private bool m_ExplicitTrackingMissionInitialized;

	private List<MissionState> m_MissionStateList;

	private Dictionary<int, MissionState> m_MissionStateDict;

	private Dictionary<int, MissionData> m_MissionDatas;

	public bool LocalMode => m_LocalMode;

	public IReadOnlyList<MissionState> MissionStateList => m_MissionStateList;

	public int ExplicitTrackingMission => m_ExplicitTrackingMission;

	public MissionLocalDatabase(bool localMode, Dictionary<int, MissionData> missionDatas)
	{
		m_LocalMode = localMode;
		m_MissionDatas = missionDatas;
	}

	public void Init()
	{
		if (m_MissionStateList == null)
		{
			m_MissionStateList = new List<MissionState>();
			m_MissionStateDict = new Dictionary<int, MissionState>();
			{
				foreach (KeyValuePair<int, MissionData> missionData in m_MissionDatas)
				{
					int key = missionData.Key;
					MissionState missionState = CreateMissionState(key);
					if (missionState != null)
					{
						m_MissionStateDict.Add(key, missionState);
						m_MissionStateList.Add(missionState);
					}
				}
				return;
			}
		}
		Reset();
	}

	public void UnInit()
	{
		Reset();
	}

	public void InitExplicitTrackingMission(int missionId)
	{
		if (!m_ExplicitTrackingMissionInitialized)
		{
			m_ExplicitTrackingMissionInitialized = true;
			m_ExplicitTrackingMission = missionId;
		}
	}

	public bool UpdateExplicitTracingMission(int missionId)
	{
		if (m_ExplicitTrackingMission == missionId)
		{
			return false;
		}
		IReadOnlyMissionState readOnlyMissionState = QueryMissionState(missionId);
		if (missionId != 0 && readOnlyMissionState == null)
		{
			return false;
		}
		m_ExplicitTrackingMission = missionId;
		if (!m_LocalMode)
		{
			G.service.UpdateTracingMission(missionId);
		}
		return true;
	}

	private void Reset()
	{
		m_ExplicitTrackingMissionInitialized = false;
		m_ExplicitTrackingMission = 0;
		foreach (MissionState missionState in m_MissionStateList)
		{
			missionState.ResetToNone();
		}
	}

	private MissionState CreateMissionState(int missionId)
	{
		MissionData valueOrDefault = m_MissionDatas.GetValueOrDefault(missionId);
		if (valueOrDefault == null)
		{
			Debug.LogError($"Mission state build failed, invalid mission data: {missionId}");
			return null;
		}
		if (!valueOrDefault.Config.IsValid)
		{
			throw new InvalidOperationException($"Mission state build failed, invalid mission data: {missionId}");
		}
		int num = valueOrDefault.Stages?.Count ?? 0;
		MissionState missionState = new MissionState();
		missionState.MissionId = missionId;
		missionState.StateEnum = ACT.Game.Data.MissionStateEnum.MissionStateWaitAccept;
		missionState.FailureState = CreateStageState(valueOrDefault.Failure);
		missionState.ExtraState = CreateStageState(valueOrDefault.Extra);
		missionState.StageStates = new StageState[num];
		for (int i = 0; i < num; i++)
		{
			StageState stageState = CreateStageState(valueOrDefault.Stages[i]);
			missionState.StageStates[i] = stageState;
		}
		return missionState;
		StageState CreateStageState(MissionStageData stageData)
		{
			if (stageData == null)
			{
				throw new InvalidOperationException($"Mission stage data invalid: missionId={missionId}");
			}
			StageState stageState2 = new StageState(stageData)
			{
				ConditionGroupStates = new ConditionGroupState[stageData.conditionGroups.Length],
				ConditionStates = new ConditionState[stageData.conditions.Count]
			};
			for (int j = 0; j < stageData.conditions.Count; j++)
			{
				MissionConditionData missionConditionData = stageData.conditions[j];
				int id = missionConditionData.Id;
				if (id == 0)
				{
					throw new InvalidOperationException($"Mission stage condition id mismatch: missionId={missionId}");
				}
				ConditionState conditionState = new ConditionState(id, missionConditionData.Type);
				stageState2.ConditionStates[j] = conditionState;
				stageState2.ConditionStateDict[id] = conditionState;
				missionState.ConditionStateDict[id] = conditionState;
			}
			for (int k = 0; k < stageData.conditionGroups.Length; k++)
			{
				MissionConditionGroupData missionConditionGroupData = stageData.conditionGroups[k];
				ConditionGroupState conditionGroupState = new ConditionGroupState(missionConditionGroupData)
				{
					ConditionStates = new ConditionState[missionConditionGroupData.conditions.Length],
					ActionStates = new ActionState[missionConditionGroupData.actions.Length]
				};
				stageState2.ConditionGroupStates[k] = conditionGroupState;
				for (int l = 0; l < missionConditionGroupData.conditions.Length; l++)
				{
					int id2 = missionConditionGroupData.conditions[l].Id;
					if (!missionState.ConditionStateDict.TryGetValue(id2, out var value))
					{
						throw new InvalidOperationException($"Condition id not found in stage mapping: missionId={missionId}, conditionId={id2}");
					}
					conditionGroupState.ConditionStates[l] = value;
					conditionGroupState.ConditionStateDict[id2] = value;
				}
				for (int m = 0; m < missionConditionGroupData.actions.Length; m++)
				{
					MissionActionData missionActionData = missionConditionGroupData.actions[m];
					int id3 = missionActionData.Id;
					ActionState actionState = new ActionState(id3, missionActionData.Type);
					conditionGroupState.ActionStates[m] = actionState;
					conditionGroupState.ActionStateDict[id3] = actionState;
				}
			}
			return stageState2;
		}
	}

	public IReadOnlyMissionState QueryMissionState(int missionId)
	{
		return m_MissionStateDict.GetValueOrDefault(missionId, null);
	}

	public bool WaitingMission(int missionId)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var value))
		{
			return false;
		}
		if (value.IsClientWaiting || value.IsClientAccepting)
		{
			return false;
		}
		value.ResetToWait();
		value.StateEnum = ACT.Game.Data.MissionStateEnum.MissionStateOngoing;
		if (!m_LocalMode)
		{
			G.service.AcceptMission(missionId);
		}
		UpdateStage(missionId, 0, MissionFlowType.Normal);
		UpdateStage(missionId, 0, MissionFlowType.Fail);
		UpdateStage(missionId, 0, MissionFlowType.Extra);
		return true;
	}

	public bool ManualAcceptMission(int missionId)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var value))
		{
			return false;
		}
		if (value.IsClientWaiting || value.IsClientAccepting)
		{
			return false;
		}
		value.ResetToWait();
		value.StateEnum = ACT.Game.Data.MissionStateEnum.MissionStateOngoing;
		if (!m_LocalMode)
		{
			G.service.AcceptMission(missionId);
		}
		UpdateStage(missionId, 0, MissionFlowType.Normal);
		UpdateStage(missionId, 0, MissionFlowType.Fail);
		UpdateStage(missionId, 0, MissionFlowType.Extra);
		return true;
	}

	public bool SuccessMission(int missionId)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var value))
		{
			return false;
		}
		value.FinishCount++;
		value.Version++;
		value.StateEnum = ACT.Game.Data.MissionStateEnum.MissionStateSuccess;
		if (!m_LocalMode)
		{
			G.service.SuccessMission(missionId);
		}
		return true;
	}

	public bool FailureMission(int missionId)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var value))
		{
			return false;
		}
		value.Version++;
		value.StateEnum = ACT.Game.Data.MissionStateEnum.MissionStateFailed;
		MissionData valueOrDefault = m_MissionDatas.GetValueOrDefault(missionId);
		if (valueOrDefault.Config.MissionBase.resetGroupOnFailure)
		{
			int[] missions = valueOrDefault.Config.Group.missions;
			foreach (int key in missions)
			{
				if (m_MissionStateDict.TryGetValue(key, out var value2))
				{
					value2.ResetToNone();
				}
			}
		}
		if (!m_LocalMode)
		{
			G.service.FailureMission(missionId);
		}
		return true;
	}

	public bool GiveUpMission(int missionId)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var value))
		{
			return false;
		}
		value.Version++;
		value.StateEnum = ACT.Game.Data.MissionStateEnum.MissionStateGiveup;
		value.ResetToGiveUp();
		if (!m_LocalMode)
		{
			G.service.GiveUpMission(missionId);
		}
		return true;
	}

	public bool UpdateCondition(int missionId, MissionStageType stageType, int stageIndex, int conditionId, int progress, bool state)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var value))
		{
			return false;
		}
		if (!value.ConditionStateDict.TryGetValue(conditionId, out var value2))
		{
			return false;
		}
		value2.Version++;
		value2.Finished = state;
		value2.Progress = progress;
		if (!m_LocalMode)
		{
			switch (stageType)
			{
			case MissionStageType.Stage:
				G.service.UpdateMissionCondition(missionId, MissionFlowType.Normal, stageIndex, conditionId, progress, state);
				break;
			case MissionStageType.Fail:
				G.service.UpdateMissionCondition(missionId, MissionFlowType.Fail, 0, conditionId, progress, state);
				break;
			case MissionStageType.Extra:
				G.service.UpdateMissionCondition(missionId, MissionFlowType.Extra, 0, conditionId, progress, state);
				break;
			}
		}
		return true;
	}

	public async UniTask<bool> FinishConditionWithServerVerify(int missionId, MissionStageType stageType, int stageIndex, int conditionId, int progress, CancellationToken token)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var value))
		{
			return false;
		}
		if (!value.ConditionStateDict.TryGetValue(conditionId, out var conditionState))
		{
			return false;
		}
		if (!m_LocalMode)
		{
			bool hasResult = false;
			bool result = false;
			float startTime = Time.realtimeSinceStartup;
			switch (stageType)
			{
			case MissionStageType.Stage:
				G.service.UpdateMissionCondition(missionId, MissionFlowType.Normal, stageIndex, conditionId, progress, success: true, (bool _result) =>
				{
					hasResult = true;
					result = _result;
				});
				break;
			case MissionStageType.Fail:
				G.service.UpdateMissionCondition(missionId, MissionFlowType.Fail, 0, conditionId, progress, success: true, (bool _result) =>
				{
					hasResult = true;
					result = _result;
				});
				break;
			case MissionStageType.Extra:
				G.service.UpdateMissionCondition(missionId, MissionFlowType.Extra, 0, conditionId, progress, success: true, (bool _result) =>
				{
					hasResult = true;
					result = _result;
				});
				break;
			}
			while (!hasResult)
			{
				if (token.IsCancellationRequested)
				{
					return false;
				}
				if (Time.realtimeSinceStartup - startTime >= 10f)
				{
					Debug.LogError($"Mission condition server verify timeout. missionId={missionId}, conditionId={conditionId}");
					return false;
				}
				await UniTask.Yield();
			}
			if (result)
			{
				conditionState.Version++;
				conditionState.Finished = true;
				conditionState.Progress = progress;
			}
			return result;
		}
		conditionState.Version++;
		conditionState.Finished = true;
		conditionState.Progress = progress;
		return true;
	}

	public bool FinishAction(int missionId, int stageIndex, MissionStageType targetType, int conditionGroupIndex, int actionId, int actionType)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var value))
		{
			return false;
		}
		MissionFlowType stageType = MissionFlowType.Normal;
		StageState stageState = null;
		switch (targetType)
		{
		case MissionStageType.Fail:
			stageType = MissionFlowType.Fail;
			stageState = value.FailureState;
			break;
		case MissionStageType.Stage:
			stageType = MissionFlowType.Normal;
			stageState = value.StageStates[stageIndex];
			break;
		case MissionStageType.Extra:
			stageType = MissionFlowType.Extra;
			stageState = value.ExtraState;
			break;
		}
		if (!stageState.ConditionGroupStates[conditionGroupIndex].ActionStateDict.TryGetValue(actionId, out var value2))
		{
			return false;
		}
		value2.Finished = true;
		if (!m_LocalMode)
		{
			G.service.UpdateMissionAction(missionId, stageType, stageIndex, conditionGroupIndex, actionId, actionType, success: true);
		}
		return true;
	}

	public async UniTask<bool> FinishServerAction(int missionId, MissionStageType targetType, int stageIndex, int conditionGroupIndex, int actionId, int actionType, CancellationToken token)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var value))
		{
			return false;
		}
		MissionFlowType stageType = MissionFlowType.Normal;
		StageState stageState = null;
		switch (targetType)
		{
		case MissionStageType.Fail:
			stageType = MissionFlowType.Fail;
			stageState = value.FailureState;
			break;
		case MissionStageType.Stage:
			stageType = MissionFlowType.Normal;
			stageState = value.StageStates[stageIndex];
			break;
		case MissionStageType.Extra:
			stageType = MissionFlowType.Extra;
			stageState = value.ExtraState;
			break;
		}
		if (!stageState.ConditionGroupStates[conditionGroupIndex].ActionStateDict.TryGetValue(actionId, out var actionState))
		{
			return false;
		}
		if (!m_LocalMode)
		{
			bool hasResult = false;
			bool result = false;
			G.service.UpdateMissionAction(missionId, stageType, stageIndex, conditionGroupIndex, actionId, actionType, success: true, (bool _result) =>
			{
				hasResult = true;
				result = _result;
			});
			while (!hasResult)
			{
				if (token.IsCancellationRequested)
				{
					return false;
				}
				await UniTask.Yield();
			}
			if (result)
			{
				actionState.Finished = true;
			}
			return result;
		}
		actionState.Finished = true;
		return true;
	}

	public bool UpdateStage(int missionId, int newStageIndex)
	{
		return UpdateStage(missionId, newStageIndex, MissionFlowType.Normal);
	}

	private bool UpdateStage(int missionId, int newStageIndex, MissionFlowType missionFlowType)
	{
		if (!m_MissionStateDict.TryGetValue(missionId, out var missionState))
		{
			return false;
		}
		int version = missionState.Version;
		int nowTimestampSecond = TimeManager.ServerTime.NowTimestampSecond;
		StageState stageState = null;
		switch (missionFlowType)
		{
		case MissionFlowType.Normal:
			stageState = missionState.StageStates[newStageIndex];
			missionState.CurrentStage = newStageIndex;
			break;
		case MissionFlowType.Fail:
			stageState = missionState.FailureState;
			break;
		case MissionFlowType.Extra:
			stageState = missionState.ExtraState;
			break;
		}
		ConditionState[] conditionStates = stageState.ConditionStates;
		for (int i = 0; i < conditionStates.Length; i++)
		{
			conditionStates[i].StartTs = nowTimestampSecond;
		}
		if (!m_LocalMode)
		{
			G.service.UpdateMissionStage(missionId, missionFlowType, newStageIndex, (IMessage message) =>
			{
				if (message is MissionRUpdateFlowAck { Flow: not null } missionRUpdateFlowAck && missionState.Version == version)
				{
					for (int j = 0; j < missionRUpdateFlowAck.Flow.ConditionActionPairs.Count; j++)
					{
						TriggerConditionActionPair triggerConditionActionPair = missionRUpdateFlowAck.Flow.ConditionActionPairs[j];
						ConditionGroupState conditionGroupState = stageState.ConditionGroupStates[j];
						for (int k = 0; k < triggerConditionActionPair.Conditions.Count; k++)
						{
							conditionGroupState.ConditionStates[k].StartTs = triggerConditionActionPair.Conditions[k].StartTs;
						}
					}
				}
			});
		}
		return true;
	}
}
