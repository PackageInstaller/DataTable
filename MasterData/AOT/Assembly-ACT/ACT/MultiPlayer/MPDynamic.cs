using System;

namespace ACT.MultiPlayer;

public struct MPDynamic : IEquatable<MPDynamic>
{
	public int id;

	public float value;

	public bool Equals(MPDynamic other)
	{
		return id == other.id;
	}
}
