public struct Factor3
{
	public VFactor x;

	public VFactor y;

	public VFactor z;

	public static Factor3 one => new Factor3(VFactor.one, VFactor.one, VFactor.one);

	public VFactor this[int i]
	{
		get
		{
			return i switch
			{
				1 => y, 
				0 => x, 
				_ => z, 
			};
		}
		set
		{
			switch (i)
			{
			case 0:
				x = value;
				break;
			case 1:
				y = value;
				break;
			default:
				z = value;
				break;
			}
		}
	}

	public Factor3(VFactor _x, VFactor _y, VFactor _z)
	{
		x = _x;
		y = _y;
		z = _z;
	}

	public static Factor3 operator -(Factor3 lhs)
	{
		lhs.x = -lhs.x;
		lhs.y = -lhs.y;
		lhs.z = -lhs.z;
		return lhs;
	}
}
