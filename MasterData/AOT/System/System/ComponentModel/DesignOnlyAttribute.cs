namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public sealed class DesignOnlyAttribute : Attribute
{
	public static readonly DesignOnlyAttribute Yes = new DesignOnlyAttribute(isDesignOnly: true);

	public static readonly DesignOnlyAttribute No = new DesignOnlyAttribute(isDesignOnly: false);

	public static readonly DesignOnlyAttribute Default = No;

	public bool IsDesignOnly { get; }

	public DesignOnlyAttribute(bool isDesignOnly)
	{
		IsDesignOnly = isDesignOnly;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		return (obj as DesignOnlyAttribute)?.IsDesignOnly == IsDesignOnly;
	}

	public override int GetHashCode()
	{
		return IsDesignOnly.GetHashCode();
	}

	public override bool IsDefaultAttribute()
	{
		return IsDesignOnly == Default.IsDesignOnly;
	}
}
