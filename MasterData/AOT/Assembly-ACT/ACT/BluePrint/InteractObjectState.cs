using System;
using Unity.VisualScripting;

namespace ACT.BluePrint;

[Inspectable]
public class InteractObjectState : IEquatable<InteractObjectState>
{
	[Inspectable]
	public int uid;

	[Inspectable]
	public int stateId;

	public bool Equals(InteractObjectState other)
	{
		if (other == null)
		{
			return false;
		}
		if (this == other)
		{
			return true;
		}
		if (uid == other.uid)
		{
			return stateId == other.stateId;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (this == obj)
		{
			return true;
		}
		if (obj.GetType() != GetType())
		{
			return false;
		}
		return Equals((InteractObjectState)obj);
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(uid, stateId);
	}
}
