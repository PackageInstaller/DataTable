namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public sealed class ReadOnlyAttribute : Attribute
{
	public static readonly ReadOnlyAttribute Yes = new ReadOnlyAttribute(isReadOnly: true);

	public static readonly ReadOnlyAttribute No = new ReadOnlyAttribute(isReadOnly: false);

	public static readonly ReadOnlyAttribute Default = No;

	public bool IsReadOnly { get; }

	public ReadOnlyAttribute(bool isReadOnly)
	{
		IsReadOnly = isReadOnly;
	}

	public override bool Equals(object value)
	{
		if (this == value)
		{
			return true;
		}
		return (value as ReadOnlyAttribute)?.IsReadOnly == IsReadOnly;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public override bool IsDefaultAttribute()
	{
		return IsReadOnly == Default.IsReadOnly;
	}
}
