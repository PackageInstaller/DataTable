namespace FixedPoint;

public struct TSBounds(TSVector center, TSVector size)
{
	private TSVector m_Center = center;

	private TSVector m_Extents = size / 2;

	public TSVector center
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

	public TSVector size
	{
		get
		{
			return m_Extents * 2f;
		}
		set
		{
			m_Extents = value / 2;
		}
	}

	public TSVector extents
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

	public TSVector min
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

	public TSVector max
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

	public bool Contains(TSVector point)
	{
		return false;
	}

	public float SqrDistance(TSVector point)
	{
		return 0f;
	}

	public TSVector ClosestPoint(TSVector point)
	{
		return TSVector.zero;
	}

	public override int GetHashCode()
	{
		return center.GetHashCode() ^ (extents.GetHashCode() << 2);
	}

	public override bool Equals(object other)
	{
		if (!(other is TSBounds tSBounds))
		{
			return false;
		}
		if (center.Equals(tSBounds.center))
		{
			return extents.Equals(tSBounds.extents);
		}
		return false;
	}

	public static bool operator ==(TSBounds lhs, TSBounds rhs)
	{
		if (lhs.center == rhs.center)
		{
			return lhs.extents == rhs.extents;
		}
		return false;
	}

	public static bool operator !=(TSBounds lhs, TSBounds rhs)
	{
		return !(lhs == rhs);
	}

	public void SetMinMax(TSVector min, TSVector max)
	{
		extents = (max - min) / 2;
		center = min + extents;
	}

	public void Encapsulate(TSVector point)
	{
		SetMinMax(TSVector.Min(min, point), TSVector.Max(max, point));
	}

	public void Encapsulate(TSBounds bounds)
	{
		Encapsulate(bounds.center - bounds.extents);
		Encapsulate(bounds.center + bounds.extents);
	}

	public void Expand(float amount)
	{
		amount /= 2f;
		extents += new TSVector(amount, amount, amount);
	}

	public void Expand(TSVector amount)
	{
		extents += amount / 2;
	}

	public bool Intersects(TSBounds bounds)
	{
		if (min.x <= bounds.max.x && max.x >= bounds.min.x && min.y <= bounds.max.y && max.y >= bounds.min.y && min.z <= bounds.max.z)
		{
			return max.z >= bounds.min.z;
		}
		return false;
	}

	public override string ToString()
	{
		object[] args = new object[2] { m_Center, m_Extents };
		return string.Format("Center: {0}, Extents: {1}", args);
	}
}
