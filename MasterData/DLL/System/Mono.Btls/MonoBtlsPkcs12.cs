using System;
using System.Runtime.InteropServices;
using Microsoft.Win32.SafeHandles;

namespace Mono.Btls;

internal class MonoBtlsPkcs12 : MonoBtlsObject
{
	internal class BoringPkcs12Handle : MonoBtlsHandle
	{
		public BoringPkcs12Handle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			mono_btls_pkcs12_free(handle);
			return true;
		}
	}

	private MonoBtlsKey privateKey;

	internal new BoringPkcs12Handle Handle => (BoringPkcs12Handle)base.Handle;

	public int Count => mono_btls_pkcs12_get_count(Handle.DangerousGetHandle());

	public bool HasPrivateKey => mono_btls_pkcs12_has_private_key(Handle.DangerousGetHandle()) != 0;

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_pkcs12_free(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_pkcs12_new();

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_pkcs12_get_count(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_pkcs12_get_cert(IntPtr Handle, int index);

	[DllImport("libmono-btls-shared")]
	private unsafe static extern int mono_btls_pkcs12_import(IntPtr chain, void* data, int len, SafePasswordHandle password);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_pkcs12_has_private_key(IntPtr pkcs12);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_pkcs12_get_private_key(IntPtr pkcs12);

	internal MonoBtlsPkcs12()
		: base(new BoringPkcs12Handle(mono_btls_pkcs12_new()))
	{
	}

	public MonoBtlsX509 GetCertificate(int index)
	{
		if (index >= Count)
		{
			throw new IndexOutOfRangeException();
		}
		IntPtr intPtr = mono_btls_pkcs12_get_cert(Handle.DangerousGetHandle(), index);
		CheckError(intPtr != IntPtr.Zero, "GetCertificate");
		return new MonoBtlsX509(new MonoBtlsX509.BoringX509Handle(intPtr));
	}

	public unsafe void Import(byte[] buffer, SafePasswordHandle password)
	{
		fixed (byte* ptr = buffer)
		{
			void* data = ptr;
			int ret = mono_btls_pkcs12_import(Handle.DangerousGetHandle(), data, buffer.Length, password);
			CheckError(ret, "Import");
		}
	}

	public MonoBtlsKey GetPrivateKey()
	{
		if (!HasPrivateKey)
		{
			throw new InvalidOperationException();
		}
		if (privateKey == null)
		{
			IntPtr intPtr = mono_btls_pkcs12_get_private_key(Handle.DangerousGetHandle());
			CheckError(intPtr != IntPtr.Zero, "GetPrivateKey");
			privateKey = new MonoBtlsKey(new MonoBtlsKey.BoringKeyHandle(intPtr));
		}
		return privateKey;
	}
}
