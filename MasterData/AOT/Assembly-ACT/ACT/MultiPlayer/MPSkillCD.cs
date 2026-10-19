using System;

namespace ACT.MultiPlayer;

public struct MPSkillCD : IEquatable<MPSkillCD>
{
	public int count;

	public bool Equals(MPSkillCD other)
	{
		return count == other.count;
	}
}
