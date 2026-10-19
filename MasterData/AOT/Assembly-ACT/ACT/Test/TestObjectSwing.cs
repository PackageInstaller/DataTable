using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Test;

public class TestObjectSwing : MonoBehaviour
{
	public enum Quality
	{
		Low,
		Medium,
		High
	}

	public enum Type
	{
		Custom,
		Grass,
		Wire
	}

	public bool useLoaclPosition;

	[Tooltip("Custom为自定义")]
	public Type type;

	[Tooltip("固定两点")]
	public bool fixBothEnds;

	[Range(0f, 1f)]
	[Tooltip("弯曲度")]
	public float curvature = 0.5f;

	public Quality quality = Quality.Medium;

	public Vector3 startPos = Vector3.zero;

	public Vector3 endPos = Vector3.zero;

	[Tooltip("摆动次数")]
	public int swingNum = 3;

	[Range(0f, 1f)]
	[Tooltip("柔软度，0是绳子和1是钢筋")]
	public float softness;

	[Range(0.1f, 1f)]
	[Tooltip("递减系数，动能消耗系数")]
	public float loss = 0.8f;

	[Range(0.1f, 5f)]
	[Tooltip("摆动速度")]
	public float swingSpeed = 1f;

	[Range(1f, 60f)]
	[Tooltip("摆动幅度")]
	public int maxSwingAngle = 45;

	[Tooltip("动态更改Collider，物体小的话不要点")]
	public bool dynamicCollider;

	private List<Vector3> m_Positions = ListPool<Vector3>.Get();

	private LineRenderer m_LineRenderer;

	private BoxCollider m_LineCollider;

	private Vector3 m_Offset;

	private Vector3 m_CurPos = Vector3.zero;

	private Vector3 m_FocusPoint;

	private float m_Dis;

	private float m_Spacing;

	private float m_EntitySpeed;

	private Vector3 m_EntityVelocity;

	private bool m_FaceRight;

	private void Start()
	{
		m_LineRenderer = GetComponent<LineRenderer>();
		m_LineCollider = GetComponent<BoxCollider>();
		Init();
	}

	private void Init()
	{
		switch (quality)
		{
		case Quality.Low:
			m_Spacing = 0.5f;
			m_LineRenderer.numCornerVertices = 0;
			break;
		case Quality.Medium:
			m_Spacing = 0.25f;
			m_LineRenderer.numCornerVertices = 1;
			break;
		case Quality.High:
			m_Spacing = 0.1f;
			m_LineRenderer.numCornerVertices = 2;
			break;
		}
		switch (type)
		{
		case Type.Grass:
			maxSwingAngle = 45;
			swingSpeed = 2f;
			loss = 0.5f;
			swingNum = 3;
			softness = 1f;
			break;
		case Type.Wire:
			maxSwingAngle = 30;
			swingSpeed = 0.5f;
			loss = 0.8f;
			swingNum = 15;
			softness = 0.6f;
			break;
		}
		if (useLoaclPosition)
		{
			startPos += transform.position;
			endPos += transform.position;
		}
		m_CurPos = endPos;
		m_Offset = endPos - startPos;
		m_Dis = m_Offset.magnitude;
		m_LineCollider.center = (m_CurPos + startPos) * 0.5f - transform.position;
		if (m_Offset.x == 0f)
		{
			m_LineCollider.size = m_Offset + new Vector3(0.1f, 0f, 0f);
		}
		else
		{
			m_LineCollider.size = m_Offset;
		}
		if (fixBothEnds)
		{
			m_CurPos = (m_FocusPoint = new Vector3(0f, m_Dis * curvature, 0f));
		}
		ReDraw();
	}

	private void ReDraw()
	{
		m_Positions.Clear();
		if (!(m_LineRenderer != null))
		{
			return;
		}
		if (fixBothEnds)
		{
			for (int i = 0; (float)i < m_Dis / m_Spacing; i++)
			{
				float num = m_Spacing * (float)i / m_Dis;
				float num2 = Mathf.Sin(num * MathF.PI);
				Vector3 vector = num * m_Offset - num2 * m_CurPos;
				m_Positions.Add(startPos + vector);
			}
			if (dynamicCollider)
			{
				m_LineCollider.center = (endPos + startPos) * 0.5f - transform.position;
				m_LineCollider.size = CalculateColliderSize(m_Offset, m_CurPos);
			}
		}
		else
		{
			for (int j = 0; (float)j < m_Dis / m_Spacing; j++)
			{
				float num3 = m_Spacing * (float)j / m_Dis;
				Vector3 normalized = ((m_CurPos - endPos) * Mathf.Lerp(num3 * num3, 1f, softness) + m_Offset).normalized;
				m_Positions.Add(startPos + normalized * num3 * m_Dis * num3 * num3);
			}
			if (dynamicCollider)
			{
				m_LineCollider.center = (m_CurPos + startPos) * 0.5f - transform.position;
				m_LineCollider.size = m_CurPos - startPos;
			}
		}
		m_LineRenderer.positionCount = m_Positions.Count;
		m_LineRenderer.SetPositions(m_Positions.ToArray());
	}

