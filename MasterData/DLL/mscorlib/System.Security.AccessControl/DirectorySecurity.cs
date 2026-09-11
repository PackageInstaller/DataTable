namespace System.Security.AccessControl;

public sealed class DirectorySecurity : FileSystemSecurity
{
	public DirectorySecurity(string name, AccessControlSections includeSections)
		: base(isContainer: true, name, includeSections)
	{
	}
}
