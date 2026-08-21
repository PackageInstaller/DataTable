using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Math/MathScripting.h")]
[NativeHeader("Runtime/Geometry/Intersection.h")]
[NativeType(Header = "Runtime/Geometry/AABB.h")]
[NativeHeader("Runtime/Geometry/Ray.h")]
[NativeHeader("Runtime/Geometry/AABB.h")]
[NativeClass("AABB")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
public struct Bounds : IEquatable<Bounds>, IFormattable
{
	private Vector3 m_Center;

	[NativeName("m_Extent")]
	private Vector3 m_Extents;

	public Vector3 center
	{
		get
		{
			return m_Center;
		}
		set
		{
			m_Center = value;
		}
	}

	public Vector3 size
	{
		get
		{
			return m_Extents * 2f;
		}
		set
		{
			m_Extents = value * 0.5f;
		}
	}

	public Vector3 extents
	{
		get
		{
			return m_Extents;
		}
		set
		{
			m_Extents = value;
		}
	}

	public Vector3 min
	{
		get
		{
			return center - extents;
		}
		set
		{
			SetMinMax(value, max);
		}
	}

	public Vector3 max
	{
		get
		{
			return center + extents;
		}
		set
		{
			SetMinMax(min, value);
		}
	}

	[NativeMethod("IsInside", IsThreadSafe = true)]
	public bool Contains(Vector3 point)
	{
		return Contains_Injected(ref this, ref point);
	}

	[FreeFunction("BoundsScripting::SqrDistance", HasExplicitThis = true, IsThreadSafe = true)]
	public float SqrDistance(Vector3 point)
	{
		return SqrDistance_Injected(ref this, ref point);
	}

	[FreeFunction("IntersectRayAABB", IsThreadSafe = true)]
	private static bool IntersectRayAABB(Ray ray, Bounds bounds, out float dist)
	{
		return IntersectRayAABB_Injected(ref ray, ref bounds, out dist);
	}

	[FreeFunction("BoundsScripting::ClosestPoint", HasExplicitThis = true, IsThreadSafe = true)]
	public Vector3 ClosestPoint(Vector3 point)
	{
		ClosestPoint_Injected(ref this, ref point, out var ret);
		return ret;
	}

	public Bounds(Vector3 center, Vector3 size)
	{
		m_Center = center;
		m_Extents = size * 0.5f;
	}

	public override int GetHashCode()
	{
		return center.GetHashCode() ^ (extents.GetHashCode() << 2);
	}

	public override bool Equals(object other)
	{
		if (!(other is Bounds))
		{
			return false;
		}
		return Equals((Bounds)other);
	}

	public bool Equals(Bounds other)
	{
		return center.Equals(other.center) && extents.Equals(other.extents);
	}

	public static bool operator ==(Bounds lhs, Bounds rhs)
	{
		return lhs.center == rhs.center && lhs.extents == rhs.extents;
	}

	public static bool operator !=(Bounds lhs, Bounds rhs)
	{
		return !(lhs == rhs);
	}

	public void SetMinMax(Vector3 min, Vector3 max)
	{
		extents = (max - min) * 0.5f;
		center = min + extents;
	}

	public void Encapsulate(Vector3 point)
	{
		SetMinMax(Vector3.Min(min, point), Vector3.Max(max, point));
	}

	public void Encapsulate(Bounds bounds)
	{
		Encapsulate(bounds.center - bounds.extents);
		Encapsulate(bounds.center + bounds.extents);
	}

	public void Expand(float amount)
	{
		amount *= 0.5f;
		extents += new Vector3(amount, amount, amount);
	}

	public void Expand(Vector3 amount)
	{
		extents += amount * 0.5f;
	}

	public bool Intersects(Bounds bounds)
	{
		return min.x <= bounds.max.x && max.x >= bounds.min.x && min.y <= bounds.max.y && max.y >= bounds.min.y && min.z <= bounds.max.z && max.z >= bounds.min.z;
	}

	public bool IntersectRay(Ray ray)
	{
		float dist;
		return IntersectRayAABB(ray, this, out dist);
	}

	public bool IntersectRay(Ray ray, out float distance)
	{
		return IntersectRayAABB(ray, this, out distance);
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
		return UnityString.Format("Center: {0}, Extents: {1}", new object[2]
		{
			m_Center.ToString(format, formatProvider),
			m_Extents.ToString(format, formatProvider)
		});
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Contains_Injected(ref Bounds _unity_self, ref Vector3 point);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern float SqrDistance_Injected(ref Bounds _unity_self, ref Vector3 point);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IntersectRayAABB_Injected(ref Ray ray, ref Bounds bounds, out float dist);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ClosestPoint_Injected(ref Bounds _unity_self, ref Vector3 point, out Vector3 ret);
}
