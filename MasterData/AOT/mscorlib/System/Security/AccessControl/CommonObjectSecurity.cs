namespace System.Security.AccessControl;

public abstract class CommonObjectSecurity : ObjectSecurity
{
	protected CommonObjectSecurity(bool isContainer)
		: base(isContainer, isDS: false)
	{
	}
}
