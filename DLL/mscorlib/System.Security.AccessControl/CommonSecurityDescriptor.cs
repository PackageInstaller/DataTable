using System.Security.Principal;

namespace System.Security.AccessControl;

public sealed class CommonSecurityDescriptor : GenericSecurityDescriptor
{
	private bool is_container;

	private bool is_ds;

	private ControlFlags flags;

	private SecurityIdentifier owner;

	private SecurityIdentifier group;

	private SystemAcl system_acl;

	private DiscretionaryAcl discretionary_acl;

	public override ControlFlags ControlFlags
	{
		get
		{
			ControlFlags controlFlags = flags;
			controlFlags |= ControlFlags.DiscretionaryAclPresent;
			controlFlags |= ControlFlags.SelfRelative;
			if (SystemAcl != null)
			{
				controlFlags |= ControlFlags.SystemAclPresent;
			}
			return controlFlags;
		}
	}

	public DiscretionaryAcl DiscretionaryAcl
	{
		get
		{
			return discretionary_acl;
		}
		set
		{
			if (value == null)
			{
				value = new DiscretionaryAcl(IsContainer, IsDS, 1);
				value.AddAccess(AccessControlType.Allow, new SecurityIdentifier("WD"), -1, IsContainer ? (InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit) : InheritanceFlags.None, PropagationFlags.None);
				value.IsAefa = true;
			}
			CheckAclConsistency(value);
			discretionary_acl = value;
		}
	}

	public override SecurityIdentifier Group
	{
		get
		{
			return group;
		}
		set
		{
			group = value;
		}
	}

	public bool IsContainer => is_container;

	public bool IsDS => is_ds;

	public override SecurityIdentifier Owner
	{
		get
		{
			return owner;
		}
		set
		{
			owner = value;
		}
	}

	public SystemAcl SystemAcl
	{
		get
		{
			return system_acl;
		}
		set
		{
			if (value != null)
			{
				CheckAclConsistency(value);
			}
			system_acl = value;
		}
	}

	public CommonSecurityDescriptor(bool isContainer, bool isDS, byte[] binaryForm, int offset)
	{
		Init(isContainer, isDS, new RawSecurityDescriptor(binaryForm, offset));
	}

	public CommonSecurityDescriptor(bool isContainer, bool isDS, ControlFlags flags, SecurityIdentifier owner, SecurityIdentifier group, SystemAcl systemAcl, DiscretionaryAcl discretionaryAcl)
	{
		Init(isContainer, isDS, flags, owner, group, systemAcl, discretionaryAcl);
	}

	private void Init(bool isContainer, bool isDS, RawSecurityDescriptor rawSecurityDescriptor)
	{
		if (rawSecurityDescriptor == null)
		{
			throw new ArgumentNullException("rawSecurityDescriptor");
		}
		SystemAcl systemAcl = null;
		if (rawSecurityDescriptor.SystemAcl != null)
		{
			systemAcl = new SystemAcl(isContainer, isDS, rawSecurityDescriptor.SystemAcl);
		}
		DiscretionaryAcl discretionaryAcl = null;
		if (rawSecurityDescriptor.DiscretionaryAcl != null)
		{
			discretionaryAcl = new DiscretionaryAcl(isContainer, isDS, rawSecurityDescriptor.DiscretionaryAcl);
		}
		Init(isContainer, isDS, rawSecurityDescriptor.ControlFlags, rawSecurityDescriptor.Owner, rawSecurityDescriptor.Group, systemAcl, discretionaryAcl);
	}

	private void Init(bool isContainer, bool isDS, ControlFlags flags, SecurityIdentifier owner, SecurityIdentifier group, SystemAcl systemAcl, DiscretionaryAcl discretionaryAcl)
	{
		this.flags = flags & ~ControlFlags.SystemAclPresent;
		is_container = isContainer;
		is_ds = isDS;
		Owner = owner;
		Group = group;
		SystemAcl = systemAcl;
		DiscretionaryAcl = discretionaryAcl;
	}

	public void PurgeAccessControl(SecurityIdentifier sid)
	{
		DiscretionaryAcl.Purge(sid);
	}

	private void CheckAclConsistency(CommonAcl acl)
	{
		if (IsContainer != acl.IsContainer)
		{
			throw new ArgumentException("IsContainer must match between descriptor and ACL.");
		}
		if (IsDS != acl.IsDS)
		{
			throw new ArgumentException("IsDS must match between descriptor and ACL.");
		}
	}
}
