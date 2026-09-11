namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Interface)]
public sealed class DesignTimeVisibleAttribute : Attribute
{
	public static readonly DesignTimeVisibleAttribute Yes = new DesignTimeVisibleAttribute(visible: true);

	public static readonly DesignTimeVisibleAttribute No = new DesignTimeVisibleAttribute(visible: false);

	public static readonly DesignTimeVisibleAttribute Default = Yes;

	public bool Visible { get; }

	public DesignTimeVisibleAttribute(bool visible)
	{
		Visible = visible;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj is DesignTimeVisibleAttribute designTimeVisibleAttribute)
		{
			return designTimeVisibleAttribute.Visible == Visible;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return typeof(DesignTimeVisibleAttribute).GetHashCode() ^ (Visible ? (-1) : 0);
	}

	public override bool IsDefaultAttribute()
	{
		return Visible == Default.Visible;
	}
}
