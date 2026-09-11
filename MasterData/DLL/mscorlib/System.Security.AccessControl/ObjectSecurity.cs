using System.Security.Principal;
using System.Threading;

namespace System.Security.AccessControl;

public abstract class ObjectSecurity
{
	internal CommonSecurityDescriptor descriptor;

	private AccessControlSections sections_modified;

	private ReaderWriterLock rw_lock;

	public bool AreAccessRulesProtected
	{
		get
		{
			ReadLock();
			try
			{
				return (descriptor.ControlFlags & ControlFlags.DiscretionaryAclProtected) != 0;
			}
			finally
			{
				ReadUnlock();
			}
		}
	}

	public bool AreAuditRulesProtected
	{
		get
		{
			ReadLock();
			try
			{
				return (descriptor.ControlFlags & ControlFlags.SystemAclProtected) != 0;
			}
			finally
			{
				ReadUnlock();
			}
		}
	}

	internal AccessControlSections AccessControlSectionsModified
	{
		get
		{
			Reading();
			return sections_modified;
		}
		set
		{
			Writing();
			sections_modified = value;
		}
	}

	protected bool AccessRulesModified
	{
		set
		{
			SetAccessControlSectionsModified(AccessControlSections.Access, value);
		}
	}

	protected bool IsContainer => descriptor.IsContainer;

	protected bool IsDS => descriptor.IsDS;

	protected ObjectSecurity(CommonSecurityDescriptor securityDescriptor)
	{
		if (securityDescriptor == null)
		{
			throw new ArgumentNullException("securityDescriptor");
		}
		descriptor = securityDescriptor;
		rw_lock = new ReaderWriterLock();
	}

	protected ObjectSecurity(bool isContainer, bool isDS)
		: this(new CommonSecurityDescriptor(isContainer, isDS, ControlFlags.None, null, null, null, new DiscretionaryAcl(isContainer, isDS, 0)))
	{
	}

	public IdentityReference GetGroup(Type targetType)
	{
		ReadLock();
		try
		{
			if (descriptor.Group == null)
			{
				return null;
			}
			return descriptor.Group.Translate(targetType);
		}
		finally
		{
			ReadUnlock();
		}
	}

	public IdentityReference GetOwner(Type targetType)
	{
		ReadLock();
		try
		{
			if (descriptor.Owner == null)
			{
				return null;
			}
			return descriptor.Owner.Translate(targetType);
		}
		finally
		{
			ReadUnlock();
		}
	}

	public virtual void PurgeAccessRules(IdentityReference identity)
	{
		if (null == identity)
		{
			throw new ArgumentNullException("identity");
		}
		WriteLock();
		try
		{
			descriptor.PurgeAccessControl(SidFromIR(identity));
		}
		finally
		{
			WriteUnlock();
		}
	}

	public void SetSecurityDescriptorBinaryForm(byte[] binaryForm, AccessControlSections includeSections)
	{
		CopySddlForm(new CommonSecurityDescriptor(IsContainer, IsDS, binaryForm, 0), includeSections);
	}

	private void CopySddlForm(CommonSecurityDescriptor sourceDescriptor, AccessControlSections includeSections)
	{
		WriteLock();
		try
		{
			AccessControlSectionsModified |= includeSections;
			if ((includeSections & AccessControlSections.Audit) != AccessControlSections.None)
			{
				descriptor.SystemAcl = sourceDescriptor.SystemAcl;
			}
			if ((includeSections & AccessControlSections.Access) != AccessControlSections.None)
			{
				descriptor.DiscretionaryAcl = sourceDescriptor.DiscretionaryAcl;
			}
			if ((includeSections & AccessControlSections.Owner) != AccessControlSections.None)
			{
				descriptor.Owner = sourceDescriptor.Owner;
			}
			if ((includeSections & AccessControlSections.Group) != AccessControlSections.None)
			{
				descriptor.Group = sourceDescriptor.Group;
			}
		}
		finally
		{
			WriteUnlock();
		}
	}

	protected abstract bool ModifyAccess(AccessControlModification modification, AccessRule rule, out bool modified);

	private void Reading()
	{
		if (!rw_lock.IsReaderLockHeld && !rw_lock.IsWriterLockHeld)
		{
			throw new InvalidOperationException("Either a read or a write lock must be held.");
		}
	}

	protected void ReadLock()
	{
		rw_lock.AcquireReaderLock(-1);
	}

	protected void ReadUnlock()
	{
		rw_lock.ReleaseReaderLock();
	}

	private void Writing()
	{
		if (!rw_lock.IsWriterLockHeld)
		{
			throw new InvalidOperationException("Write lock must be held.");
		}
	}

	protected void WriteLock()
	{
		rw_lock.AcquireWriterLock(-1);
	}

	protected void WriteUnlock()
	{
		rw_lock.ReleaseWriterLock();
	}

	internal static SecurityIdentifier SidFromIR(IdentityReference identity)
	{
		if (null == identity)
		{
			throw new ArgumentNullException("identity");
		}
		return (SecurityIdentifier)identity.Translate(typeof(SecurityIdentifier));
	}

	private void SetAccessControlSectionsModified(AccessControlSections mask, bool modified)
	{
		if (modified)
		{
			AccessControlSectionsModified |= mask;
		}
		else
		{
			AccessControlSectionsModified &= ~mask;
		}
	}
}
