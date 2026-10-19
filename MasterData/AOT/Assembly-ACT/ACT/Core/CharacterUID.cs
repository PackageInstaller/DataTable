using System;

namespace ACT.Core;

public readonly struct CharacterUID : IEquatable<CharacterUID>
{
	public int Id { get; }

	public bool IsTrialCharacter { get; }

	public CharacterUID(int id, bool isTrialCharacter)
	{
		Id = id;
		IsTrialCharacter = isTrialCharacter;
	}

	public bool Equals(CharacterUID other)
	{
		if (Id == other.Id)
		{
			return IsTrialCharacter == other.IsTrialCharacter;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is CharacterUID other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (Id * 397) ^ (IsTrialCharacter ? 1 : 0);
	}

	public static bool operator ==(CharacterUID left, CharacterUID right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(CharacterUID left, CharacterUID right)
	{
		return !left.Equals(right);
	}
}
