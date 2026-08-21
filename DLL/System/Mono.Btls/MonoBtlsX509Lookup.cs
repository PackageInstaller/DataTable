using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace Mono.Btls;

internal class MonoBtlsX509Lookup : MonoBtlsObject
{
	internal class BoringX509LookupHandle : MonoBtlsHandle
	{
		public BoringX509LookupHandle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			mono_btls_x509_lookup_free(handle);
			return true;
		}
	}

	private MonoBtlsX509Store store;

	private MonoBtlsX509LookupType type;

	private List<MonoBtlsX509LookupMono> monoLookups;

	internal new BoringX509LookupHandle Handle => (BoringX509LookupHandle)base.Handle;

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_lookup_new(IntPtr store, MonoBtlsX509LookupType type);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_lookup_add_dir(IntPtr handle, IntPtr dir, MonoBtlsX509FileType type);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_lookup_add_mono(IntPtr handle, IntPtr monoLookup);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_x509_lookup_free(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_lookup_peek_lookup(IntPtr handle);

	private static BoringX509LookupHandle Create_internal(MonoBtlsX509Store store, MonoBtlsX509LookupType type)
	{
		IntPtr intPtr = mono_btls_x509_lookup_new(store.Handle.DangerousGetHandle(), type);
		if (intPtr == IntPtr.Zero)
		{
			throw new MonoBtlsException();
		}
		return new BoringX509LookupHandle(intPtr);
	}

	internal MonoBtlsX509Lookup(MonoBtlsX509Store store, MonoBtlsX509LookupType type)
		: base(Create_internal(store, type))
	{
		this.store = store;
		this.type = type;
	}

	internal IntPtr GetNativeLookup()
	{
		return mono_btls_x509_lookup_peek_lookup(Handle.DangerousGetHandle());
	}

	public void AddDirectory(string dir, MonoBtlsX509FileType type)
	{
		IntPtr intPtr = IntPtr.Zero;
		try
		{
			if (dir != null)
			{
				intPtr = Marshal.StringToHGlobalAnsi(dir);
			}
			int ret = mono_btls_x509_lookup_add_dir(Handle.DangerousGetHandle(), intPtr, type);
			CheckError(ret, "AddDirectory");
		}
		finally
		{
			if (intPtr != IntPtr.Zero)
			{
				Marshal.FreeHGlobal(intPtr);
			}
		}
	}

	internal void AddMono(MonoBtlsX509LookupMono monoLookup)
	{
		if (type != MonoBtlsX509LookupType.MONO)
		{
			throw new NotSupportedException();
		}
		int ret = mono_btls_x509_lookup_add_mono(Handle.DangerousGetHandle(), monoLookup.Handle.DangerousGetHandle());
		CheckError(ret, "AddMono");
		monoLookup.Install(this);
		if (monoLookups == null)
		{
			monoLookups = new List<MonoBtlsX509LookupMono>();
		}
		monoLookups.Add(monoLookup);
	}

	internal void AddCertificate(MonoBtlsX509 certificate)
	{
		store.AddCertificate(certificate);
	}

	protected override void Close()
	{
		try
		{
			if (monoLookups == null)
			{
				return;
			}
			foreach (MonoBtlsX509LookupMono monoLookup in monoLookups)
			{
				monoLookup.Dispose();
			}
			monoLookups = null;
		}
		finally
		{
			base.Close();
		}
	}
}
