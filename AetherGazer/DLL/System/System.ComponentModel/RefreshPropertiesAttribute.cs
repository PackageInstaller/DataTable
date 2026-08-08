namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public sealed class RefreshPropertiesAttribute : Attribute
{
	public static readonly RefreshPropertiesAttribute All = new RefreshPropertiesAttribute(RefreshProperties.All);

	public static readonly RefreshPropertiesAttribute Repaint = new RefreshPropertiesAttribute(RefreshProperties.Repaint);

	public static readonly RefreshPropertiesAttribute Default = new RefreshPropertiesAttribute(RefreshProperties.None);

	private RefreshProperties refresh;

	public RefreshProperties RefreshProperties => refresh;

	public RefreshPropertiesAttribute(RefreshProperties refresh)
	{
		this.refresh = refresh;
	}

	public override bool Equals(object value)
	{
		if (value is RefreshPropertiesAttribute)
		{
			return ((RefreshPropertiesAttribute)value).RefreshProperties == refresh;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public override bool IsDefaultAttribute()
	{
		return Equals(Default);
	}
}
