public struct VRect
{
	private int m_XMin;

	private int m_YMin;

	private int m_Width;

	private int m_Height;

	public int x
	{
		get
		{
			return m_XMin;
		}
		set
		{
			m_XMin = value;
		}
	}

	public int y
	{
		get
		{
			return m_YMin;
		}
		set
		{
			m_YMin = value;
		}
	}

	public Int2 position
	{
		get
		{
			return new Int2(m_XMin, m_YMin);
		}
		set
		{
			m_XMin = value.x;
			m_YMin = value.y;
		}
	}

	public Int2 center
	{
		get
		{
			return new Int2(x + (m_Width >> 1), y + (m_Height >> 1));
		}
		set
		{
			m_XMin = value.x - (m_Width >> 1);
			m_YMin = value.y - (m_Height >> 1);
		}
	}

	public Int2 min
	{
		get
		{
			return new Int2(xMin, yMin);
		}
		set
		{
			xMin = value.x;
			yMin = value.y;
		}
	}

	public Int2 max
	{
		get
		{
			return new Int2(xMax, yMax);
		}
		set
		{
			xMax = value.x;
			yMax = value.y;
		}
	}

	public int width
	{
		get
		{
			return m_Width;
		}
		set
		{
			m_Width = value;
		}
	}

	public int height
	{
		get
		{
			return m_Height;
		}
		set
		{
			m_Height = value;
		}
	}

	public Int2 size
	{
		get
		{
			return new Int2(m_Width, m_Height);
		}
		set
		{
			m_Width = value.x;
			m_Height = value.y;
		}
	}

	public int xMin
	{
		get
		{
			return m_XMin;
		}
		set
		{
			int num = xMax;
			m_XMin = value;
			m_Width = num - m_XMin;
		}
	}

	public int yMin
	{
		get
		{
			return m_YMin;
		}
		set
		{
			int num = yMax;
			m_YMin = value;
			m_Height = num - m_YMin;
		}
	}

	public int xMax
	{
		get
		{
			return m_Width + m_XMin;
		}
		set
		{
			m_Width = value - m_XMin;
		}
	}

	public int yMax
	{
		get
		{
			return m_Height + m_YMin;
		}
		set
		{
			m_Height = value - m_YMin;
		}
	}

	public VRect(int left, int top, int width, int height)
	{
		m_XMin = left;
		m_YMin = top;
		m_Width = width;
		m_Height = height;
	}

	public VRect(VRect source)
	{
		m_XMin = source.m_XMin;
		m_YMin = source.m_YMin;
		m_Width = source.m_Width;
		m_Height = source.m_Height;
	}

	public static VRect MinMaxRect(int left, int top, int right, int bottom)
	{
		return new VRect(left, top, right - left, bottom - top);
	}

	public void Set(int left, int top, int width, int height)
	{
		m_XMin = left;
		m_YMin = top;
		m_Width = width;
		m_Height = height;
	}

	public override string ToString()
	{
		object[] args = new object[4] { x, y, width, height };
		return string.Format("(x:{0:F2}, y:{1:F2}, width:{2:F2}, height:{3:F2})", args);
	}

	public string ToString(string format)
	{
		object[] args = new object[4]
		{
			x.ToString(format),
			y.ToString(format),
			width.ToString(format),
			height.ToString(format)
		};
		return string.Format("(x:{0}, y:{1}, width:{2}, height:{3})", args);
	}

	public bool Contains(Int2 point)
	{
		if (point.x >= xMin && point.x < xMax && point.y >= yMin)
		{
			return point.y < yMax;
		}
		return false;
	}

	public bool Contains(Int3 point)
	{
		if (point.x >= xMin && point.x < xMax && point.y >= yMin)
		{
			return point.y < yMax;
		}
		return false;
	}

	public bool Contains(Int3 point, bool allowInverse)
	{
		if (!allowInverse)
		{
			return Contains(point);
		}
		bool flag = false;
		if (((float)width < 0f && point.x <= xMin && point.x > xMax) || ((float)width >= 0f && point.x >= xMin && point.x < xMax))
		{
			flag = true;
		}
		if (flag)
		{
			if (!((float)height < 0f) || point.y > yMin || point.y <= yMax)
			{
				if ((float)height >= 0f && point.y >= yMin)
				{
					return point.y < yMax;
				}
				return false;
			}
			return true;
		}
		return false;
	}

	private static VRect OrderMinMax(VRect rect)
	{
		if (rect.xMin > rect.xMax)
		{
			int num = rect.xMin;
			rect.xMin = rect.xMax;
			rect.xMax = num;
		}
		if (rect.yMin > rect.yMax)
		{
			int num2 = rect.yMin;
			rect.yMin = rect.yMax;
			rect.yMax = num2;
		}
		return rect;
	}

	public bool Overlaps(VRect other)
	{
		if (other.xMax > xMin && other.xMin < xMax && other.yMax > yMin)
		{
			return other.yMin < yMax;
		}
		return false;
	}

	public bool Overlaps(VRect other, bool allowInverse)
	{
		VRect rect = this;
		if (allowInverse)
		{
			rect = OrderMinMax(rect);
			other = OrderMinMax(other);
		}
		return rect.Overlaps(other);
	}

	public override int GetHashCode()
	{
		return x.GetHashCode() ^ (width.GetHashCode() << 2) ^ (y.GetHashCode() >> 2) ^ (height.GetHashCode() >> 1);
	}

	public override bool Equals(object other)
	{
		if (!(other is VRect vRect))
		{
			return false;
		}
		if (x.Equals(vRect.x) && y.Equals(vRect.y) && width.Equals(vRect.width))
		{
			return height.Equals(vRect.height);
		}
		return false;
	}

	public static bool operator !=(VRect lhs, VRect rhs)
	{
		if (lhs.x == rhs.x && lhs.y == rhs.y && lhs.width == rhs.width)
		{
			return lhs.height != rhs.height;
		}
		return true;
	}

	public static bool operator ==(VRect lhs, VRect rhs)
	{
		if (lhs.x == rhs.x && lhs.y == rhs.y && lhs.width == rhs.width)
		{
			return lhs.height == rhs.height;
		}
		return false;
	}
}
