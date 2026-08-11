using System;

namespace Ase;

public struct RegionIdxStruct : IEquatable<RegionIdxStruct>
{
	public int RegionX;

	public int RegionZ;

	public bool Equals(RegionIdxStruct other)
	{
		if (RegionX == other.RegionX)
		{
			return RegionZ == other.RegionZ;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return RegionX ^ RegionZ;
	}
}
