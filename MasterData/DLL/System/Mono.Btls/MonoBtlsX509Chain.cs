using System;
using System.Runtime.InteropServices;

namespace Mono.Btls;

internal class MonoBtlsX509Chain : MonoBtlsObject
{
	internal class BoringX509ChainHandle : MonoBtlsHandle
	{
		public BoringX509ChainHandle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			mono_btls_x509_chain_free(handle);
			return true;
		}
	}

	internal new BoringX509ChainHandle Handle => (BoringX509ChainHandle)base.Handle;

	public int Count => mono_btls_x509_chain_get_count(Handle.DangerousGetHandle());

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_chain_new();

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_chain_get_count(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_chain_get_cert(IntPtr Handle, int index);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_chain_add_cert(IntPtr chain, IntPtr x509);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_chain_up_ref(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_x509_chain_free(IntPtr handle);

	public MonoBtlsX509Chain()
		: base(new BoringX509ChainHandle(mono_btls_x509_chain_new()))
	{
	}

	internal MonoBtlsX509Chain(BoringX509ChainHandle handle)
		: base(handle)
	{
	}

	public MonoBtlsX509 GetCertificate(int index)
	{
		if (index >= Count)
		{
			throw new IndexOutOfRangeException();
		}
		IntPtr intPtr = mono_btls_x509_chain_get_cert(Handle.DangerousGetHandle(), index);
		CheckError(intPtr != IntPtr.Zero, "GetCertificate");
		return new MonoBtlsX509(new MonoBtlsX509.BoringX509Handle(intPtr));
	}

	public void AddCertificate(MonoBtlsX509 x509)
	{
		mono_btls_x509_chain_add_cert(Handle.DangerousGetHandle(), x509.Handle.DangerousGetHandle());
	}

	internal MonoBtlsX509Chain Copy()
	{
		IntPtr intPtr = mono_btls_x509_chain_up_ref(Handle.DangerousGetHandle());
		CheckError(intPtr != IntPtr.Zero, "Copy");
		return new MonoBtlsX509Chain(new BoringX509ChainHandle(intPtr));
	}
}
