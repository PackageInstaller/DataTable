using System.Security.Principal;

namespace System.Security.AccessControl;

public sealed class MutexAccessRule : AccessRule
{
	public MutexAccessRule(IdentityReference identity, MutexRights eventRights, AccessControlType type)
		: base(identity, (int)eventRights, isInherited: false, InheritanceFlags.None, PropagationFlags.None, type)
	{
	}
}
