using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.UI;
using ACT.World.Asset;
using ACT.World.SceneChunks;
using Fundamental;
using Runtime.World.SceneChunks;

namespace ACT.Model;

public class TeamTeachingModel : Model<TeamTeachingModel>, IJumpable
{
	private readonly List<int> _targetConditionIds = new List<int>();

	private readonly List<bool> _targetCompletedStates = new List<bool>();

	private readonly List<bool> _targetFailedStates = new List<bool>();

	private readonly List<ChallengeTargetDefinition> _targetDefinitions = new List<ChallengeTargetDefinition>();

	private bool _isTrackerListenerRegistered;

	private bool _isNonBlueprintChallengeTracking;

	private bool _isSceneCollectionSettlementRequested;

	private bool _isSurviveTimeSettlementRequested;

	private bool _challengeTrackingStartRequested;

	private float _nonBlueprintTimerElapsed;

	private float _challengeStartWorldRuntime;

	private bool _hasChallengeStartWorldRuntime;

	private const int ExcludedSimulateTrainingTabId = 1;

	public TrainingContents CurrentTrainingContent { get; private set; }

	public IReadOnlyList<int> TargetConditionIds => _targetConditionIds;

	public bool RequiresAutomaticSceneTracking
	{
		get
		{
			if (CurrentTrainingContent != null)
			{
				return _targetDefinitions.Count > 0;
			}
			return false;
		}
	}

	public bool HasSceneObjectTrackingTarget
	{
		get
		{
			for (int i = 0; i < _targetDefinitions.Count; i++)
			{
				ChallengeTargetRuleId rulesId = (ChallengeTargetRuleId)_targetDefinitions[i].Rule.rulesId;
				if (rulesId == ChallengeTargetRuleId.CollectAll || rulesId == ChallengeTargetRuleId.DestroyAllDestructibles)
				{
					return true;
				}
			}
			return false;
		}
	}

	public int ActiveMonsterPointCount
	{
		get
		{
			WorldManager worldManager = Singleton<GameManager>.instance?.worldManager;
			if (worldManager == null)
			{
				return 0;
			}
			if (worldManager.ActiveChunk is SceneChunkRuntimeControlBase { Data: not null } sceneChunkRuntimeControlBase)
			{
				int num = CountMonsterPoints(sceneChunkRuntimeControlBase.Data.StateWorldAssetDatas);
				if (sceneChunkRuntimeControlBase is SceneChunkRuntimeControl_BulkMode)
				{
					SceneBlock[] subScenes = sceneChunkRuntimeControlBase.Data.SubScenes;
					if (subScenes != null)
					{
						for (int i = 0; i < subScenes.Length; i++)
						{
							num += CountMonsterPoints(subScenes[i]?.StateWorldAssetDatas);
						}
					}
				}
				else
				{
					num += CountMonsterPoints(sceneChunkRuntimeControlBase.GetConditionAvailableBlock()?.StateWorldAssetDatas);
				}
				if (num > 0)
				{
					return num;
				}
			}
			int num2 = 0;
			foreach (StateWorldAssetData item in worldManager.FetchActiveWorldStateAssetDatas())
			{
				if (item is WorldMonsterPointData { uniqueIndex: >=0 })
				{
					num2++;
				}
			}
			return num2;
		}
	}

	public bool HasActiveMonsterPoint => ActiveMonsterPointCount > 0;

	public int CurLayerTime { get; private set; }

	public int LastChallengeTime { get; private set; } = -1;

	public bool TimerUpdate { get; private set; }

	public System.DateTime StartTime { get; private set; }

	public LuminModelType JumpSourceType { get; }

	public event Action<bool> ActiveTimerAction;

	public event Action UpdateTimerAction;

	public event Action<int, bool> TargetCompletedChanged;

	public event Action<int, bool> TargetFailedChanged;

