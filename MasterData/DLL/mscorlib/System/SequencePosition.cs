using System.Numerics.Hashing;

namespace System;

public readonly struct SequencePosition(object @object, int integer) : IEquatable<SequencePosition>
{
	private readonly object _object = @object;

	private readonly int _integer = integer;

	public object GetObject()
	{
		return _object;
	}

	public int GetInteger()
	{
		return _integer;
	}

	public bool Equals(SequencePosition other)
	{
		if (_integer == other._integer)
		{
			return object.Equals(_object, other._object);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is SequencePosition other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashHelpers.Combine(_object?.GetHashCode() ?? 0, _integer);
	}
}
