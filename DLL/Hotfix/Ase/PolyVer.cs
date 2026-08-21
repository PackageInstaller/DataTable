namespace Ase;

public struct PolyVer
{
	public double Slope { get; set; }

	public int SortIndex { get; set; }

	public int CompareTo(PolyVer obj = default(PolyVer))
	{
		int num = 1;
		num = Slope.CompareTo(obj.Slope);
		if (num == 0)
		{
			num = SortIndex.CompareTo(obj.SortIndex);
		}
		return num;
	}

	public void Copy(PolyVer obj)
	{
		Slope = obj.Slope;
		SortIndex = obj.SortIndex;
	}
}
