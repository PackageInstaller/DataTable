namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.Property)]
public sealed class NotifyParentPropertyAttribute : Attribute
{
	public static readonly NotifyParentPropertyAttribute Yes = new NotifyParentPropertyAttribute(notifyParent: true);

	public static readonly NotifyParentPropertyAttribute No = new NotifyParentPropertyAttribute(notifyParent: false);

	public static readonly NotifyParentPropertyAttribute Default = No;

	private bool notifyParent;

	public bool NotifyParent => notifyParent;

	public NotifyParentPropertyAttribute(bool notifyParent)
	{
		this.notifyParent = notifyParent;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj != null && obj is NotifyParentPropertyAttribute)
		{
			return ((NotifyParentPropertyAttribute)obj).NotifyParent == notifyParent;
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
