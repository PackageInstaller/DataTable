using System.IO;
using System.Runtime.InteropServices;
using System.Security.Principal;

namespace System.Security.AccessControl;

public abstract class NativeObjectSecurity : CommonObjectSecurity
{
	protected internal delegate Exception ExceptionFromErrorCode(int errorCode, string name, SafeHandle handle, object context);

	private delegate int GetSecurityInfoNativeCall(SecurityInfos securityInfos, out IntPtr owner, out IntPtr group, out IntPtr dacl, out IntPtr sacl, out IntPtr descriptor);

	private delegate int SetSecurityInfoNativeCall(SecurityInfos securityInfos, byte[] owner, byte[] group, byte[] dacl, byte[] sacl);

	private ExceptionFromErrorCode exception_from_error_code;

	private ResourceType resource_type;

	internal ResourceType ResourceType => resource_type;

	protected NativeObjectSecurity(bool isContainer, ResourceType resourceType)
		: this(isContainer, resourceType, null, null)
	{
	}

	protected NativeObjectSecurity(bool isContainer, ResourceType resourceType, ExceptionFromErrorCode exceptionFromErrorCode, object exceptionContext)
		: base(isContainer)
	{
		exception_from_error_code = exceptionFromErrorCode;
		resource_type = resourceType;
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
		if (Environment.OSVersion.Platform != PlatformID.Win32NT)
		{
			throw new PlatformNotSupportedException();
		}
		return Win32GetHelper(delegate(SecurityInfos securityInfos, out IntPtr owner, out IntPtr group, out IntPtr dacl, out IntPtr sacl, out IntPtr descriptor)
		{
			return GetSecurityInfo(handle, ResourceType, securityInfos, out owner, out group, out dacl, out sacl, out descriptor);
		}, includeSections);
	}

	internal virtual int InternalGet(string name, AccessControlSections includeSections)
	{
		if (Environment.OSVersion.Platform != PlatformID.Win32NT)
		{
			throw new PlatformNotSupportedException();
		}
		return Win32GetHelper(delegate(SecurityInfos securityInfos, out IntPtr owner, out IntPtr group, out IntPtr dacl, out IntPtr sacl, out IntPtr descriptor)
		{
			return GetNamedSecurityInfo(Win32FixName(name), ResourceType, securityInfos, out owner, out group, out dacl, out sacl, out descriptor);
		}, includeSections);
	}

	internal virtual int InternalSet(SafeHandle handle, AccessControlSections includeSections)
	{
		if (Environment.OSVersion.Platform != PlatformID.Win32NT)
		{
			throw new PlatformNotSupportedException();
		}
		return Win32SetHelper((SecurityInfos securityInfos, byte[] owner, byte[] group, byte[] dacl, byte[] sacl) => SetSecurityInfo(handle, ResourceType, securityInfos, owner, group, dacl, sacl), includeSections);
	}

	internal virtual int InternalSet(string name, AccessControlSections includeSections)
	{
		if (Environment.OSVersion.Platform != PlatformID.Win32NT)
		{
			throw new PlatformNotSupportedException();
		}
		return Win32SetHelper((SecurityInfos securityInfos, byte[] owner, byte[] group, byte[] dacl, byte[] sacl) => SetNamedSecurityInfo(Win32FixName(name), ResourceType, securityInfos, owner, group, dacl, sacl), includeSections);
	}

	private int Win32GetHelper(GetSecurityInfoNativeCall nativeCall, AccessControlSections includeSections)
	{
		bool num = (includeSections & AccessControlSections.Owner) != 0;
		bool flag = (includeSections & AccessControlSections.Group) != 0;
		bool flag2 = (includeSections & AccessControlSections.Access) != 0;
		bool flag3 = (includeSections & AccessControlSections.Audit) != 0;
		SecurityInfos securityInfos = (SecurityInfos)0;
		if (num)
		{
			securityInfos |= SecurityInfos.Owner;
		}
		if (flag)
		{
			securityInfos |= SecurityInfos.Group;
		}
		if (flag2)
		{
			securityInfos |= SecurityInfos.DiscretionaryAcl;
		}
		if (flag3)
		{
			securityInfos |= SecurityInfos.SystemAcl;
		}
		int num2 = nativeCall(securityInfos, out var _, out var _, out var _, out var _, out var intPtr);
		if (num2 != 0)
		{
			return num2;
		}
		try
		{
			int num3 = 0;
			if (IsValidSecurityDescriptor(intPtr))
			{
				num3 = GetSecurityDescriptorLength(intPtr);
			}
			byte[] array = new byte[num3];
			Marshal.Copy(intPtr, array, 0, num3);
			SetSecurityDescriptorBinaryForm(array, includeSections);
		}
		finally
		{
			LocalFree(intPtr);
		}
		return 0;
	}

