using System;
using System.Runtime.InteropServices;

namespace Mono.Btls;

internal class MonoBtlsX509VerifyParam : MonoBtlsObject
{
	internal class BoringX509VerifyParamHandle : MonoBtlsHandle
	{
		public BoringX509VerifyParamHandle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			mono_btls_x509_verify_param_free(handle);
			return true;
		}
	}

	internal new BoringX509VerifyParamHandle Handle => (BoringX509VerifyParamHandle)base.Handle;

	public bool CanModify => mono_btls_x509_verify_param_can_modify(Handle.DangerousGetHandle()) != 0;

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_verify_param_copy(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_verify_param_lookup(IntPtr name);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_verify_param_can_modify(IntPtr param);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_verify_param_set_host(IntPtr handle, IntPtr name, int namelen);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_verify_param_set_time(IntPtr handle, long time);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_x509_verify_param_free(IntPtr handle);

	internal MonoBtlsX509VerifyParam(BoringX509VerifyParamHandle handle)
		: base(handle)
	{
	}

	public MonoBtlsX509VerifyParam Copy()
	{
		IntPtr intPtr = mono_btls_x509_verify_param_copy(Handle.DangerousGetHandle());
		CheckError(intPtr != IntPtr.Zero, "Copy");
		return new MonoBtlsX509VerifyParam(new BoringX509VerifyParamHandle(intPtr));
	}

	public static MonoBtlsX509VerifyParam GetSslClient()
	{
		return Lookup("ssl_client", fail: true);
	}

	public static MonoBtlsX509VerifyParam GetSslServer()
	{
		return Lookup("ssl_server", fail: true);
	}

	public static MonoBtlsX509VerifyParam Lookup(string name, bool fail = false)
	{
		IntPtr intPtr = IntPtr.Zero;
		IntPtr zero = IntPtr.Zero;
		try
		{
			intPtr = Marshal.StringToHGlobalAnsi(name);
			zero = mono_btls_x509_verify_param_lookup(intPtr);
			if (zero == IntPtr.Zero)
			{
				if (!fail)
				{
					return null;
				}
				throw new MonoBtlsException("X509_VERIFY_PARAM_lookup() could not find '{0}'.", name);
			}
			return new MonoBtlsX509VerifyParam(new BoringX509VerifyParamHandle(zero));
		}
		finally
		{
			if (intPtr != IntPtr.Zero)
			{
				Marshal.FreeHGlobal(intPtr);
			}
		}
	}

	private void WantToModify()
	{
		if (!CanModify)
		{
			throw new MonoBtlsException("Attempting to modify read-only MonoBtlsX509VerifyParam instance.");
		}
	}

	public void SetHost(string name)
	{
		WantToModify();
		IntPtr intPtr = IntPtr.Zero;
		try
		{
			intPtr = Marshal.StringToHGlobalAnsi(name);
			int ret = mono_btls_x509_verify_param_set_host(Handle.DangerousGetHandle(), intPtr, name.Length);
			CheckError(ret, "SetHost");
		}
		finally
		{
			if (intPtr != IntPtr.Zero)
			{
				Marshal.FreeHGlobal(intPtr);
			}
		}
	}

	public void SetTime(DateTime time)
	{
		WantToModify();
		DateTime value = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
		long time2 = (long)time.Subtract(value).TotalSeconds;
		int ret = mono_btls_x509_verify_param_set_time(Handle.DangerousGetHandle(), time2);
		CheckError(ret, "SetTime");
	}
}
