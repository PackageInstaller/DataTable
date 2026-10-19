using System;

namespace ACT.MultiPlayer;

public struct MPSkill : IEquatable<MPSkill>
{
	public int id;

	public byte level;

	public bool Equals(MPSkill other)
	{
		if (id == other.id)
		{
			return level == other.level;
		}
		return false;
	}

	public void Reset()
	{
		id = 0;
		level = 0;
	}

	public bool IsEmpty()
	{
		if (id != 0)
		{
			return level == 0;
		}
		return true;
	}
}
