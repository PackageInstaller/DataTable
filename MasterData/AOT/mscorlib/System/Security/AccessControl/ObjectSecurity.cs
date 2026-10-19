using System.Threading;

namespace System.Security.AccessControl;

public abstract class ObjectSecurity
{
	internal CommonSecurityDescriptor descriptor;

	private AccessControlSections sections_modified;

	private ReaderWriterLock rw_lock;

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

	private void Reading()
	{
		if (!rw_lock.IsReaderLockHeld && !rw_lock.IsWriterLockHeld)
		{
			throw new InvalidOperationException("Either a read or a write lock must be held.");
		}
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
}
