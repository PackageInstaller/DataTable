namespace System.Security.AccessControl;

public abstract class CommonObjectSecurity : ObjectSecurity
{
	protected CommonObjectSecurity(bool isContainer)
		: base(isContainer, isDS: false)
	{
	}

	protected void AddAccessRule(AccessRule rule)
	{
		ModifyAccess(AccessControlModification.Add, rule, out var _);
	}

	protected override bool ModifyAccess(AccessControlModification modification, AccessRule rule, out bool modified)
	{
		if (rule == null)
		{
			throw new ArgumentNullException("rule");
		}
		modified = true;
		WriteLock();
		try
		{
			switch (modification)
			{
			case AccessControlModification.Add:
				descriptor.DiscretionaryAcl.AddAccess(rule.AccessControlType, ObjectSecurity.SidFromIR(rule.IdentityReference), rule.AccessMask, rule.InheritanceFlags, rule.PropagationFlags);
				break;
			case AccessControlModification.Set:
				descriptor.DiscretionaryAcl.SetAccess(rule.AccessControlType, ObjectSecurity.SidFromIR(rule.IdentityReference), rule.AccessMask, rule.InheritanceFlags, rule.PropagationFlags);
				break;
			case AccessControlModification.Reset:
				PurgeAccessRules(rule.IdentityReference);
				goto case AccessControlModification.Add;
			case AccessControlModification.Remove:
				modified = descriptor.DiscretionaryAcl.RemoveAccess(rule.AccessControlType, ObjectSecurity.SidFromIR(rule.IdentityReference), rule.AccessMask, rule.InheritanceFlags, rule.PropagationFlags);
				break;
			case AccessControlModification.RemoveAll:
				PurgeAccessRules(rule.IdentityReference);
				break;
			case AccessControlModification.RemoveSpecific:
				descriptor.DiscretionaryAcl.RemoveAccessSpecific(rule.AccessControlType, ObjectSecurity.SidFromIR(rule.IdentityReference), rule.AccessMask, rule.InheritanceFlags, rule.PropagationFlags);
				break;
			default:
				throw new ArgumentOutOfRangeException("modification");
			}
			if (modified)
			{
				base.AccessRulesModified = true;
			}
		}
		finally
		{
			WriteUnlock();
		}
		return modified;
	}
}
