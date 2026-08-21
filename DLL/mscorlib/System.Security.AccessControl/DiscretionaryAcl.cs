using System.Security.Principal;

namespace System.Security.AccessControl;

public sealed class DiscretionaryAcl : CommonAcl
{
	public DiscretionaryAcl(bool isContainer, bool isDS, int capacity)
		: base(isContainer, isDS, capacity)
	{
	}

	public void AddAccess(AccessControlType accessType, SecurityIdentifier sid, int accessMask, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags)
	{
		AddAce(GetAceQualifier(accessType), sid, accessMask, inheritanceFlags, propagationFlags, AuditFlags.None);
	}

	internal override void ApplyCanonicalSortToExplicitAces()
	{
		int canonicalExplicitAceCount = GetCanonicalExplicitAceCount();
		int canonicalExplicitDenyAceCount = GetCanonicalExplicitDenyAceCount();
		ApplyCanonicalSortToExplicitAces(0, canonicalExplicitDenyAceCount);
		ApplyCanonicalSortToExplicitAces(canonicalExplicitDenyAceCount, canonicalExplicitAceCount - canonicalExplicitDenyAceCount);
	}

	internal override int GetAceInsertPosition(AceQualifier aceQualifier)
	{
		if (aceQualifier == AceQualifier.AccessAllowed)
		{
			return GetCanonicalExplicitDenyAceCount();
		}
		return 0;
	}

	private static AceQualifier GetAceQualifier(AccessControlType accessType)
	{
		if (accessType == AccessControlType.Allow)
		{
			return AceQualifier.AccessAllowed;
		}
		if (AccessControlType.Deny == accessType)
		{
			return AceQualifier.AccessDenied;
		}
		throw new ArgumentOutOfRangeException("accessType");
	}

	internal override bool IsAceMeaningless(GenericAce ace)
	{
		if (base.IsAceMeaningless(ace))
		{
			return true;
		}
		if (ace.AuditFlags != AuditFlags.None)
		{
			return true;
		}
		QualifiedAce qualifiedAce = ace as QualifiedAce;
		if (null != qualifiedAce && qualifiedAce.AceQualifier != AceQualifier.AccessAllowed && AceQualifier.AccessDenied != qualifiedAce.AceQualifier)
		{
			return true;
		}
		return false;
	}
}
