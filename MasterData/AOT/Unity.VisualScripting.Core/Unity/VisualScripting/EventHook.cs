namespace Unity.VisualScripting;

public struct EventHook
{
	public readonly string name;

	public readonly object target;

	public readonly object tag;

	public EventHook(string name, object target = null, object tag = null)
	{
		Ensure.That("name").IsNotNull(name);
		this.name = name;
		this.target = target;
		this.tag = tag;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is EventHook other))
		{
			return false;
		}
		return Equals(other);
	}

	public bool Equals(EventHook other)
	{
		if (name == other.name && object.Equals(target, other.target))
		{
			return object.Equals(tag, other.tag);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashUtility.GetHashCode(name, target, tag);
	}

	public static bool operator ==(EventHook a, EventHook b)
	{
		return a.Equals(b);
	}

	public static bool operator !=(EventHook a, EventHook b)
	{
		return !(a == b);
	}

	public static implicit operator EventHook(string name)
	{
		return new EventHook(name);
	}
}
