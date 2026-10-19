using System.Collections.Generic;
using ACT.Game.Data;
using UnityEngine;

namespace ACT.MissionSystem;

public class MissionState : IReadOnlyMissionState
{
	public int MissionId;

	public int Version;

	public bool IsInBlockedMapArea;

	public ACT.Game.Data.MissionStateEnum StateEnum;

	public int FinishCount;

	public int CurrentStage;

	public StageState FailureState;

	public StageState ExtraState;

	public StageState[] StageStates;

	public Dictionary<int, ConditionState> ConditionStateDict = new Dictionary<int, ConditionState>();

	public bool IsFinished => StateEnum == ACT.Game.Data.MissionStateEnum.MissionStateSuccess;

	int IReadOnlyMissionState.MissionId => MissionId;

	int IReadOnlyMissionState.Version => Version;

	ACT.Game.Data.MissionStateEnum IReadOnlyMissionState.StateEnum => StateEnum;

	bool IReadOnlyMissionState.IsFinished => IsFinished;

	bool IReadOnlyMissionState.IsInBlockedMapArea => IsInBlockedMapArea;

	int IReadOnlyMissionState.FinishCount => FinishCount;

	int IReadOnlyMissionState.CurrentStage => ValidCurrentStage;

	public bool IsClientWaiting
	{
		get
		{
			if (StateEnum == ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
			{
				return ValidCurrentStage == 0;
			}
			return false;
		}
	}

	public bool IsClientAccepting
	{
		get
		{
			if (StateEnum == ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
			{
				return ValidCurrentStage > 0;
			}
			return false;
		}
	}

	public bool IsServerAccepting => StateEnum == ACT.Game.Data.MissionStateEnum.MissionStateOngoing;

	IReadOnlyStageState IReadOnlyMissionState.FailureState => FailureState;

	IReadOnlyStageState IReadOnlyMissionState.ExtraState => ExtraState;

	IReadOnlyList<IReadOnlyStageState> IReadOnlyMissionState.StageStates => StageStates;

	public int ValidCurrentStage => Mathf.Clamp(CurrentStage, 0, StageStates.Length - 1);

	IReadOnlyConditionState IReadOnlyMissionState.GetConditionState(int conditionId)
	{
		return ConditionStateDict.GetValueOrDefault(conditionId);
	}

	public void ResetToWait()
	{
		CurrentStage = 0;
		StateEnum = ACT.Game.Data.MissionStateEnum.MissionStateWaitAccept;
		FailureState?.Reset();
		ExtraState?.Reset();
		for (int i = 0; i < StageStates.Length; i++)
		{
			StageStates[i].Reset();
		}
	}

	public void ResetToGiveUp()
	{
		CurrentStage = 0;
		StateEnum = ACT.Game.Data.MissionStateEnum.MissionStateGiveup;
		FailureState?.Reset();
		ExtraState?.Reset();
		for (int i = 0; i < StageStates.Length; i++)
		{
			StageStates[i].Reset();
		}
	}

	public void ResetToNone()
	{
		Version = 0;
		CurrentStage = 0;
		FinishCount = 0;
		IsInBlockedMapArea = false;
		StateEnum = ACT.Game.Data.MissionStateEnum.MissionStateWaitAccept;
		FailureState?.Reset();
		ExtraState?.Reset();
		for (int i = 0; i < StageStates.Length; i++)
		{
			StageStates[i].Reset();
		}
	}
}
