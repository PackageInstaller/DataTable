using Config;
using UnityEngine;

public class RangeIndicator : MonoBehaviour
{
	public float RangeIndicatorRadius = 8f;

	public float DamageIndicatorRadius = 2f;

	public GameObject RangeIndicatorEffect;

	public LineRenderer LineRenderer;

	public GameObject DamageIndicatorEffect;

	public GameObject EndEffect;

	public float StartHeight = 1.5f;

	public float EndHeight = 0.2f;

	[SerializeField]
	private Vector3 m_startPos = Vector3.zero;

	private Vector3 m_controlPos;

	[SerializeField]
	private Vector3 m_endPos = Vector3.forward;

	[SerializeField]
	private bool m_isDirty = true;

	public float Height = 5f;

	public int SegmentNum = 26;

	private EffectController m_rootEffectController;

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

	private void LateUpdate()
	{
		if (LineRenderer.positionCount != SegmentNum + 1)
		{
			LineRenderer.positionCount = SegmentNum + 1;
		}
		if (m_isDirty)
		{
			if (RangeIndicatorEffect != null)
			{
				RangeIndicatorEffect.transform.position = StartPoint;
			}
			m_controlPos = ((StartPoint + EndPoint) / 2f).NewY(Height);
			if (DamageIndicatorEffect != null)
			{
				DamageIndicatorEffect.transform.position = EndPoint;
			}
			if (EndEffect != null)
			{
				EndEffect.transform.position = EndPoint;
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
			LineRenderer.SetPosition(i, position);
		}
	}

	private Vector3 CalculateCubicBezierPoint(float t, Vector3 p0, Vector3 p1, Vector3 p2)
	{
		float num = 1f - t;
		float num2 = t * t;
		return num * num * p0 + 2f * num * t * p1 + num2 * p2;
	}

	public void SetRangeIndicatorRadius(float radius)
	{
		RangeIndicatorRadius = radius;
		if (RangeIndicatorEffect != null)
		{
			RangeIndicatorEffect.transform.localScale = new Vector3(radius * 2f, 1f, radius * 2f);
		}
	}

	public void SetDamageIndicatorRadius(float radius)
	{
		DamageIndicatorRadius = radius;
		if (DamageIndicatorEffect != null)
		{
			DamageIndicatorEffect.transform.localScale = new Vector3(radius * 2f, 1f, radius * 2f);
		}
	}

	public Vector3 DrawIndicator(Vector3 from, Vector3 localPosition, float rangeIndicatorRadius = -1f, float damageIndicatorRadius = -1f)
	{
		return DrawIndicatorByLocalPosition(from, localPosition, rangeIndicatorRadius, damageIndicatorRadius);
	}

	public Vector3 DrawIndicatorByLocalPosition(Vector3 from, Vector3 localPosition, float rangeIndicatorRadius = -1f, float damageIndicatorRadius = -1f)
	{
		Vector3 position = (Vector3)IntMath.Transform((Int3)localPosition, (Int3)Camera.main.transform.forward.NewY(0f), (Int3)from);
		return DrawIndicatorByPosition(from, position, rangeIndicatorRadius, damageIndicatorRadius);
	}

	public Vector3 DrawIndicatorByPosition(Vector3 from, Vector3 position, float rangeIndicatorRadius = -1f, float damageIndicatorRadius = -1f)
	{
		StartPoint = from;
		if (rangeIndicatorRadius != -1f)
		{
			SetRangeIndicatorRadius(rangeIndicatorRadius);
		}
		if (damageIndicatorRadius != -1f)
		{
			SetDamageIndicatorRadius(damageIndicatorRadius);
		}
		Vector3 vector = position;
		if ((vector - from).sqrMagnitude > RangeIndicatorRadius * RangeIndicatorRadius)
		{
			vector = from + (vector - from).normalized * RangeIndicatorRadius;
		}
		EndPoint = vector;
		return vector;
	}

	public Vector3 CalcLocalDirection(Vector3 pressPos, Vector3 center, float radius = 50f)
	{
		Vector3 vector = pressPos - center;
		vector.z = 0f;
		float num = vector.magnitude;
		if (num > radius)
		{
			num = radius;
		}
		float num2 = num / radius * RangeIndicatorRadius;
		Vector3 normalized = vector.normalized;
		return new Vector3(normalized.x * num2, 0f, normalized.y * num2);
	}

	public static Vector3 PoisitionConstraint(Vector3 from, Vector3 position, int timelineID)
	{
		public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(timelineID);
		Vector3 vector = position;
		float num = (float)config.Range / 1000f;
		if ((vector - from).sqrMagnitude > num * num)
		{
			vector = from + (vector - from).normalized * num;
		}
		return vector;
	}

	public static Vector3 LocalPositionConstraint(Vector3 from, Vector3 localPosition, int timelineID)
	{
		Vector3 position = (Vector3)IntMath.Transform((Int3)localPosition, (Int3)Camera.main.transform.forward.NewY(0f).normalized, (Int3)from);
		return PoisitionConstraint(from, position, timelineID);
	}

	internal void Play()
	{
		if (m_rootEffectController == null)
		{
			m_rootEffectController = base.gameObject.GetComponent<EffectController>();
		}
		if (m_rootEffectController != null)
		{
			m_rootEffectController.Initialize(isLoop: true, float.MaxValue, 1f, BattleScene.MainPlayerQuality, null);
		}
	}

	internal void Stop()
	{
		if (m_rootEffectController != null)
		{
			m_rootEffectController.Stop();
		}
	}
}
