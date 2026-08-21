using UnityEngine;

public class AimCurver : MonoBehaviour
{
	public float StartHeight = 1.5f;

	public float EndHeight = 0.2f;

	[SerializeField]
	private Vector3 m_startPos = Vector3.zero;

	private Vector3 m_controlPos;

	[SerializeField]
	private Vector3 m_endPos = Vector3.forward;

	[SerializeField]
	private bool m_isDirty = true;

	public float Height = 7f;

	public int SegmentNum = 26;

	public LineRenderer lineRenderer;

	public GameObject EndEffet;

	public Transform DamageRangeEffect;

	public Vector3 StartPoint
	{
		get
		{
			return m_startPos;
		}
		set
		{
			if (m_startPos != value)
			{
				m_startPos = value;
				m_isDirty = true;
			}
		}
	}

	public Vector3 EndPoint
	{
		get
		{
			return m_endPos;
		}
		set
		{
			if (m_endPos != value)
			{
				m_endPos = value;
				m_isDirty = true;
			}
		}
	}

	private void Start()
	{
		if (!lineRenderer)
		{
			lineRenderer = GetComponent<LineRenderer>();
		}
		lineRenderer.positionCount = SegmentNum + 1;
	}

	private void Update()
	{
		if (lineRenderer.positionCount != SegmentNum + 1)
		{
			lineRenderer.positionCount = SegmentNum + 1;
		}
		if (m_isDirty)
		{
			m_controlPos = ((StartPoint + EndPoint) / 2f).NewY(Height);
			if (EndEffet != null)
			{
				EndEffet.transform.position = EndPoint;
			}
			m_isDirty = false;
		}
		DrawCurve();
	}

	private void DrawCurve()
	{
		for (int i = 0; i <= SegmentNum; i++)
		{
			float t = (float)i / (float)SegmentNum;
			Vector3 position = CalculateCubicBezierPoint(t, StartPoint.NewY(StartHeight), m_controlPos, EndPoint.NewY(EndHeight));
			lineRenderer.SetPosition(i, position);
		}
	}

	private Vector3 CalculateCubicBezierPoint(float t, Vector3 p0, Vector3 p1, Vector3 p2)
	{
		float num = 1f - t;
		float num2 = t * t;
		return num * num * p0 + 2f * num * t * p1 + num2 * p2;
	}

	public void SetRangeScale(Vector3 scale)
	{
		if (DamageRangeEffect != null)
		{
			DamageRangeEffect.localScale = scale;
		}
	}
}
