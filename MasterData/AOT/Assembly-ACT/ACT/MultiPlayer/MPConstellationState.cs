using System;

namespace ACT.MultiPlayer;

public struct MPConstellationState : IEquatable<MPConstellationState>
{
	public int level;

	public bool active;

	public bool Equals(MPConstellationState other)
	{
		if (level == other.level)
		{
			return active == other.active;
		}
		return false;
	}
}
