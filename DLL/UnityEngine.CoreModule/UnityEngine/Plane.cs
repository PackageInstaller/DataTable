using System;
using System.Globalization;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
public struct Plane : IFormattable
{
	internal const int size = 16;

	private Vector3 m_Normal;

	private float m_Distance;

	public Vector3 normal
	{
		get
		{
			return m_Normal;
		}
		set
		{
			m_Normal = value;
		}
	}

	public float distance
	{
		get
		{
			return m_Distance;
		}
		set
		{
			m_Distance = value;
		}
	}

	public Plane flipped => new Plane(-m_Normal, 0f - m_Distance);

	public Plane(Vector3 inNormal, Vector3 inPoint)
	{
		m_Normal = Vector3.Normalize(inNormal);
		m_Distance = 0f - Vector3.Dot(m_Normal, inPoint);
	}

	public Plane(Vector3 inNormal, float d)
	{
		m_Normal = Vector3.Normalize(inNormal);
		m_Distance = d;
	}

	public Plane(Vector3 a, Vector3 b, Vector3 c)
	{
		m_Normal = Vector3.Normalize(Vector3.Cross(b - a, c - a));
		m_Distance = 0f - Vector3.Dot(m_Normal, a);
	}

	public void SetNormalAndPosition(Vector3 inNormal, Vector3 inPoint)
	{
		m_Normal = Vector3.Normalize(inNormal);
		m_Distance = 0f - Vector3.Dot(inNormal, inPoint);
	}

	public void Set3Points(Vector3 a, Vector3 b, Vector3 c)
	{
		m_Normal = Vector3.Normalize(Vector3.Cross(b - a, c - a));
		m_Distance = 0f - Vector3.Dot(m_Normal, a);
	}

	public void Flip()
	{
		m_Normal = -m_Normal;
		m_Distance = 0f - m_Distance;
	}

	public void Translate(Vector3 translation)
	{
		m_Distance += Vector3.Dot(m_Normal, translation);
	}

	public static Plane Translate(Plane plane, Vector3 translation)
	{
		return new Plane(plane.m_Normal, plane.m_Distance += Vector3.Dot(plane.m_Normal, translation));
	}

	public Vector3 ClosestPointOnPlane(Vector3 point)
	{
		float num = Vector3.Dot(m_Normal, point) + m_Distance;
		return point - m_Normal * num;
	}

	public float GetDistanceToPoint(Vector3 point)
	{
		return Vector3.Dot(m_Normal, point) + m_Distance;
	}

	public bool GetSide(Vector3 point)
	{
		return Vector3.Dot(m_Normal, point) + m_Distance > 0f;
	}

	public bool SameSide(Vector3 inPt0, Vector3 inPt1)
	{
		float distanceToPoint = GetDistanceToPoint(inPt0);
		float distanceToPoint2 = GetDistanceToPoint(inPt1);
		return (distanceToPoint > 0f && distanceToPoint2 > 0f) || (distanceToPoint <= 0f && distanceToPoint2 <= 0f);
	}

	public bool Raycast(Ray ray, out float enter)
	{
		float num = Vector3.Dot(ray.direction, m_Normal);
		float num2 = 0f - Vector3.Dot(ray.origin, m_Normal) - m_Distance;
		if (Mathf.Approximately(num, 0f))
		{
			enter = 0f;
			return false;
		}
		enter = num2 / num;
		return enter > 0f;
	}

	public override string ToString()
	{
		return ToString(null, null);
	}

	public string ToString(string format)
	{
		return ToString(format, null);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (string.IsNullOrEmpty(format))
		{
			format = "F2";
		}
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("(normal:{0}, distance:{1})", new object[2]
		{
			m_Normal.ToString(format, formatProvider),
			m_Distance.ToString(format, formatProvider)
		});
	}
}
