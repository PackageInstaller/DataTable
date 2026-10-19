using UnityEngine;

namespace ACT.MissionSystem;

public class PlayMiniGameUntilCompletedCondition : MissionCondition
{
	private IMissionMiniGameRunner m_Runner;

	private bool m_Finished;

	public override bool AllowRepeat => false;

	protected override void OnInMissionWorld()
	{
		m_Finished = false;
		if (!(Param is PlayMiniGameUntilCompletedConditionParam playMiniGameUntilCompletedConditionParam))
		{
			Debug.LogError($"Mission mini game condition parameter is invalid: missionId={Flow.Id}, conditionId={Id}");
			return;
		}
		m_Runner = playMiniGameUntilCompletedConditionParam.miniGameType switch
		{
			MissionMiniGameType.Connection => (IMissionMiniGameRunner)new ConnectionMissionMiniGameRunner(playMiniGameUntilCompletedConditionParam.difficulty, OnMiniGameSucceeded, OnMiniGameFailed), 
			MissionMiniGameType.RunningChallenge => new RunningMissionMiniGameRunner(playMiniGameUntilCompletedConditionParam.miniGameId, Flow.Env.transform, OnMiniGameSucceeded, OnMiniGameFailed), 
			MissionMiniGameType.BattleChallenge => new BattleMissionMiniGameRunner(playMiniGameUntilCompletedConditionParam.miniGameId, Flow.Env.transform, OnMiniGameSucceeded, OnMiniGameFailed), 
			_ => null, 
		};
		if (m_Runner == null)
		{
			Debug.LogError($"Unsupported mission mini game type: {playMiniGameUntilCompletedConditionParam.miniGameType}");
		}
		else
		{
			m_Runner.Start();
		}
	}

	protected override void OnOutMissionWorld()
	{
		m_Runner?.Dispose();
		m_Runner = null;
		m_Finished = false;
	}

	private void OnMiniGameSucceeded()
	{
		if (InMissionWorld && !m_Finished)
		{
			m_Finished = true;
			SendSignalIfNotEmpty((Param as PlayMiniGameUntilCompletedConditionParam)?.successSignal);
			MarkSuccess();
		}
	}

	private void OnMiniGameFailed()
	{
		if (InMissionWorld && !m_Finished)
		{
			SendSignalIfNotEmpty((Param as PlayMiniGameUntilCompletedConditionParam)?.failureSignal);
		}
	}

	private void SendSignalIfNotEmpty(string signal)
	{
		if (!string.IsNullOrEmpty(signal))
		{
			Flow.SendSignal(signal);
		}
	}
}
