using System;
using System.Threading;
using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class AreaConditionHelper : MonoBehaviour
{
	private CancellationTokenSource m_CTS;

	private bool m_InArea;

	public bool InArea => m_InArea;

	private bool CanPlayTimeline => Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.Timeline);

	public event Action OnEnterCallback;

	public event Action OnExitCallback;

	private void Awake()
	{
		m_CTS = new CancellationTokenSource();
	}

	private void OnDestroy()
	{
		m_CTS?.Cancel();
		m_CTS?.Dispose();
		m_CTS = null;
	}

	private async void OnTriggerEnter(Collider collision)
	{
		if (gameObject.activeInHierarchy)
		{
			MonoEntity component = collision.gameObject.GetComponent<MonoEntity>();
			if (component != null && MonoECS.instance.IsMainEntity(component.entity) && MonoECS.instance.PlayerControlType != MonoECS.ControlType.OreCar && (MonoECS.instance.isStartWorld || !(await UniTask.WaitUntil(() => MonoECS.instance.isStartWorld, PlayerLoopTiming.Update, m_CTS.Token).SuppressCancellationThrow())) && !(await WaitForMovementTransitionEnd()))
			{
				m_InArea = true;
				OnEnterCallback?.Invoke();
			}
		}
	}

	private async void OnTriggerExit(Collider collision)
	{
		if (gameObject.activeInHierarchy)
		{
			MonoEntity component = collision.gameObject.GetComponent<MonoEntity>();
			if (component != null && MonoECS.instance.IsMainEntity(component.entity) && MonoECS.instance.PlayerControlType != MonoECS.ControlType.OreCar && (MonoECS.instance.isStartWorld || !(await UniTask.WaitUntil(() => MonoECS.instance.isStartWorld, PlayerLoopTiming.Update, m_CTS.Token).SuppressCancellationThrow())) && !(await WaitForMovementTransitionEnd()))
			{
				m_InArea = false;
				OnExitCallback?.Invoke();
			}
		}
	}

	private async UniTask<bool> WaitForMovementTransitionEnd()
	{
		if (CanPlayTimeline)
		{
			return false;
		}
		return await UniTask.WaitUntil(() => CanPlayTimeline || Singleton<GameState>.instance.WorldState == WorldState.Leave, PlayerLoopTiming.Update, m_CTS.Token).SuppressCancellationThrow() || MonoECS.instance == null || Singleton<GameState>.instance.WorldState == WorldState.Leave;
	}

	public void SetInitInArea(bool b)
	{
		m_InArea = b;
	}
}
