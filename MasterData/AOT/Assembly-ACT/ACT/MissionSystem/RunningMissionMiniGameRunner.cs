using System;
using ACT.Battle;
using ACT.Event;
using ACT.World.Asset;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

internal sealed class RunningMissionMiniGameRunner : IMissionMiniGameRunner, IDisposable
{
	private readonly int m_ConfigId;

	private readonly Transform m_Parent;

	private readonly Action m_OnSucceeded;

	private readonly Action m_OnFailed;

	private bool m_Active;

	private bool m_Started;

	private bool m_ResultHandled;

	public RunningMissionMiniGameRunner(int configId, Transform parent, Action onSucceeded, Action onFailed)
	{
		m_ConfigId = configId;
		m_Parent = parent;
		m_OnSucceeded = onSucceeded;
		m_OnFailed = onFailed;
	}

	public void Start()
	{
		m_Active = true;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BigWorldChallenge_Result, OnChallengeResult);
		StartWhenReady().Forget();
	}

	public void Dispose()
	{
		m_Active = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BigWorldChallenge_Result, OnChallengeResult);
	}

	private async UniTaskVoid StartWhenReady()
	{
		while (m_Active)
		{
			if (MissionMiniGameConditionUtility.IsCurrentInBattleMain() && Singleton<RunningChallengeManager>.instance.IsInitialized)
			{
				if (Singleton<RunningChallengeManager>.instance.GetConfigById(m_ConfigId) == null)
				{
					Debug.LogError($"Running challenge config is not ready: configId={m_ConfigId}");
					break;
				}
				Singleton<BigWorldChallengeManager>.instance.StartChallenge(ChallengeType.Running, m_ConfigId, m_Parent);
				m_Started = true;
				break;
			}
			await UniTask.Yield();
		}
	}

	private void OnChallengeResult(BaseEventContent eventContent)
	{
		if (m_Active && m_Started && !m_ResultHandled && eventContent is BigWorldChallengeResultEvt { challengeType: ChallengeType.Running } bigWorldChallengeResultEvt && bigWorldChallengeResultEvt.configId == m_ConfigId)
		{
			m_ResultHandled = true;
			if (bigWorldChallengeResultEvt.success)
			{
				m_OnSucceeded?.Invoke();
			}
			else
			{
				NotifyFailureWhenBackToBattleMain().Forget();
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
