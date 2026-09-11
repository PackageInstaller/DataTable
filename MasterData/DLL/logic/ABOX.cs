public struct ABOX
{
	public enum IntersectType
	{
		Disjoint,
		Contains,
		Intersects
	}

	public Int3 min;

	public Int3 max;

	public static readonly ABOX LargeBox;

	public static readonly ABOX SmallBox;

	public Int3 center => (min + max) * VFactor.half;

	public Int3 size => max - min;

	public Int3 extents => size * VFactor.half;

	internal long Perimeter => 2 * ((long)(max.x - min.x) * (long)(max.y - min.y) + (long)(max.x - min.x) * (long)(max.z - min.z) + (long)(max.z - min.z) * (long)(max.y - min.y)) / 1000;

	static ABOX()
	{
		LargeBox.min = new Int3(int.MinValue, int.MinValue, int.MinValue);
		LargeBox.max = new Int3(int.MaxValue, int.MaxValue, int.MaxValue);
		SmallBox.min = new Int3(int.MaxValue, int.MaxValue, int.MaxValue);
		SmallBox.max = new Int3(int.MinValue, int.MinValue, int.MinValue);
	}

	public ABOX(Int3 min, Int3 max)
	{
		this.min = min;
		this.max = max;
	}

	public void AddPoint(Int3 point)
	{
		AddPoint(ref point);
	}

	public void AddPoint(ref Int3 point)
	{
		IntMath.Max(ref max, ref point, out max);
		IntMath.Min(ref min, ref point, out min);
	}

	public static ABOX CreateFromPoints(Int3[] points)
	{
		Int3 value = new Int3(int.MaxValue, int.MaxValue, int.MaxValue);
		Int3 value2 = new Int3(int.MinValue, int.MinValue, int.MinValue);
		for (int i = 0; i < points.Length; i++)
		{
			IntMath.Min(ref value, ref points[i], out value);
			IntMath.Max(ref value2, ref points[i], out value2);
		}
		return new ABOX(value, value2);
	}

	public static ABOX CreateFromCenter(Int3 center, Int3 size)
	{
		Int3 @int = size * VFactor.half;
		return new ABOX(center - @int, center + @int);
	}

	public IntersectType Contains(ABOX box)
	{
		return Contains(ref box);
	}

	public bool Contains(Int3 point)
	{
		if (min.x <= point.x && min.y <= point.y && min.z <= point.z && point.x <= max.x && point.y <= max.y)
		{
			return point.z <= max.z;
		}
		return false;
	}

	public IntersectType Contains(ref ABOX box)
	{
		IntersectType result = IntersectType.Disjoint;
		if (max.x >= box.min.x && min.x <= box.max.x && max.y >= box.min.y && min.y <= box.max.y && max.z >= box.min.z && min.z <= box.max.z)
		{
			result = ((min.x <= box.min.x && box.max.x <= max.x && min.y <= box.min.y && box.max.y <= max.y && min.z <= box.min.z && box.max.z <= max.z) ? IntersectType.Contains : IntersectType.Intersects);
		}
		return result;
	}

	public bool IsOverlay(ref ABOX b)
	{
		if (Contains(ref b) == IntersectType.Disjoint)
		{
			return b.Contains(ref this) != IntersectType.Disjoint;
		}
		return true;
	}

	internal static ABOX CreateMerged(ABOX original, ABOX additional)
	{
		CreateMerged(ref original, ref additional, out var result);
		return result;
	}

	internal static void CreateMerged(ref ABOX original, ref ABOX additional, out ABOX result)
	{
		IntMath.Min(ref original.min, ref additional.min, out var result2);
		IntMath.Max(ref original.max, ref additional.max, out var result3);
		result.min = result2;
		result.max = result3;
	}

	private bool Intersect1D(int start, int dir, int min, int max, ref int enter, ref int exit)
	{
		if (dir * dir <= 0)
		{
			if (start >= min)
			{
				return start <= max;
			}
			return false;
		}
		int num = (min - start) * 1000 / dir;
		int num2 = (max - start) * 1000 / dir;
		if (num > num2)
		{
			int num3 = num;
			num = num2;
			num2 = num3;
		}
		if (num > exit || num2 < enter)
		{
			return false;
		}
		if (num > enter)
		{
			enter = num;
		}
		if (num2 < exit)
		{
			exit = num2;
		}
		return true;
	}

	internal bool RayIntersect(ref Int3 origin, ref Int3 direction)
	{
		int enter = 0;
		int exit = int.MaxValue;
		if (!Intersect1D(origin.x, direction.x, min.x, max.x, ref enter, ref exit))
		{
			return false;
		}
		if (!Intersect1D(origin.y, direction.y, min.y, max.y, ref enter, ref exit))
		{
			return false;
		}
		if (!Intersect1D(origin.z, direction.z, min.z, max.z, ref enter, ref exit))
		{
			return false;
		}
		return true;
	}

	public override string ToString()
	{
		return string.Concat("min: ", min, ",max: ", max);
	}
}
