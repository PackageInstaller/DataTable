using UnityEngine;

namespace Cinemachine.Utility;

public class PositionPredictor
{
	private Vector3 m_Velocity;

	private Vector3 m_SmoothDampVelocity;

	private Vector3 m_Pos;

	private bool m_HavePos;

	public float Smoothing;

	public bool IsEmpty()
	{
		return !m_HavePos;
	}

	public void ApplyTransformDelta(Vector3 positionDelta)
	{
		m_Pos += positionDelta;
	}

	public void Reset()
	{
		m_HavePos = false;
		m_SmoothDampVelocity = Vector3.zero;
		m_Velocity = Vector3.zero;
	}

	public void AddPosition(Vector3 pos, float deltaTime, float lookaheadTime)
	{
		if (deltaTime < 0f)
		{
			Reset();
		}
		if (m_HavePos && deltaTime > 0.0001f)
		{
			Vector3 target = (pos - m_Pos) / deltaTime;
			bool flag = target.sqrMagnitude < m_Velocity.sqrMagnitude;
			m_Velocity = Vector3.SmoothDamp(m_Velocity, target, ref m_SmoothDampVelocity, Smoothing / (float)(flag ? 30 : 10), float.PositiveInfinity, deltaTime);
		}
		m_Pos = pos;
		m_HavePos = true;
	}

	public Vector3 PredictPositionDelta(float lookaheadTime)
	{
		return m_Velocity * lookaheadTime;
	}

	public Vector3 PredictPosition(float lookaheadTime)
	{
		return m_Pos + PredictPositionDelta(lookaheadTime);
	}
}
