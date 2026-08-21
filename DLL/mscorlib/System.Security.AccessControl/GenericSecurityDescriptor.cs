using System.Security.Principal;

namespace System.Security.AccessControl;

public abstract class GenericSecurityDescriptor
{
	public abstract ControlFlags ControlFlags { get; }

	public abstract SecurityIdentifier Group { get; set; }

	public abstract SecurityIdentifier Owner { get; set; }
}
