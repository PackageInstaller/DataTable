using System;
using System.Numerics;
using System.Runtime.Serialization;

namespace Octree;

[DataContract]
public struct BoundingBox
{
	[DataMember]
	public Vector3 Center { get; set; }

	[DataMember]
	public Vector3 Extents { get; set; }

	public Vector3 Size
	{
		get
		{
			return Extents * 2f;
		}
		set
		{
			Extents = value * 0.5f;
		}
	}

	public Vector3 Min
	{
		get
		{
			return Center - Extents;
		}
		set
		{
			SetMinMax(value, Max);
		}
	}

	public Vector3 Max
	{
		get
		{
			return Center + Extents;
		}
		set
		{
			SetMinMax(Min, value);
		}
	}

	public BoundingBox(Vector3 center, Vector3 size)
	{
		Center = center;
		Extents = size * 0.5f;
	}

	public void SetMinMax(Vector3 min, Vector3 max)
	{
		Extents = (max - min) * 0.5f;
		Center = min + Extents;
	}

	public void Encapsulate(Vector3 point)
	{
		SetMinMax(Vector3.Min(Min, point), Vector3.Max(Max, point));
	}

	public void Encapsulate(BoundingBox box)
	{
		Encapsulate(box.Center - box.Extents);
		Encapsulate(box.Center + box.Extents);
	}

	public void Expand(float amount)
	{
		amount *= 0.5f;
		Extents += new Vector3(amount, amount, amount);
	}

	public void Expand(Vector3 amount)
	{
		Extents += amount * 0.5f;
	}

	public bool Contains(Vector3 point)
	{
		if (Min.X <= point.X && Max.X >= point.X && Min.Y <= point.Y && Max.Y >= point.Y && Min.Z <= point.Z)
		{
			return Max.Z >= point.Z;
		}
		return false;
	}

	public bool Intersects(BoundingBox box)
	{
		if (Min.X <= box.Max.X && Max.X >= box.Min.X && Min.Y <= box.Max.Y && Max.Y >= box.Min.Y && Min.Z <= box.Max.Z)
		{
			return Max.Z >= box.Min.Z;
		}
		return false;
	}

	public bool IntersectRay(Ray ray)
	{
		float distance;
		return IntersectRay(ray, out distance);
	}

	public bool IntersectRay(Ray ray, out float distance)
	{
		Vector3 vector = new Vector3(1f / ray.Direction.X, 1f / ray.Direction.Y, 1f / ray.Direction.Z);
		float val = (Min.X - ray.Origin.X) * vector.X;
		float val2 = (Max.X - ray.Origin.X) * vector.X;
		float val3 = (Min.Y - ray.Origin.Y) * vector.Y;
		float val4 = (Max.Y - ray.Origin.Y) * vector.Y;
		float val5 = (Min.Z - ray.Origin.Z) * vector.Z;
		float val6 = (Max.Z - ray.Origin.Z) * vector.Z;
		float num = Math.Max(Math.Max(Math.Min(val, val2), Math.Min(val3, val4)), Math.Min(val5, val6));
		float num2 = Math.Min(Math.Min(Math.Max(val, val2), Math.Max(val3, val4)), Math.Max(val5, val6));
		if (num2 < 0f)
		{
			distance = num2;
			return false;
		}
		if (num > num2)
		{
			distance = num2;
			return false;
		}
		distance = num;
		return true;
	}

	public override int GetHashCode()
	{
		return Center.GetHashCode() ^ (Extents.GetHashCode() << 2);
	}

	public override bool Equals(object other)
	{
		if (!(other is BoundingBox boundingBox))
		{
			return false;
		}
		return Center.Equals(boundingBox.Center) && Extents.Equals(boundingBox.Extents);
	}

	public override string ToString()
	{
		return $"Center: {Center}, Extents: {Extents}";
	}

	public string ToString(string format)
	{
		return $"Center: {Center.ToString(format)}, Extents: {Extents.ToString(format)}";
	}

	public static bool operator ==(BoundingBox lhs, BoundingBox rhs)
	{
		if (lhs.Center == rhs.Center)
		{
			return lhs.Extents == rhs.Extents;
		}
		return false;
	}

	public static bool operator !=(BoundingBox lhs, BoundingBox rhs)
	{
		return !(lhs == rhs);
	}
}
