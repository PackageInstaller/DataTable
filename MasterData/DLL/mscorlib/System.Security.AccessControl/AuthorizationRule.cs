using System.Security.Principal;

namespace System.Security.AccessControl;

public abstract class AuthorizationRule
{
	private IdentityReference identity;

	private int accessMask;

	private bool isInherited;

	private InheritanceFlags inheritanceFlags;

	private PropagationFlags propagationFlags;

	public IdentityReference IdentityReference => identity;

	public InheritanceFlags InheritanceFlags => inheritanceFlags;

	public PropagationFlags PropagationFlags => propagationFlags;

	protected internal int AccessMask => accessMask;

	protected internal AuthorizationRule(IdentityReference identity, int accessMask, bool isInherited, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags)
	{
		if (null == identity)
		{
			throw new ArgumentNullException("identity");
		}
		if (!(identity is SecurityIdentifier) && !(identity is NTAccount))
		{
			throw new ArgumentException("identity");
		}
		if (accessMask == 0)
		{
			throw new ArgumentException("accessMask");
		}
		if ((inheritanceFlags & ~(InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit)) != InheritanceFlags.None)
		{
			throw new ArgumentOutOfRangeException();
		}
		if ((propagationFlags & ~(PropagationFlags.NoPropagateInherit | PropagationFlags.InheritOnly)) != PropagationFlags.None)
		{
			throw new ArgumentOutOfRangeException();
		}
		this.identity = identity;
		this.accessMask = accessMask;
		this.isInherited = isInherited;
		this.inheritanceFlags = inheritanceFlags;
		this.propagationFlags = propagationFlags;
	}
}
