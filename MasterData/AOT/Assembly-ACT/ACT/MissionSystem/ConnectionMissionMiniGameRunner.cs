using System;
using ACT.Config;
using ACT.Model;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

internal sealed class ConnectionMissionMiniGameRunner : IMissionMiniGameRunner, IDisposable
{
	private readonly SeparateSegmentConfigs.Difficulty m_Difficulty;

	private readonly Action m_OnSucceeded;

	private readonly Action m_OnFailed;

	private bool m_Active;

	private bool m_Started;

	private bool m_ResultHandled;

	public ConnectionMissionMiniGameRunner(SeparateSegmentConfigs.Difficulty difficulty, Action onSucceeded, Action onFailed)
	{
		m_Difficulty = difficulty;
		m_OnSucceeded = onSucceeded;
		m_OnFailed = onFailed;
	}

	public void Start()
	{
		m_Active = true;
		StartWhenReady().Forget();
	}

	public void Dispose()
	{
		m_Active = false;
	}

	private async UniTaskVoid StartWhenReady()
	{
		while (m_Active)
		{
			if (MissionMiniGameConditionUtility.IsCurrentInBattleMain() && Model<SeparateSegmentGameModel>.Interface.IsInitialized)
			{
				SeparateSegmentConfig randomConfigs = Model<SeparateSegmentGameModel>.Interface.GetRandomConfigs(m_Difficulty);
				if (randomConfigs == null)
				{
					Debug.LogError($"Connection mini game config was not found: difficulty={m_Difficulty}");
				}
				else if (!Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CONNECTIONMINIGAME, new ConnectionMiniGameViewData
				{
					callback = OnMiniGameCompleted,
					separateSegmentConfig = randomConfigs
				}).IsValid)
				{
					Debug.LogError($"Failed to open connection mini game UI: difficulty={m_Difficulty}");
				}
				else
				{
					m_Started = true;
				}
				break;
			}
			await UniTask.Yield();
		}
	}

	private void OnMiniGameCompleted(bool failed)
	{
		if (m_Active && m_Started && !m_ResultHandled)
		{
			m_ResultHandled = true;
			if (failed)
			{
				NotifyFailureWhenBackToBattleMain().Forget();
			}
			else
			{
				m_OnSucceeded?.Invoke();
			}
		}
	}

	private async UniTaskVoid NotifyFailureWhenBackToBattleMain()
	{
		while (m_Active && !MissionMiniGameConditionUtility.IsCurrentInBattleMain())
		{
			await UniTask.Yield();
		}
		if (m_Active)
		{
			m_OnFailed?.Invoke();
		}
	}
}
