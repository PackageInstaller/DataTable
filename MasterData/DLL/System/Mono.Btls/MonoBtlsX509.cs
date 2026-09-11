using System;
using System.Runtime.InteropServices;
using System.Threading;

namespace Mono.Btls;

internal class MonoBtlsX509 : MonoBtlsObject
{
	internal class BoringX509Handle : MonoBtlsHandle
	{
		public BoringX509Handle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			if (handle != IntPtr.Zero)
			{
				mono_btls_x509_free(handle);
			}
			return true;
		}

		public IntPtr StealHandle()
		{
			return Interlocked.Exchange(ref handle, IntPtr.Zero);
		}
	}

	internal new BoringX509Handle Handle => (BoringX509Handle)base.Handle;

	internal MonoBtlsX509(BoringX509Handle handle)
		: base(handle)
	{
	}

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_up_ref(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_from_data(IntPtr data, int len, MonoBtlsX509Format format);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_get_subject_name(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_get_raw_data(IntPtr handle, IntPtr bio, MonoBtlsX509Format format);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_cmp(IntPtr a, IntPtr b);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_x509_free(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_add_explicit_trust(IntPtr handle, MonoBtlsX509TrustKind kind);

	internal MonoBtlsX509 Copy()
	{
		IntPtr intPtr = mono_btls_x509_up_ref(Handle.DangerousGetHandle());
		CheckError(intPtr != IntPtr.Zero, "Copy");
		return new MonoBtlsX509(new BoringX509Handle(intPtr));
	}

	public static MonoBtlsX509 LoadFromData(byte[] buffer, MonoBtlsX509Format format)
	{
		IntPtr intPtr = Marshal.AllocHGlobal(buffer.Length);
		if (intPtr == IntPtr.Zero)
		{
			throw new OutOfMemoryException();
		}
		try
		{
			Marshal.Copy(buffer, 0, intPtr, buffer.Length);
			IntPtr intPtr2 = mono_btls_x509_from_data(intPtr, buffer.Length, format);
			if (intPtr2 == IntPtr.Zero)
			{
				throw new MonoBtlsException("Failed to read certificate from data.");
			}
			return new MonoBtlsX509(new BoringX509Handle(intPtr2));
		}
		finally
		{
			Marshal.FreeHGlobal(intPtr);
		}
	}

	public MonoBtlsX509Name GetSubjectName()
	{
		IntPtr intPtr = mono_btls_x509_get_subject_name(Handle.DangerousGetHandle());
		CheckError(intPtr != IntPtr.Zero, "GetSubjectName");
		return new MonoBtlsX509Name(new MonoBtlsX509Name.BoringX509NameHandle(intPtr, ownsHandle: false));
	}

	public long GetSubjectNameHash()
	{
		CheckThrow();
		using MonoBtlsX509Name monoBtlsX509Name = GetSubjectName();
		return monoBtlsX509Name.GetHash();
	}

	public byte[] GetRawData(MonoBtlsX509Format format)
	{
		using MonoBtlsBioMemory monoBtlsBioMemory = new MonoBtlsBioMemory();
		int ret = mono_btls_x509_get_raw_data(Handle.DangerousGetHandle(), monoBtlsBioMemory.Handle.DangerousGetHandle(), format);
		CheckError(ret, "GetRawData");
		return monoBtlsBioMemory.GetData();
	}

	public static int Compare(MonoBtlsX509 a, MonoBtlsX509 b)
	{
		return mono_btls_x509_cmp(a.Handle.DangerousGetHandle(), b.Handle.DangerousGetHandle());
	}

	public void AddExplicitTrust(MonoBtlsX509TrustKind kind)
	{
		CheckThrow();
		int ret = mono_btls_x509_add_explicit_trust(Handle.DangerousGetHandle(), kind);
		CheckError(ret, "AddExplicitTrust");
	}
}
