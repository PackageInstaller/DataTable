using System.IO;
using System.Runtime.InteropServices;

namespace System.Security.AccessControl;

public abstract class NativeObjectSecurity : CommonObjectSecurity
{
	protected internal delegate Exception ExceptionFromErrorCode(int errorCode, string name, SafeHandle handle, object context);

	private ExceptionFromErrorCode exception_from_error_code;

	protected NativeObjectSecurity(bool isContainer, ResourceType resourceType, ExceptionFromErrorCode exceptionFromErrorCode, object exceptionContext)
		: base(isContainer)
	{
		exception_from_error_code = exceptionFromErrorCode;
	}

	protected NativeObjectSecurity(bool isContainer, ResourceType resourceType, SafeHandle handle, AccessControlSections includeSections)
		: this(isContainer, resourceType, handle, includeSections, null, null)
	{
	}

	protected NativeObjectSecurity(bool isContainer, ResourceType resourceType, string name, AccessControlSections includeSections)
		: this(isContainer, resourceType, name, includeSections, null, null)
	{
	}

	protected NativeObjectSecurity(bool isContainer, ResourceType resourceType, SafeHandle handle, AccessControlSections includeSections, ExceptionFromErrorCode exceptionFromErrorCode, object exceptionContext)
		: this(isContainer, resourceType, exceptionFromErrorCode, exceptionContext)
	{
		RaiseExceptionOnFailure(InternalGet(handle, includeSections), null, handle, exceptionContext);
		ClearAccessControlSectionsModified();
	}

	protected NativeObjectSecurity(bool isContainer, ResourceType resourceType, string name, AccessControlSections includeSections, ExceptionFromErrorCode exceptionFromErrorCode, object exceptionContext)
		: this(isContainer, resourceType, exceptionFromErrorCode, exceptionContext)
	{
		RaiseExceptionOnFailure(InternalGet(name, includeSections), name, null, exceptionContext);
		ClearAccessControlSectionsModified();
	}

	private void ClearAccessControlSectionsModified()
	{
		WriteLock();
		try
		{
			base.AccessControlSectionsModified = AccessControlSections.None;
		}
		finally
		{
			WriteUnlock();
		}
	}

	internal void PersistModifications(SafeHandle handle)
	{
		WriteLock();
		try
		{
			Persist(handle, base.AccessControlSectionsModified, null);
		}
		finally
		{
			WriteUnlock();
		}
	}

	protected void Persist(SafeHandle handle, AccessControlSections includeSections, object exceptionContext)
	{
		WriteLock();
		try
		{
			RaiseExceptionOnFailure(InternalSet(handle, includeSections), null, handle, exceptionContext);
			base.AccessControlSectionsModified &= ~includeSections;
		}
		finally
		{
			WriteUnlock();
		}
	}

	internal void PersistModifications(string name)
	{
		WriteLock();
		try
		{
			Persist(name, base.AccessControlSectionsModified, null);
		}
		finally
		{
			WriteUnlock();
		}
	}

	protected void Persist(string name, AccessControlSections includeSections, object exceptionContext)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		WriteLock();
		try
		{
			RaiseExceptionOnFailure(InternalSet(name, includeSections), name, null, exceptionContext);
			base.AccessControlSectionsModified &= ~includeSections;
		}
		finally
		{
			WriteUnlock();
		}
	}

	internal static Exception DefaultExceptionFromErrorCode(int errorCode, string name, SafeHandle handle, object context)
	{
		return errorCode switch
		{
			2 => new FileNotFoundException(), 
			3 => new DirectoryNotFoundException(), 
			5 => new UnauthorizedAccessException(), 
			1314 => new PrivilegeNotHeldException(), 
			_ => new InvalidOperationException("OS error code " + errorCode), 
		};
	}

	private void RaiseExceptionOnFailure(int errorCode, string name, SafeHandle handle, object context)
	{
		if (errorCode == 0)
		{
			return;
		}
		throw (exception_from_error_code ?? new ExceptionFromErrorCode(DefaultExceptionFromErrorCode))(errorCode, name, handle, context);
	}

	internal virtual int InternalGet(SafeHandle handle, AccessControlSections includeSections)
	{
		throw new PlatformNotSupportedException();
	}

	internal virtual int InternalGet(string name, AccessControlSections includeSections)
	{
		throw new PlatformNotSupportedException();
	}

	internal virtual int InternalSet(SafeHandle handle, AccessControlSections includeSections)
	{
		throw new PlatformNotSupportedException();
	}

	internal virtual int InternalSet(string name, AccessControlSections includeSections)
	{
		throw new PlatformNotSupportedException();
	}
}