	private static int CountMonsterPoints(IReadOnlyList<StateWorldAssetData> stateDatas)
	{
		if (stateDatas == null)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < stateDatas.Count; i++)
		{
			if (stateDatas[i] is WorldMonsterPointData { uniqueIndex: >=0 })
			{
				num++;
			}
		}
		return num;
	}

	private bool ShouldDeferBlueprintStartDuringWorldEnter()
	{
		if (Singleton<GameState>.instance != null && Singleton<GameState>.instance.WorldState == WorldState.Enter && CurrentTrainingContent != null && MonoECS.instance != null)
		{
			return MonoECS.instance.sceneStatus == SceneStatus.Raid;
		}
		return false;
	}

	public void SetCurrentTrainingContent(TrainingContents trainingContent)
	{
		_isNonBlueprintChallengeTracking = false;
		_isSceneCollectionSettlementRequested = false;
		_isSurviveTimeSettlementRequested = false;
		_challengeTrackingStartRequested = false;
		_nonBlueprintTimerElapsed = 0f;
		LastChallengeTime = -1;
		_hasChallengeStartWorldRuntime = false;
		CurrentTrainingContent = trainingContent;
		RefreshTargetDefinitions();
		ResetTargetCompletedStates();
		PrepareTargetTracker();
		ResetTime();
	}

	public bool TryPrepareCurrentRaid(int raidId)
	{
		if (raidId <= 0)
		{
			if (CurrentTrainingContent != null)
			{
				return _targetDefinitions.Count > 0;
			}
			return false;
		}
		if (CurrentTrainingContent != null && CurrentTrainingContent.raidID == raidId)
		{
			if (Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.IsTracking && _targetDefinitions.Count > 0)
			{
				return true;
			}
			_isNonBlueprintChallengeTracking = false;
			_isSceneCollectionSettlementRequested = false;
			_isSurviveTimeSettlementRequested = false;
			_nonBlueprintTimerElapsed = 0f;
			LastChallengeTime = -1;
			_hasChallengeStartWorldRuntime = false;
			ResetTime();
			ResetTargetCompletedStates();
			PrepareTargetTracker();
			return _targetDefinitions.Count > 0;
		}
		if (RuntimeConfigs.data?.trainingContentss == null)
		{
			return false;
		}
		foreach (TrainingContents value in RuntimeConfigs.data.trainingContentss.Values)
		{
			if (value.raidID == raidId)
			{
				SetCurrentTrainingContent(value);
				return _targetDefinitions.Count > 0;
			}
		}
		if (CurrentTrainingContent != null)
		{
			ClearCurrentTrainingContent();
		}
		return false;
	}

	public void ClearCurrentTrainingContent()
	{
		_isNonBlueprintChallengeTracking = false;
		_isSceneCollectionSettlementRequested = false;
		_isSurviveTimeSettlementRequested = false;
		_challengeTrackingStartRequested = false;
		_nonBlueprintTimerElapsed = 0f;
		LastChallengeTime = -1;
		_hasChallengeStartWorldRuntime = false;
		CurrentTrainingContent = null;
		ResetTargetCompletedStates();
		_targetConditionIds.Clear();
		_targetDefinitions.Clear();
		if (Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			Model<ChallengeTargetTrackerModel>.Interface.Clear();
		}
		ResetTime();
	}

	public void BeginCurrentChallengeTracking()
	{
		if (!ShouldDeferBlueprintStartDuringWorldEnter())
		{
			_challengeTrackingStartRequested = true;
			TryStartRequestedChallengeTracking();
		}
	}

	public void TryStartPendingChallengeTracking()
	{
		if (_challengeTrackingStartRequested)
		{
			if (_targetDefinitions.Count == 0 && Model<RaidModel>.HasInstance())
			{
				TryPrepareCurrentRaid(Model<RaidModel>.Interface.CurrentRaidId);
			}
			TryStartRequestedChallengeTracking();
		}
	}

	private void TryStartRequestedChallengeTracking()
	{
		if (_challengeTrackingStartRequested && IsTeamTeachingRaid() && Model<ChallengeTargetTrackerModel>.HasInstance() && _targetDefinitions.Count != 0 && Model<ChallengeTargetTrackerModel>.Interface.IsPrepared)
		{
			_challengeTrackingStartRequested = false;
			if (Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
			{
				_isNonBlueprintChallengeTracking = false;
				_nonBlueprintTimerElapsed = 0f;
				ActiveTimer(active: true);
				return;
			}
			ResetTargetCompletedStates();
			_isNonBlueprintChallengeTracking = false;
			_isSceneCollectionSettlementRequested = false;
			_isSurviveTimeSettlementRequested = false;
			_nonBlueprintTimerElapsed = 0f;
			CurLayerTime = 0;
			_challengeStartWorldRuntime = Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
			_hasChallengeStartWorldRuntime = true;
			Model<ChallengeTargetTrackerModel>.Interface.BeginTracking();
		}
	}

	public void BeginNonBlueprintChallengeTracking()
	{
		if (IsTeamTeachingRaid() && Model<ChallengeTargetTrackerModel>.HasInstance() && !Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
		{
			_challengeTrackingStartRequested = false;
			ResetTargetCompletedStates();
			_isNonBlueprintChallengeTracking = false;
			_isSceneCollectionSettlementRequested = false;
			_isSurviveTimeSettlementRequested = false;
			_nonBlueprintTimerElapsed = 0f;
			CurLayerTime = 0;
			_challengeStartWorldRuntime = Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
			_hasChallengeStartWorldRuntime = true;
			Model<ChallengeTargetTrackerModel>.Interface.BeginTracking();
			_isNonBlueprintChallengeTracking = true;
			if (Model<BattleMainModel>.HasInstance())
			{
				Model<BattleMainModel>.Interface.ChangeHudType(HudType.TeamTeaching);
			}
			ActiveTimer(active: true);
		}
	}

	public void UpdateNonBlueprintChallengeTracking()
	{
		TryStartPendingChallengeTracking();
	}

	public void TickChallengeRuntime()
	{
		if (!Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			return;
		}
		if (_isNonBlueprintChallengeTracking)
		{
			_nonBlueprintTimerElapsed += GameManager.timeSystem.GetWorldRuntimeDeltaTime();
			while (_nonBlueprintTimerElapsed >= 1f)
			{
				_nonBlueprintTimerElapsed--;
				UpdateTimer();
			}
		}
		if (Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
		{
			Model<ChallengeTargetTrackerModel>.Interface.EvaluateRuntimeTargets();
		}
	}

	public void MarkCurrentChallengeCompleted()
	{
		if (IsTeamTeachingRaid() && Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			_challengeTrackingStartRequested = false;
			CaptureCurrentChallengeTime();
			Model<ChallengeTargetTrackerModel>.Interface.MarkChallengeCompleted();
			if (_isNonBlueprintChallengeTracking)
			{
				_isNonBlueprintChallengeTracking = false;
				_nonBlueprintTimerElapsed = 0f;
				ActiveTimer(active: false);
			}
		}
	}

	public bool IsTargetCompleted(int targetIndex)
	{
		if (targetIndex >= 0 && targetIndex < _targetCompletedStates.Count)
		{
			return _targetCompletedStates[targetIndex];
		}
		return false;
	}

	public bool IsTargetFailed(int targetIndex)
	{
		if (targetIndex >= 0 && targetIndex < _targetFailedStates.Count)
		{
			return _targetFailedStates[targetIndex];
		}
		return false;
	}

	public void ActiveTimer(bool active)
	{
		if (!active || !ShouldDeferBlueprintStartDuringWorldEnter() || (Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.IsTracking))
		{
			TimerUpdate = active;
			ActiveTimerAction?.Invoke(active);
		}
	}

	public void UpdateTimer()
	{
		if (TimerUpdate)
		{
			CurLayerTime++;
			UpdateTimerAction?.Invoke();
		}
	}

	public void ResetTime()
	{
		ActiveTimer(active: false);
		CurLayerTime = 0;
	}

	public void ResetTimer()
	{
		StartTime = System.DateTime.Now;
	}

	public float GetTimer()
	{
		if (!(StartTime == default(System.DateTime)))
		{
			return (float)(System.DateTime.Now - StartTime).TotalSeconds;
		}
		return 0f;
	}

	public int GetTeamTeachingTotalTime()
	{
		return CurLayerTime;
	}

	public bool TryGetChallengeDurationForSettlement(out float duration)
	{
		duration = 0f;
		if (!IsTeamTeachingRaid() || LastChallengeTime < 0)
		{
			return false;
		}
		duration = LastChallengeTime;
		return true;
	}

	private void CaptureCurrentChallengeTime()
	{
		if (_isNonBlueprintChallengeTracking && _hasChallengeStartWorldRuntime)
		{
			float num = Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime() - _challengeStartWorldRuntime;
			int num2 = ((num > 0f) ? ((int)Math.Floor(num)) : 0);
			if (num2 > CurLayerTime)
			{
				CurLayerTime = num2;
				UpdateTimerAction?.Invoke();
			}
		}
		LastChallengeTime = CurLayerTime;
	}

	private void RefreshTargetDefinitions()
	{
		_targetConditionIds.Clear();
		_targetDefinitions.Clear();
		if (CurrentTrainingContent == null || RuntimeConfigs.data?.raids == null || RuntimeConfigs.data?.ruless == null || !RuntimeConfigs.data.raids.TryGetValue(CurrentTrainingContent.raidID, out var value) || value?.firstReward == null)
		{
			return;
		}
		foreach (ItemKv item in value.firstReward)
		{
			int num = item?.id ?? 0;
			if (num > 0 && RuntimeConfigs.data.ruless.TryGetValue(num, out var value2) && value2 != null)
			{
				_targetConditionIds.Add(num);
				_targetDefinitions.Add(new ChallengeTargetDefinition(num, value2));
			}
		}
	}

	private void PrepareTargetTracker()
	{
		if (Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			EnsureTrackerListener();
			Model<ChallengeTargetTrackerModel>.Interface.Prepare(_targetDefinitions);
		}
	}

	private void EnsureTrackerListener()
	{
		if (!_isTrackerListenerRegistered)
		{
			Model<ChallengeTargetTrackerModel>.Interface.TargetCompletedChanged += OnTrackerTargetCompletedChanged;
			Model<ChallengeTargetTrackerModel>.Interface.TargetFailedChanged += OnTrackerTargetFailedChanged;
			_isTrackerListenerRegistered = true;
		}
	}

	private void RemoveTrackerListener()
	{
		if (_isTrackerListenerRegistered)
		{
			if (Model<ChallengeTargetTrackerModel>.HasInstance())
			{
				Model<ChallengeTargetTrackerModel>.Interface.TargetCompletedChanged -= OnTrackerTargetCompletedChanged;
				Model<ChallengeTargetTrackerModel>.Interface.TargetFailedChanged -= OnTrackerTargetFailedChanged;
			}
			_isTrackerListenerRegistered = false;
		}
	}

	private void OnTrackerTargetCompletedChanged(int targetId, bool completed)
	{
		for (int i = 0; i < _targetConditionIds.Count; i++)
		{
			if (_targetConditionIds[i] == targetId && _targetCompletedStates[i] != completed)
			{
				_targetCompletedStates[i] = completed;
				if (completed && i < _targetFailedStates.Count && _targetFailedStates[i])
				{
					_targetFailedStates[i] = false;
					TargetFailedChanged?.Invoke(i, arg2: false);
				}
				TargetCompletedChanged?.Invoke(i, completed);
				TrySettleSurviveTimeChallenge(i, completed);
				TrySettleSceneCollectionChallenge(i, completed);
				break;
			}
		}
	}

	private void OnTrackerTargetFailedChanged(int targetId, bool failed)
	{
		for (int i = 0; i < _targetConditionIds.Count; i++)
		{
			if (_targetConditionIds[i] == targetId && i < _targetFailedStates.Count && _targetFailedStates[i] != failed)
			{
				_targetFailedStates[i] = failed;
				if (failed && i < _targetCompletedStates.Count && _targetCompletedStates[i])
				{
					_targetCompletedStates[i] = false;
					TargetCompletedChanged?.Invoke(i, arg2: false);
				}
				TargetFailedChanged?.Invoke(i, failed);
				break;
			}
		}
	}

	private void TrySettleSceneCollectionChallenge(int targetIndex, bool completed)
	{
		if (!completed || !_isNonBlueprintChallengeTracking || _isSceneCollectionSettlementRequested || !IsTeamTeachingRaid() || targetIndex < 0 || targetIndex >= _targetDefinitions.Count || !IsSceneAutoSettlementTarget(_targetDefinitions[targetIndex].Rule.rulesId))
		{
			return;
		}
		for (int i = 0; i < _targetDefinitions.Count; i++)
		{
			if (_targetDefinitions[i].Rule.rulesId == 38)
			{
				return;
			}
		}
		_isSceneCollectionSettlementRequested = true;
		Model<RaidModel>.Interface.RaidSettlement();
	}

	private void TrySettleSurviveTimeChallenge(int targetIndex, bool completed)
	{
		if (!completed || _isSurviveTimeSettlementRequested || !IsTeamTeachingRaid() || targetIndex < 0 || targetIndex >= _targetDefinitions.Count || _targetDefinitions[targetIndex].Rule.rulesId != 40)
		{
			return;
		}
		for (int i = 0; i < _targetDefinitions.Count; i++)
		{
			if (_targetDefinitions[i].Rule.rulesId == 38)
			{
				return;
			}
		}
		_isSurviveTimeSettlementRequested = true;
		Model<RaidModel>.Interface.RaidSettlement();
	}

	private static bool IsSceneAutoSettlementTarget(int ruleId)
	{
		if (ruleId != 39)
		{
			return ruleId == 41;
		}
		return true;
	}

	private void ResetTargetCompletedStates()
	{
		for (int i = 0; i < _targetCompletedStates.Count; i++)
		{
			if (_targetCompletedStates[i])
			{
				TargetCompletedChanged?.Invoke(i, arg2: false);
			}
		}
		for (int j = 0; j < _targetFailedStates.Count; j++)
		{
			if (_targetFailedStates[j])
			{
				TargetFailedChanged?.Invoke(j, arg2: false);
			}
		}
		_targetCompletedStates.Clear();
		_targetFailedStates.Clear();
		for (int k = 0; k < _targetConditionIds.Count; k++)
		{
			_targetCompletedStates.Add(item: false);
			_targetFailedStates.Add(item: false);
		}
	}

	protected override void Init()
	{
		_isTrackerListenerRegistered = false;
		CurrentTrainingContent = null;
		_targetConditionIds.Clear();
		_targetCompletedStates.Clear();
		_targetFailedStates.Clear();
		_targetDefinitions.Clear();
		CurLayerTime = 0;
		TimerUpdate = false;
		StartTime = default;
		_isNonBlueprintChallengeTracking = false;
		_isSceneCollectionSettlementRequested = false;
		_isSurviveTimeSettlementRequested = false;
		_challengeTrackingStartRequested = false;
		_nonBlueprintTimerElapsed = 0f;
		_challengeStartWorldRuntime = 0f;
		_hasChallengeStartWorldRuntime = false;
	}

	protected override void UnInit()
	{
		RemoveTrackerListener();
		CurrentTrainingContent = null;
		_targetConditionIds.Clear();
		_targetCompletedStates.Clear();
		_targetFailedStates.Clear();
		_targetDefinitions.Clear();
		CurLayerTime = 0;
		TimerUpdate = false;
		StartTime = default;
		_isNonBlueprintChallengeTracking = false;
		_isSceneCollectionSettlementRequested = false;
		_isSurviveTimeSettlementRequested = false;
		_challengeTrackingStartRequested = false;
		_nonBlueprintTimerElapsed = 0f;
		LastChallengeTime = -1;
		_challengeStartWorldRuntime = 0f;
		_hasChallengeStartWorldRuntime = false;
		ActiveTimerAction = null;
		UpdateTimerAction = null;
		TargetCompletedChanged = null;
		TargetFailedChanged = null;
	}

	public bool IsTeamTeachingRaid()
	{
		if (CurrentTrainingContent != null && Model<RaidModel>.HasInstance())
		{
			return CurrentTrainingContent.raidID == Model<RaidModel>.Interface.CurrentRaidId;
		}
		return false;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Training))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Forbidden,
				Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Training)
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.CanJump
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAMTEACHING, new TeamTeachingViewData
		{
			MainTabId = list[1],
			TrainingContentId = ((list.Count > 2) ? list[2] : 0)
		});
	}

	public (int completed, int unlocked) GetSimulateTrainingProgress()
	{
		int num = 0;
		int num2 = 0;
		Dictionary<int, TrainingContents> dictionary = RuntimeConfigs.data?.trainingContentss;
		if (dictionary == null)
		{
			return (completed: 0, unlocked: 0);
		}
		foreach (TrainingContents value in dictionary.Values)
		{
			if (value != null && value.IdBelong != 1 && IsChallengeUnlocked(value))
			{
				num2++;
				if (IsRaidCompleted(value.raidID))
				{
					num++;
				}
			}
		}
		int num3 = 0;
		IReadOnlyList<CharacterTutorialRaidInfo> characterTutorialRaidInfos = Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfos();
		foreach (CharacterTutorialRaidInfo item in characterTutorialRaidInfos)
		{
			if (Model<CharacterTutorialModel>.Interface.CharacterTutorialIsComplete(item))
			{
				num3++;
			}
		}
		return (completed: num + num3, unlocked: num2 + characterTutorialRaidInfos.Count);
	}

	private static bool IsChallengeUnlocked(TrainingContents data)
	{
		if (data == null || RuntimeConfigs.data?.raids == null || !RuntimeConfigs.data.raids.TryGetValue(data.raidID, out var value))
		{
			return false;
		}
		return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value.unlockCondition);
	}

	private static bool IsRaidCompleted(int raidId)
	{
		if (raidId > 0 && Model<RaidModel>.HasInstance())
		{
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidId);
			if (raidInfo != null)
			{
				return raidInfo.CleanNum > 0;
			}
			return false;
		}
		return false;
	}
}
