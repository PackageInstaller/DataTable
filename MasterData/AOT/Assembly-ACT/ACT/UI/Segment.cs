using UnityEngine;

namespace ACT.UI;

public class Segment
{
	private Point m_Start;

	private Point m_End;

	public bool intersectFlag;

	private bool m_Intersect;

	public Vector3 P1 => m_Start.Pos;

	public Vector3 P2 => m_End.Pos;

	public void Init(Point s, Point e, int sortingLayerID = 0)
	{
		m_Start = s;
		m_End = e;
		SetSortingLayer(sortingLayerID);
	}

	public void SetSortingLayer(int sortingLayerID)
	{
		if (m_Start?.lineRenderer != null)
		{
			m_Start.lineRenderer.sortingLayerID = sortingLayerID;
		}
	}

	public bool HavePoint(Point other)
	{
		if (!(other == m_Start))
		{
			return other == m_End;
		}
		return true;
	}

	public void SetIntersectState(bool value)
	{
		m_Intersect = value;
		m_Start.SetSegmentIntersectState(value);
	}

	public void RefreshSegmentPos()
	{
		m_Start.RefreshSegmentPos(m_Start.Pos, m_End.Pos);
	}

	public bool AreSegmentsIntersecting(Segment other, float precision)
	{
		if (other == this)
		{
			return false;
		}
		Vector3 p = P1;
		Vector3 p2 = P2;
		Vector3 p3 = other.P1;
		Vector3 p4 = other.P2;
		float num = Direction(p3, p4, p);
		float num2 = Direction(p3, p4, p2);
		float num3 = Direction(p, p2, p3);
		float num4 = Direction(p, p2, p4);
		if (((num > 0f && num2 < 0f) || (num < 0f && num2 > 0f)) && ((num3 > 0f && num4 < 0f) || (num3 < 0f && num4 > 0f)))
		{
			return true;
		}
		if (Mathf.Abs(num - 0f) <= precision && Mathf.Abs(num2 - 0f) <= precision)
		{
			if (OnSegment(other.P1, other.P2, P1))
			{
				return true;
			}
			if (OnSegment(other.P1, other.P2, P2))
			{
				return true;
			}
		}
		if (Mathf.Abs(num3 - 0f) <= precision && Mathf.Abs(num4 - 0f) <= precision)
		{
			if (OnSegment(P1, P2, other.P1))
			{
				return true;
			}
			if (OnSegment(P1, P2, other.P2))
			{
				return true;
			}
		}
		if (((p == p3 || p == p4) && (p2 == p3 || p2 == p4)) || ((p3 == p || p3 == p2) && (p4 == p || p4 == p2)))
		{
			return true;
		}
		return false;
	}

	public static bool GetIntersection(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4, float precision, out Vector3 intersection)
	{
		intersection = Vector3.zero;
		float num = p2.x - p1.x;
		float num2 = p2.y - p1.y;
		float num3 = p4.x - p3.x;
		float num4 = p4.y - p3.y;
		float num5 = num * num4 - num2 * num3;
		if (Mathf.Abs(num5) < precision)
		{
			return false;
		}
		float num6 = p3.x - p1.x;
		float num7 = p3.y - p1.y;
		float num8 = (num6 * num4 - num7 * num3) / num5;
		float num9 = (num6 * num2 - num7 * num) / num5;
		if (num8 >= 0f + precision && num8 <= 1f - precision && num9 >= 0f + precision && num9 <= 1f - precision)
		{
			intersection = new Vector3(p1.x + num8 * num, p1.y + num8 * num2, (p1.z + p2.z) / 2f);
			return true;
		}
		return false;
	}

	private float CrossProduct(Vector2 v1, Vector2 v2)
	{
		return v1.x * v2.y - v1.y * v2.x;
	}

	private static float Direction(Vector2 p, Vector2 q, Vector2 r)
	{
		return (r.x - p.x) * (q.y - p.y) - (r.y - p.y) * (q.x - p.x);
	}

	private static bool OnSegment(Vector2 p, Vector2 r, Vector2 q)
	{
		if (q == r || q == p)
		{
			return false;
		}
		if (q.x >= Mathf.Min(p.x, r.x) && q.x <= Mathf.Max(p.x, r.x) && q.y >= Mathf.Min(p.y, r.y) && q.y <= Mathf.Max(p.y, r.y))
		{
			return true;
		}
		return false;
	}
}
