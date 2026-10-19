using System;

namespace ACT.MultiPlayer;

public struct MPConstellation : IEquatable<MPConstellation>
{
	public int level;

	public bool Equals(MPConstellation other)
	{
		return other.level == level;
	}
}