	private Vector3 CalculateColliderSize(Vector3 line1, Vector3 line2)
	{
		Vector3 zero = Vector3.zero;
		zero.x = ((Mathf.Abs(line1.x) > Mathf.Abs(line2.x)) ? line1.x : line2.x);
		zero.y = ((Mathf.Abs(line1.y) > Mathf.Abs(line2.y)) ? line1.y : line2.y);
		zero.z = ((Mathf.Abs(line1.z) > Mathf.Abs(line2.z)) ? line1.z : line2.z);
		return zero;
	}

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		CompPhysics compPhysics = component.entity.GetCompPhysics();
		m_EntityVelocity = compPhysics.lastFramePathLocalVelocity;
		m_EntitySpeed = m_EntityVelocity.magnitude;
		if (!compPhysics.IsFlying() && !(m_EntitySpeed < 3f) && component != null)
		{
			m_FaceRight = (compPhysics.faceDirRot * Vector3.forward).x > 0f;
			if (fixBothEnds)
			{
				StopCoroutine("FixTowSideSwing");
				StartCoroutine("FixTowSideSwing");
			}
			else
			{
				StopCoroutine("Swing");
				StartCoroutine("Swing");
			}
		}
	}

	private IEnumerator Swing()
	{
		float time = 0f;
		float rate = 0f;
		float angle = (1f - Vector3.Angle(endPos - startPos, Vector3.up) / 90f) * (float)maxSwingAngle * m_EntitySpeed / 10f;
		float offsetAngle = Vector3.Angle(m_CurPos - startPos, m_Offset);
		if (endPos.x - m_CurPos.x < 0f)
		{
			offsetAngle = 0f - offsetAngle;
		}
		if (!m_FaceRight)
		{
			angle = 0f - angle;
		}
		if (m_Offset.y < 0f)
		{
			offsetAngle = 0f - offsetAngle;
		}
		for (int i = 0; i < swingNum; i++)
		{
			angle = -1f * angle * loss;
			while (rate < 1f)
			{
				float num = Time.deltaTime * GameManager.timeSystem.globalSpeed * swingSpeed;
				time += num;
				rate = Mathf.Lerp(0f, 1f, time);
				float num2 = Mathf.Sin(rate * MathF.PI);
				m_CurPos = startPos + (Quaternion.Euler(0f, 0f, Mathf.Lerp(offsetAngle, angle, num2)) * m_Offset).normalized * m_Dis;
				if (1f - num2 < 0.05f)
				{
					offsetAngle = 0f;
				}
				ReDraw();
				yield return num;
			}
			time = 0f;
			rate = 0f;
		}
	}

	private IEnumerator FixTowSideSwing()
	{
		float time = 0f;
		float rate = 0f;
		float angle = (1f - Vector3.Angle(m_FocusPoint, Vector3.up) / 90f) * (float)maxSwingAngle * m_EntitySpeed / 15f;
		float offsetAngle = Vector3.Angle(m_CurPos, m_FocusPoint);
		if (m_FocusPoint.x - m_CurPos.x < 0f)
		{
			offsetAngle = 0f - offsetAngle;
		}
		if (m_FaceRight)
		{
			angle = 0f - angle;
		}
		for (int i = 0; i < swingNum; i++)
		{
			angle = -1f * angle * loss;
			while (rate < 1f)
			{
				float num = Time.deltaTime * GameManager.timeSystem.globalSpeed * swingSpeed;
				time += num;
				rate = Mathf.Lerp(0f, 1f, time);
				float num2 = Mathf.Sin(rate * MathF.PI);
				m_CurPos = Quaternion.Euler(0f, 0f, Mathf.Lerp(offsetAngle, angle, num2)) * m_FocusPoint;
				if (m_EntityVelocity.y > 4f)
				{
					m_CurPos *= (3f - Mathf.Sin(rate * MathF.PI)) / 3f;
				}
				if (1f - num2 < 0.05f)
				{
					offsetAngle = 0f;
				}
				ReDraw();
				yield return num;
			}
			time = 0f;
			rate = 0f;
		}
	}

	private void OnDestroy()
	{
		ListPool<Vector3>.Release(m_Positions);
	}
}
