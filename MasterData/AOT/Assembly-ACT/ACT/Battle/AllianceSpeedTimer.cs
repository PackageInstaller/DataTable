using UnityEngine;

namespace ACT.Battle;

public class AllianceSpeedTimer
{
	private bool m_Changing;

	private bool m_IsForceChange;

	public float TargetSpeed;

	private float m_TargetSpeed;

	private float m_Duration;

	private float m_Timer;

	private float m_EaseTime;

	public float speed { get; protected set; }

	public bool lastFrameChanged { get; protected set; }

	public bool changing => m_Changing;

	public AllianceSpeedTimer()
	{
		speed = 1f;
		lastFrameChanged = false;
	}

	public void ChangeSpeed(SystemTime.ConfigChangeGlobalSpeed change)
	{
		m_Changing = true;
		m_Timer = 0f;
		TargetSpeed = (m_TargetSpeed = change.speed);
		m_Duration = change.duration;
		m_EaseTime = change.easeTime;
	}

	public void FixedUpdate(float delta)
	{
		lastFrameChanged = false;
		if (m_Changing)
		{
			m_Timer += delta;
			if (m_Timer > m_Duration)
			{
				m_Changing = false;
				lastFrameChanged = true;
				speed = 1f;
			}
			else if (m_Timer < m_EaseTime)
			{
				speed = Mathf.Lerp(1f, m_TargetSpeed, m_Timer / m_EaseTime);
				lastFrameChanged = true;
			}
			else if (m_Timer <= m_Duration - m_EaseTime)
			{
				if (speed != m_TargetSpeed)
				{
					speed = m_TargetSpeed;
					lastFrameChanged = true;
				}
			}
			else
			{
				speed = Mathf.Lerp(m_TargetSpeed, 1f, (m_Timer - m_Duration + m_EaseTime) / m_EaseTime);
				lastFrameChanged = true;
			}
		}
		if (m_IsForceChange)
		{
			lastFrameChanged = true;
			m_IsForceChange = false;
		}
	}

	public void ForceChangeSpeed(float forceSpeed)
	{
		m_Changing = false;
		m_IsForceChange = true;
		speed = forceSpeed;
	}
}
