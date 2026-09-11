namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public class DescriptionAttribute : Attribute
{
	public static readonly DescriptionAttribute Default = new DescriptionAttribute();

	public virtual string Description => DescriptionValue;

	protected string DescriptionValue { get; set; }

	public DescriptionAttribute()
		: this(string.Empty)
	{
	}

	public DescriptionAttribute(string description)
	{
		DescriptionValue = description;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj is DescriptionAttribute descriptionAttribute)
		{
			return descriptionAttribute.Description == Description;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return Description.GetHashCode();
	}

	public override bool IsDefaultAttribute()
	{
		return Equals(Default);
	}
}
