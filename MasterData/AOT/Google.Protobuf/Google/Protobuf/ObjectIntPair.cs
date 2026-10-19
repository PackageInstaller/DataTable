using System;

namespace Google.Protobuf;

internal struct ObjectIntPair<T> : IEquatable<ObjectIntPair<T>> where T : class
{
	private readonly int number;

	private readonly T obj;

	internal ObjectIntPair(T obj, int number)
	{
		this.number = number;
		this.obj = obj;
	}

	public bool Equals(ObjectIntPair<T> other)
	{
		if (obj == other.obj)
		{
			return number == other.number;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is ObjectIntPair<T>)
		{
			return Equals((ObjectIntPair<T>)obj);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return obj.GetHashCode() * 65535 + number;
	}
}
