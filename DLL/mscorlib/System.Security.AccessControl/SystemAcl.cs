namespace System.Security.AccessControl;

public sealed class SystemAcl : CommonAcl
{
	public SystemAcl(bool isContainer, bool isDS, RawAcl rawAcl)
		: base(isContainer, isDS, rawAcl)
	{
	}

	internal override void ApplyCanonicalSortToExplicitAces()
	{
		int canonicalExplicitAceCount = GetCanonicalExplicitAceCount();
		ApplyCanonicalSortToExplicitAces(0, canonicalExplicitAceCount);
	}

	internal override int GetAceInsertPosition(AceQualifier aceQualifier)
	{
		return 0;
	}

	internal override bool IsAceMeaningless(GenericAce ace)
	{
		if (base.IsAceMeaningless(ace))
		{
			return true;
		}
		if (!IsValidAuditFlags(ace.AuditFlags))
		{
			return true;
		}
		QualifiedAce qualifiedAce = ace as QualifiedAce;
		if (null != qualifiedAce && AceQualifier.SystemAudit != qualifiedAce.AceQualifier && AceQualifier.SystemAlarm != qualifiedAce.AceQualifier)
		{
			return true;
		}
		return false;
	}

	private static bool IsValidAuditFlags(AuditFlags auditFlags)
	{
		if (auditFlags != AuditFlags.None)
		{
			return auditFlags == ((AuditFlags.Success | AuditFlags.Failure) & auditFlags);
		}
		return false;
	}
}
