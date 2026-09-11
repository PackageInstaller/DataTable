using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using Mono.Util;

namespace Mono.Btls;

internal class MonoBtlsSsl : MonoBtlsObject
{
	internal class BoringSslHandle : MonoBtlsHandle
	{
		public BoringSslHandle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			mono_btls_ssl_destroy(handle);
			handle = IntPtr.Zero;
			return true;
		}
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate int PrintErrorsCallbackFunc(IntPtr str, IntPtr len, IntPtr ctx);

	private MonoBtlsBio bio;

	private PrintErrorsCallbackFunc printErrorsFunc;

	private IntPtr printErrorsFuncPtr;

	internal new BoringSslHandle Handle => (BoringSslHandle)base.Handle;

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_destroy(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_ssl_new(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_use_certificate(IntPtr handle, IntPtr x509);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_use_private_key(IntPtr handle, IntPtr key);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_add_chain_certificate(IntPtr handle, IntPtr x509);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_accept(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_connect(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_handshake(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_close(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_shutdown(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_set_quiet_shutdown(IntPtr handle, int mode);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_set_bio(IntPtr handle, IntPtr bio);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_read(IntPtr handle, IntPtr data, int len);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_write(IntPtr handle, IntPtr data, int len);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_get_error(IntPtr handle, int ret_code);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_get_version(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_get_cipher(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_ssl_get_peer_certificate(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_print_errors_cb(IntPtr func, IntPtr ctx);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_set_server_name(IntPtr handle, IntPtr name);

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_ssl_get_server_name(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_set_renegotiate_mode(IntPtr handle, int mode);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_renegotiate_pending(IntPtr handle);

	private static BoringSslHandle Create_internal(MonoBtlsSslCtx ctx)
	{
		IntPtr intPtr = mono_btls_ssl_new(ctx.Handle.DangerousGetHandle());
		if (intPtr == IntPtr.Zero)
		{
			throw new MonoBtlsException();
		}
		return new BoringSslHandle(intPtr);
	}

	public MonoBtlsSsl(MonoBtlsSslCtx ctx)
		: base(Create_internal(ctx))
	{
		printErrorsFunc = PrintErrorsCallback;
		printErrorsFuncPtr = Marshal.GetFunctionPointerForDelegate(printErrorsFunc);
	}

	public void SetBio(MonoBtlsBio bio)
	{
		CheckThrow();
		this.bio = bio;
		mono_btls_ssl_set_bio(Handle.DangerousGetHandle(), bio.Handle.DangerousGetHandle());
	}

	private Exception ThrowError([CallerMemberName] string callerName = null)
	{
		string text;
		try
		{
			if (callerName == null)
			{
				callerName = GetType().Name;
			}
			text = GetErrors();
		}
		catch
		{
			text = null;
		}
		if (text != null)
		{
			throw new MonoBtlsException("{0} failed: {1}.", callerName, text);
		}
		throw new MonoBtlsException("{0} failed.", callerName);
	}

	private MonoBtlsSslError GetError(int ret_code)
	{
		CheckThrow();
		bio.CheckLastError("GetError");
		return (MonoBtlsSslError)mono_btls_ssl_get_error(Handle.DangerousGetHandle(), ret_code);
	}

	public void SetCertificate(MonoBtlsX509 x509)
	{
		CheckThrow();
		if (mono_btls_ssl_use_certificate(Handle.DangerousGetHandle(), x509.Handle.DangerousGetHandle()) <= 0)
		{
			throw ThrowError("SetCertificate");
		}
	}

	public void SetPrivateKey(MonoBtlsKey key)
	{
		CheckThrow();
		if (mono_btls_ssl_use_private_key(Handle.DangerousGetHandle(), key.Handle.DangerousGetHandle()) <= 0)
		{
			throw ThrowError("SetPrivateKey");
		}
	}

	public void AddIntermediateCertificate(MonoBtlsX509 x509)
	{
		CheckThrow();
		if (mono_btls_ssl_add_chain_certificate(Handle.DangerousGetHandle(), x509.Handle.DangerousGetHandle()) <= 0)
		{
			throw ThrowError("AddIntermediateCertificate");
		}
	}

	public MonoBtlsSslError Accept()
	{
		CheckThrow();
		int ret_code = mono_btls_ssl_accept(Handle.DangerousGetHandle());
		return GetError(ret_code);
	}

	public MonoBtlsSslError Connect()
	{
		CheckThrow();
		int ret_code = mono_btls_ssl_connect(Handle.DangerousGetHandle());
		return GetError(ret_code);
	}

	public MonoBtlsSslError Handshake()
	{
		CheckThrow();
		int ret_code = mono_btls_ssl_handshake(Handle.DangerousGetHandle());
		return GetError(ret_code);
	}

	[MonoPInvokeCallback(typeof(PrintErrorsCallbackFunc))]
	private static int PrintErrorsCallback(IntPtr str, IntPtr len, IntPtr ctx)
	{
		StringBuilder stringBuilder = (StringBuilder)GCHandle.FromIntPtr(ctx).Target;
		try
		{
			string value = Marshal.PtrToStringAnsi(str, (int)len);
			stringBuilder.Append(value);
			return 1;
		}
		catch
		{
			return 0;
		}
	}

	public string GetErrors()
	{
		StringBuilder stringBuilder = new StringBuilder();
		GCHandle value = GCHandle.Alloc(stringBuilder);
		try
		{
			mono_btls_ssl_print_errors_cb(printErrorsFuncPtr, GCHandle.ToIntPtr(value));
			return stringBuilder.ToString();
		}
		finally
		{
			if (value.IsAllocated)
			{
				value.Free();
			}
		}
	}

	public void PrintErrors()
	{
		string errors = GetErrors();
		if (!string.IsNullOrEmpty(errors))
		{
			Console.Error.WriteLine(errors);
		}
	}

	public MonoBtlsSslError Read(IntPtr data, ref int dataSize)
	{
		CheckThrow();
		int num = mono_btls_ssl_read(Handle.DangerousGetHandle(), data, dataSize);
		if (num > 0)
		{
			dataSize = num;
			return MonoBtlsSslError.None;
		}
		MonoBtlsSslError error = GetError(num);
		if (num == 0 && error == MonoBtlsSslError.Syscall)
		{
			dataSize = 0;
			return MonoBtlsSslError.None;
		}
		dataSize = 0;
		return error;
	}

	public MonoBtlsSslError Write(IntPtr data, ref int dataSize)
	{
		CheckThrow();
		int num = mono_btls_ssl_write(Handle.DangerousGetHandle(), data, dataSize);
		if (num >= 0)
		{
			dataSize = num;
			return MonoBtlsSslError.None;
		}
		int result = mono_btls_ssl_get_error(Handle.DangerousGetHandle(), num);
		dataSize = 0;
		return (MonoBtlsSslError)result;
	}

	public int GetVersion()
	{
		CheckThrow();
		return mono_btls_ssl_get_version(Handle.DangerousGetHandle());
	}

	public int GetCipher()
	{
		CheckThrow();
		int num = mono_btls_ssl_get_cipher(Handle.DangerousGetHandle());
		CheckError(num > 0, "GetCipher");
		return num;
	}

	public MonoBtlsX509 GetPeerCertificate()
	{
		CheckThrow();
		IntPtr intPtr = mono_btls_ssl_get_peer_certificate(Handle.DangerousGetHandle());
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return new MonoBtlsX509(new MonoBtlsX509.BoringX509Handle(intPtr));
	}

	public void SetServerName(string name)
	{
		CheckThrow();
		IntPtr intPtr = IntPtr.Zero;
		try
		{
			intPtr = Marshal.StringToHGlobalAnsi(name);
			int ret = mono_btls_ssl_set_server_name(Handle.DangerousGetHandle(), intPtr);
			CheckError(ret, "SetServerName");
		}
		finally
		{
			if (intPtr != IntPtr.Zero)
			{
				Marshal.FreeHGlobal(intPtr);
			}
		}
	}

	public string GetServerName()
	{
		CheckThrow();
		IntPtr intPtr = mono_btls_ssl_get_server_name(Handle.DangerousGetHandle());
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return Marshal.PtrToStringAnsi(intPtr);
	}

	public void Shutdown()
	{
		CheckThrow();
		if (mono_btls_ssl_shutdown(Handle.DangerousGetHandle()) < 0)
		{
			throw ThrowError("Shutdown");
		}
	}

	public void SetQuietShutdown()
	{
		CheckThrow();
		mono_btls_ssl_set_quiet_shutdown(Handle.DangerousGetHandle(), 1);
	}

	protected override void Close()
	{
		if (!Handle.IsInvalid)
		{
			mono_btls_ssl_close(Handle.DangerousGetHandle());
		}
	}

	public void SetRenegotiateMode(MonoBtlsSslRenegotiateMode mode)
	{
		CheckThrow();
		mono_btls_ssl_set_renegotiate_mode(Handle.DangerousGetHandle(), (int)mode);
	}

	public bool RenegotiatePending()
	{
		return mono_btls_ssl_renegotiate_pending(Handle.DangerousGetHandle()) != 0;
	}
}
