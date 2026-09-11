using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Math/MathScripting.h")]
[NativeClass("AABB")]
[NativeType(Header = "Runtime/Geometry/AABB.h")]
[NativeHeader("Runtime/Geometry/AABB.h")]
[NativeHeader("Runtime/Geometry/Intersection.h")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
[NativeHeader("Runtime/Geometry/Ray.h")]
public struct Bounds(Vector3 center, Vector3 size) : IEquatable<Bounds>, IFormattable
{
	private Vector3 m_Center = center;

	[NativeName("m_Extent")]
	private Vector3 m_Extents = size * 0.5f;

	public Vector3 center
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Center;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Center = value;
		}
	}

	public Vector3 size
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Extents * 2f;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Extents = value * 0.5f;
		}
	}

	public Vector3 extents
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Extents;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Extents = value;
		}
	}

	public Vector3 min
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return center - extents;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			SetMinMax(value, max);
		}
	}

	public Vector3 max
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return center + extents;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			SetMinMax(min, value);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public override int GetHashCode()
	{
		return center.GetHashCode() ^ (extents.GetHashCode() << 2);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is Bounds))
		{
			return false;
		}
		return Equals((Bounds)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(Bounds other)
	{
		return center.Equals(other.center) && extents.Equals(other.extents);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Bounds lhs, Bounds rhs)
	{
		return lhs.center == rhs.center && lhs.extents == rhs.extents;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Bounds lhs, Bounds rhs)
	{
		return !(lhs == rhs);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void SetMinMax(Vector3 min, Vector3 max)
	{
		extents = (max - min) * 0.5f;
		center = min + extents;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Encapsulate(Vector3 point)
	{
		SetMinMax(Vector3.Min(min, point), Vector3.Max(max, point));
	}

	[MethodImpl((MethodImplOptions)256)]
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

	[MethodImpl((MethodImplOptions)256)]
	public void Expand(Vector3 amount)
	{
		extents += amount * 0.5f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Intersects(Bounds bounds)
	{
		return min.x <= bounds.max.x && max.x >= bounds.min.x && min.y <= bounds.max.y && max.y >= bounds.min.y && min.z <= bounds.max.z && max.z >= bounds.min.z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool IntersectRay(Ray ray)
	{
		float dist;
		return IntersectRayAABB(ray, this, out dist);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool IntersectRay(Ray ray, out float distance)
	{
		return IntersectRayAABB(ray, this, out distance);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override string ToString()
	{
		return ToString(null, null);
	}

	[MethodImpl((MethodImplOptions)256)]
	public string ToString(string format)
	{
		return ToString(format, null);
	}

	[MethodImpl((MethodImplOptions)256)]
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
		return UnityString.Format("Center: {0}, Extents: {1}", m_Center.ToString(format, formatProvider), m_Extents.ToString(format, formatProvider));
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

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Contains_Injected(ref Bounds _unity_self, ref Vector3 point);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern float SqrDistance_Injected(ref Bounds _unity_self, ref Vector3 point);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IntersectRayAABB_Injected(ref Ray ray, ref Bounds bounds, out float dist);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ClosestPoint_Injected(ref Bounds _unity_self, ref Vector3 point, out Vector3 ret);
}
