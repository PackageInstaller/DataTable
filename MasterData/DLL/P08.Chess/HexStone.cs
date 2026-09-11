using System;
using UnityEngine;

public class HexStone : MonoBehaviour
{
	public float m_Speed = 5f;

	public float m_Distance = 0.3f;

	[HideInInspector]
	public bool m_IsMoving;

	private Vector3 m_EndPoint;

	private Action m_CallBack;

	private void Start()
	{
	}

	private void Update()
	{
		if (!m_IsMoving)
		{
			return;
		}
		float maxDistanceDelta = m_Speed * Time.deltaTime;
		base.transform.position = Vector3.MoveTowards(base.transform.position, m_EndPoint, maxDistanceDelta);
		if (m_Distance > Vector3.Distance(base.transform.position, m_EndPoint))
		{
			base.transform.position = m_EndPoint;
			m_IsMoving = false;
			if (m_CallBack != null)
			{
				m_CallBack();
			}
		}
	}

	public void StartToMove(Vector3 endpoint, Action callback)
	{
		m_EndPoint = endpoint;
		m_CallBack = callback;
		m_IsMoving = true;
	}

	public bool GetStoneIsMoving()
	{
		return m_IsMoving;
	}
}
