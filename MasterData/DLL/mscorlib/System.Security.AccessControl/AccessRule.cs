using System.Security.Principal;

namespace System.Security.AccessControl;

public abstract class AccessRule : AuthorizationRule
{
	private AccessControlType type;

	public AccessControlType AccessControlType => type;

	protected AccessRule(IdentityReference identity, int accessMask, bool isInherited, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AccessControlType type)
		: base(identity, accessMask, isInherited, inheritanceFlags, propagationFlags)
	{
		if (type < AccessControlType.Allow || type > AccessControlType.Deny)
		{
			throw new ArgumentException("Invalid access control type.", "type");
		}
		this.type = type;
	}
}
