using UnityEngine;

namespace ACT.Battle;

public class MonoConnectEffect : MonoEffect
{
	public LineRenderer[] lines;

	public float radius;

	private Transform m_EndPoint;

	private Transform m_StartPoint;

	public Transform[] startEffects;

	public Transform[] endEffects;

	public Transform[] startEffectsWithRotate;

	public override void SetToBeRemove()
	{
		base.SetToBeRemove();
		isDone = true;
	}

	public void SetPos(Transform endPos, Transform startPos)
	{
		m_StartPoint = startPos;
		m_EndPoint = endPos;
	}

	private void Update()
	{
		if (!(m_StartPoint == null) && !(m_EndPoint == null))
		{
			LineRenderer[] array = lines;
			foreach (LineRenderer lineRenderer in array)
			{
				lineRenderer.SetPosition(1, lineRenderer.transform.InverseTransformPoint(m_EndPoint.position));
				lineRenderer.SetPosition(0, lineRenderer.transform.InverseTransformPoint(m_StartPoint.position));
				lineRenderer.startWidth = radius;
				lineRenderer.endWidth = radius;
			}
			Transform[] array2 = endEffects;
			for (int i = 0; i < array2.Length; i++)
			{
				array2[i].position = m_EndPoint.position;
			}
			array2 = startEffects;
			for (int i = 0; i < array2.Length; i++)
			{
				array2[i].position = m_StartPoint.position;
			}
			array2 = startEffectsWithRotate;
			foreach (Transform obj in array2)
			{
				obj.position = m_StartPoint.position;
				obj.rotation = Quaternion.LookRotation(m_EndPoint.position - m_StartPoint.position) * Quaternion.Euler(-90f, 180f, 0f);
			}
		}
	}
}
