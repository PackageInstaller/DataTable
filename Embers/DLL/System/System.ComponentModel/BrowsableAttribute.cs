namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public sealed class BrowsableAttribute : Attribute
{
	public static readonly BrowsableAttribute Yes = new BrowsableAttribute(browsable: true);

	public static readonly BrowsableAttribute No = new BrowsableAttribute(browsable: false);

	public static readonly BrowsableAttribute Default = Yes;

	public bool Browsable { get; }

	public BrowsableAttribute(bool browsable)
	{
		Browsable = browsable;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		return (obj as BrowsableAttribute)?.Browsable == Browsable;
	}

	public override int GetHashCode()
	{
		return Browsable.GetHashCode();
	}

	public override bool IsDefaultAttribute()
	{
		return Equals(Default);
	}
}
