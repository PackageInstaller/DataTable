using System;
using ACT.Event;
using ACT.UI;
using Bamboo.Chronos;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public sealed class CountdownSignalCondition : MissionCondition
{
	private Delayer m_CountdownDelayer;

	private Looper m_CountdownLooper;

	private float m_TotalDuration;

	private float m_RemainingDuration;

	private bool m_SignalSent;

	protected override void OnActivate()
	{
		CancelCountdown();
		m_SignalSent = false;
		if (!(Param is CountdownSignalConditionParam countdownSignalConditionParam))
		{
			Debug.LogError($"倒计时任务条件参数为空: missionId={Flow.Id}, conditionId={Id}");
			return;
		}
		if (string.IsNullOrEmpty(countdownSignalConditionParam.signal))
		{
			Debug.LogWarning($"倒计时任务条件未配置任务信号: missionId={Flow.Id}, conditionId={Id}");
			return;
		}
		m_TotalDuration = Mathf.Max(0f, countdownSignalConditionParam.duration);
		m_RemainingDuration = m_TotalDuration;
		DispatchTimer(ACT.Event.EventType.start, m_RemainingDuration);
		if (m_TotalDuration <= 0f)
		{
			OnCountdownCompleted();
			return;
		}
		m_CountdownDelayer = FixedUpdateTimer.Default.DelayMs(Mathf.CeilToInt(m_TotalDuration * 1000f), OnCountdownCompleted);
		m_CountdownLooper = FixedUpdateTimer.Default.LoopMs(1000, OnCountdownTick);
	}

	protected override void OnDeactivate()
	{
		bool num = m_CountdownDelayer.IsValid() || m_CountdownLooper.IsValid();
		CancelCountdown();
		if (num)
		{
			DispatchTimer(ACT.Event.EventType.stop, 0f);
		}
		m_SignalSent = false;
		m_TotalDuration = 0f;
		m_RemainingDuration = 0f;
	}

	private void OnCountdownTick()
	{
		if (IsActive && !m_SignalSent && !(m_RemainingDuration <= 0f))
		{
			m_RemainingDuration = Mathf.Max(0f, m_RemainingDuration - 1f);
			DispatchTimer(ACT.Event.EventType.tick, m_RemainingDuration);
		}
	}

	private void OnCountdownCompleted()
	{
		m_CountdownDelayer = default;
		if (IsActive && !m_SignalSent && Param is CountdownSignalConditionParam countdownSignalConditionParam && !string.IsNullOrEmpty(countdownSignalConditionParam.signal))
		{
			CancelCountdownLooper();
			m_RemainingDuration = 0f;
			DispatchTimer(ACT.Event.EventType.stop, m_RemainingDuration);
			m_SignalSent = true;
			Flow.SendSignal(countdownSignalConditionParam.signal);
		}
	}

	private void CancelCountdown()
	{
		if (m_CountdownDelayer.IsValid())
		{
			m_CountdownDelayer.Cancel();
		}
		m_CountdownDelayer = default;
		CancelCountdownLooper();
	}

	private void CancelCountdownLooper()
	{
		if (m_CountdownLooper.IsValid())
		{
			m_CountdownLooper.Cancel();
		}
		m_CountdownLooper = default;
	}

	private void DispatchTimer(ACT.Event.EventType type, float remainingSeconds)
	{
		Countdown.CountdownTimeData evt = Singleton<EventManager>.instance.GetEvt<Countdown.CountdownTimeData>();
		evt._remaining = remainingSeconds;
		switch (type)
		{
		case ACT.Event.EventType.start:
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CountdownStart, evt);
			break;
		case ACT.Event.EventType.tick:
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CountdownUpdate, evt);
			break;
		case ACT.Event.EventType.stop:
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CountdownStop, evt);
			break;
		default:
			throw new ArgumentOutOfRangeException("type", type, null);
		}
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
