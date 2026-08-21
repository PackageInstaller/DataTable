namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method | AttributeTargets.Property | AttributeTargets.Event)]
public class DisplayNameAttribute : Attribute
{
	public static readonly DisplayNameAttribute Default = new DisplayNameAttribute();

	public virtual string DisplayName => DisplayNameValue;

	protected string DisplayNameValue { get; set; }

	public DisplayNameAttribute()
		: this(string.Empty)
	{
	}

	public DisplayNameAttribute(string displayName)
	{
		DisplayNameValue = displayName;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj is DisplayNameAttribute displayNameAttribute)
		{
			return displayNameAttribute.DisplayName == DisplayName;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return DisplayName.GetHashCode();
	}

	public override bool IsDefaultAttribute()
	{
		return Equals(Default);
	}
}
