using System.Security.Principal;

namespace System.Security.AccessControl;

public abstract class GenericSecurityDescriptor
{
	public abstract SecurityIdentifier Group { set; }

	public abstract SecurityIdentifier Owner { set; }
}
