namespace System.ComponentModel;

public abstract class EventDescriptor : MemberDescriptor
{
	protected EventDescriptor(string name, Attribute[] attrs)
		: base(name, attrs)
	{
	}
}