	private int Win32SetHelper(SetSecurityInfoNativeCall nativeCall, AccessControlSections includeSections)
	{
		if (includeSections == AccessControlSections.None)
		{
			return 0;
		}
		SecurityInfos securityInfos = (SecurityInfos)0;
		byte[] array = null;
		byte[] array2 = null;
		byte[] array3 = null;
		byte[] array4 = null;
		if ((includeSections & AccessControlSections.Owner) != AccessControlSections.None)
		{
			securityInfos |= SecurityInfos.Owner;
			SecurityIdentifier securityIdentifier = (SecurityIdentifier)GetOwner(typeof(SecurityIdentifier));
			if (null != securityIdentifier)
			{
				array = new byte[securityIdentifier.BinaryLength];
				securityIdentifier.GetBinaryForm(array, 0);
			}
		}
		if ((includeSections & AccessControlSections.Group) != AccessControlSections.None)
		{
			securityInfos |= SecurityInfos.Group;
			SecurityIdentifier securityIdentifier2 = (SecurityIdentifier)GetGroup(typeof(SecurityIdentifier));
			if (null != securityIdentifier2)
			{
				array2 = new byte[securityIdentifier2.BinaryLength];
				securityIdentifier2.GetBinaryForm(array2, 0);
			}
		}
		if ((includeSections & AccessControlSections.Access) != AccessControlSections.None)
		{
			securityInfos |= SecurityInfos.DiscretionaryAcl;
			securityInfos = ((!base.AreAccessRulesProtected) ? (securityInfos | (SecurityInfos)0x20000000) : (securityInfos | (SecurityInfos)int.MinValue));
			array3 = new byte[descriptor.DiscretionaryAcl.BinaryLength];
			descriptor.DiscretionaryAcl.GetBinaryForm(array3, 0);
		}
		if ((includeSections & AccessControlSections.Audit) != AccessControlSections.None && descriptor.SystemAcl != null)
		{
			securityInfos |= SecurityInfos.SystemAcl;
			securityInfos = ((!base.AreAuditRulesProtected) ? (securityInfos | (SecurityInfos)0x10000000) : (securityInfos | (SecurityInfos)0x40000000));
			array4 = new byte[descriptor.SystemAcl.BinaryLength];
			descriptor.SystemAcl.GetBinaryForm(array4, 0);
		}
		return nativeCall(securityInfos, array, array2, array3, array4);
	}

	private string Win32FixName(string name)
	{
		if (ResourceType == ResourceType.RegistryKey)
		{
			if (!name.StartsWith("HKEY_"))
			{
				throw new InvalidOperationException();
			}
			name = name.Substring("HKEY_".Length);
		}
		return name;
	}

	[DllImport("advapi32.dll", CharSet = CharSet.Unicode)]
	private static extern int GetSecurityInfo(SafeHandle handle, ResourceType resourceType, SecurityInfos securityInfos, out IntPtr owner, out IntPtr group, out IntPtr dacl, out IntPtr sacl, out IntPtr descriptor);

	[DllImport("advapi32.dll", CharSet = CharSet.Unicode)]
	private static extern int GetNamedSecurityInfo(string name, ResourceType resourceType, SecurityInfos securityInfos, out IntPtr owner, out IntPtr group, out IntPtr dacl, out IntPtr sacl, out IntPtr descriptor);

	[DllImport("kernel32.dll")]
	private static extern IntPtr LocalFree(IntPtr handle);

	[DllImport("advapi32.dll", CharSet = CharSet.Unicode)]
	private static extern int SetSecurityInfo(SafeHandle handle, ResourceType resourceType, SecurityInfos securityInfos, byte[] owner, byte[] group, byte[] dacl, byte[] sacl);

	[DllImport("advapi32.dll", CharSet = CharSet.Unicode)]
	private static extern int SetNamedSecurityInfo(string name, ResourceType resourceType, SecurityInfos securityInfos, byte[] owner, byte[] group, byte[] dacl, byte[] sacl);

	[DllImport("advapi32.dll", CharSet = CharSet.Unicode)]
	private static extern int GetSecurityDescriptorLength(IntPtr descriptor);

	[DllImport("advapi32.dll", CharSet = CharSet.Unicode)]
	[return: MarshalAs(UnmanagedType.Bool)]
	private static extern bool IsValidSecurityDescriptor(IntPtr descriptor);
}
