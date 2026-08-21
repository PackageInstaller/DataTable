using System;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using Mono.Security.Cryptography;

namespace Mono.Btls;

internal class MonoBtlsKey : MonoBtlsObject
{
	internal class BoringKeyHandle : MonoBtlsHandle
	{
		internal BoringKeyHandle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			mono_btls_key_free(handle);
			return true;
		}
	}

	internal new BoringKeyHandle Handle => (BoringKeyHandle)base.Handle;

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_key_new();

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_key_free(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_key_up_ref(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_key_get_bytes(IntPtr handle, out IntPtr data, out int size, int include_private_bits);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_key_assign_rsa_private_key(IntPtr handle, byte[] der, int der_length);

	internal MonoBtlsKey(BoringKeyHandle handle)
		: base(handle)
	{
	}

	public byte[] GetBytes(bool include_private_bits)
	{
		int ret = mono_btls_key_get_bytes(Handle.DangerousGetHandle(), out var data, out var size, include_private_bits ? 1 : 0);
		CheckError(ret, "GetBytes");
		byte[] array = new byte[size];
		Marshal.Copy(data, array, 0, size);
		FreeDataPtr(data);
		return array;
	}

	public MonoBtlsKey Copy()
	{
		CheckThrow();
		IntPtr intPtr = mono_btls_key_up_ref(Handle.DangerousGetHandle());
		CheckError(intPtr != IntPtr.Zero, "Copy");
		return new MonoBtlsKey(new BoringKeyHandle(intPtr));
	}

	public static MonoBtlsKey CreateFromRSAPrivateKey(RSA privateKey)
	{
		byte[] array = PKCS8.PrivateKeyInfo.Encode(privateKey);
		MonoBtlsKey monoBtlsKey = new MonoBtlsKey(new BoringKeyHandle(mono_btls_key_new()));
		if (mono_btls_key_assign_rsa_private_key(monoBtlsKey.Handle.DangerousGetHandle(), array, array.Length) == 0)
		{
			throw new MonoBtlsException("Assigning private key failed.");
		}
		return monoBtlsKey;
	}
}
