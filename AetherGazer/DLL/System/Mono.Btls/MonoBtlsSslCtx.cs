using System;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using Mono.Util;

namespace Mono.Btls;

internal class MonoBtlsSslCtx : MonoBtlsObject
{
	internal class BoringSslCtxHandle : MonoBtlsHandle
	{
		public BoringSslCtxHandle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			mono_btls_ssl_ctx_free(handle);
			return true;
		}
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate int NativeVerifyFunc(IntPtr instance, int preverify_ok, IntPtr ctx);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate int NativeSelectFunc(IntPtr instance, int count, IntPtr sizes, IntPtr data);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate int NativeServerNameFunc(IntPtr instance);

	private NativeVerifyFunc verifyFunc;

	private NativeSelectFunc selectFunc;

	private NativeServerNameFunc serverNameFunc;

	private IntPtr verifyFuncPtr;

	private IntPtr selectFuncPtr;

	private IntPtr serverNameFuncPtr;

	private MonoBtlsVerifyCallback verifyCallback;

	private MonoBtlsSelectCallback selectCallback;

	private MonoBtlsServerNameCallback serverNameCallback;

	private MonoBtlsX509Store store;

	private GCHandle instance;

	private IntPtr instancePtr;

	internal new BoringSslCtxHandle Handle => (BoringSslCtxHandle)base.Handle;

	public MonoBtlsX509Store CertificateStore => store;

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_ssl_ctx_new();

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_ctx_free(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_ctx_initialize(IntPtr handle, IntPtr instance);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_ctx_set_cert_verify_callback(IntPtr handle, IntPtr func, int cert_required);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_ctx_set_cert_select_callback(IntPtr handle, IntPtr func);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_ctx_set_min_version(IntPtr handle, int version);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_ctx_set_max_version(IntPtr handle, int version);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_ctx_set_ciphers(IntPtr handle, int count, IntPtr data, int allow_unsupported);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_ctx_set_verify_param(IntPtr handle, IntPtr param);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_ssl_ctx_set_client_ca_list(IntPtr handle, int count, IntPtr sizes, IntPtr data);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_ssl_ctx_set_server_name_callback(IntPtr handle, IntPtr func);

	public MonoBtlsSslCtx()
		: this(new BoringSslCtxHandle(mono_btls_ssl_ctx_new()))
	{
	}

	internal MonoBtlsSslCtx(BoringSslCtxHandle handle)
		: base(handle)
	{
		instance = GCHandle.Alloc(this);
		instancePtr = GCHandle.ToIntPtr(instance);
		mono_btls_ssl_ctx_initialize(handle.DangerousGetHandle(), instancePtr);
		verifyFunc = NativeVerifyCallback;
		selectFunc = NativeSelectCallback;
		serverNameFunc = NativeServerNameCallback;
		verifyFuncPtr = Marshal.GetFunctionPointerForDelegate(verifyFunc);
		selectFuncPtr = Marshal.GetFunctionPointerForDelegate(selectFunc);
		serverNameFuncPtr = Marshal.GetFunctionPointerForDelegate(serverNameFunc);
		store = new MonoBtlsX509Store(Handle);
	}

	private int VerifyCallback(bool preverify_ok, MonoBtlsX509StoreCtx ctx)
	{
		if (verifyCallback != null)
		{
			return verifyCallback(ctx);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(NativeVerifyFunc))]
	private static int NativeVerifyCallback(IntPtr instance, int preverify_ok, IntPtr store_ctx)
	{
		MonoBtlsSslCtx monoBtlsSslCtx = (MonoBtlsSslCtx)GCHandle.FromIntPtr(instance).Target;
		using (MonoBtlsX509StoreCtx ctx = new MonoBtlsX509StoreCtx(preverify_ok, store_ctx))
		{
			try
			{
				return monoBtlsSslCtx.VerifyCallback(preverify_ok != 0, ctx);
			}
			catch (Exception exception)
			{
				monoBtlsSslCtx.SetException(exception);
			}
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(NativeSelectFunc))]
	private static int NativeSelectCallback(IntPtr instance, int count, IntPtr sizes, IntPtr data)
	{
		MonoBtlsSslCtx monoBtlsSslCtx = (MonoBtlsSslCtx)GCHandle.FromIntPtr(instance).Target;
		try
		{
			string[] acceptableIssuers = CopyIssuers(count, sizes, data);
			if (monoBtlsSslCtx.selectCallback != null)
			{
				return monoBtlsSslCtx.selectCallback(acceptableIssuers);
			}
			return 1;
		}
		catch (Exception exception)
		{
			monoBtlsSslCtx.SetException(exception);
			return 0;
		}
	}

	private static string[] CopyIssuers(int count, IntPtr sizesPtr, IntPtr dataPtr)
	{
		if (count == 0 || sizesPtr == IntPtr.Zero || dataPtr == IntPtr.Zero)
		{
			return null;
		}
		int[] array = new int[count];
		Marshal.Copy(sizesPtr, array, 0, count);
		IntPtr[] array2 = new IntPtr[count];
		Marshal.Copy(dataPtr, array2, 0, count);
		string[] array3 = new string[count];
		for (int i = 0; i < count; i++)
		{
			byte[] array4 = new byte[array[i]];
			Marshal.Copy(array2[i], array4, 0, array4.Length);
			using MonoBtlsX509Name name = MonoBtlsX509Name.CreateFromData(array4, use_canon_enc: false);
			array3[i] = MonoBtlsUtils.FormatName(name, reversed: true, ", ", quotes: true);
		}
		return array3;
	}

	public void SetVerifyCallback(MonoBtlsVerifyCallback callback, bool client_cert_required)
	{
		CheckThrow();
		verifyCallback = callback;
		mono_btls_ssl_ctx_set_cert_verify_callback(Handle.DangerousGetHandle(), verifyFuncPtr, client_cert_required ? 1 : 0);
	}

	public void SetSelectCallback(MonoBtlsSelectCallback callback)
	{
		CheckThrow();
		selectCallback = callback;
		mono_btls_ssl_ctx_set_cert_select_callback(Handle.DangerousGetHandle(), selectFuncPtr);
	}

	public void SetMinVersion(int version)
	{
		CheckThrow();
		mono_btls_ssl_ctx_set_min_version(Handle.DangerousGetHandle(), version);
	}

	public void SetMaxVersion(int version)
	{
		CheckThrow();
		mono_btls_ssl_ctx_set_max_version(Handle.DangerousGetHandle(), version);
	}

	public void SetCiphers(short[] ciphers, bool allow_unsupported)
	{
		CheckThrow();
		IntPtr intPtr = Marshal.AllocHGlobal(ciphers.Length * 2);
		try
		{
			Marshal.Copy(ciphers, 0, intPtr, ciphers.Length);
			int num = mono_btls_ssl_ctx_set_ciphers(Handle.DangerousGetHandle(), ciphers.Length, intPtr, allow_unsupported ? 1 : 0);
			CheckError(num > 0, "SetCiphers");
		}
		finally
		{
			Marshal.FreeHGlobal(intPtr);
		}
	}

	public void SetVerifyParam(MonoBtlsX509VerifyParam param)
	{
		CheckThrow();
		int ret = mono_btls_ssl_ctx_set_verify_param(Handle.DangerousGetHandle(), param.Handle.DangerousGetHandle());
		CheckError(ret, "SetVerifyParam");
	}

	public void SetClientCertificateIssuers(string[] acceptableIssuers)
	{
		CheckThrow();
		if (acceptableIssuers == null || acceptableIssuers.Length == 0)
		{
			return;
		}
		int num = acceptableIssuers.Length;
		_ = new byte[num][];
		int[] array = new int[num];
		IntPtr[] array2 = new IntPtr[num];
		IntPtr intPtr = IntPtr.Zero;
		IntPtr intPtr2 = IntPtr.Zero;
		try
		{
			for (int i = 0; i < num; i++)
			{
				byte[] rawData = new X500DistinguishedName(acceptableIssuers[i]).RawData;
				array[i] = rawData.Length;
				array2[i] = Marshal.AllocHGlobal(rawData.Length);
				Marshal.Copy(rawData, 0, array2[i], rawData.Length);
			}
			intPtr = Marshal.AllocHGlobal(num * 4);
			Marshal.Copy(array, 0, intPtr, num);
			intPtr2 = Marshal.AllocHGlobal(num * 8);
			Marshal.Copy(array2, 0, intPtr2, num);
			int ret = mono_btls_ssl_ctx_set_client_ca_list(Handle.DangerousGetHandle(), num, intPtr, intPtr2);
			CheckError(ret, "SetClientCertificateIssuers");
		}
		finally
		{
			for (int j = 0; j < num; j++)
			{
				if (array2[j] != IntPtr.Zero)
				{
					Marshal.FreeHGlobal(array2[j]);
				}
			}
			if (intPtr != IntPtr.Zero)
			{
				Marshal.FreeHGlobal(intPtr);
			}
			if (intPtr2 != IntPtr.Zero)
			{
				Marshal.FreeHGlobal(intPtr2);
			}
		}
	}

	public void SetServerNameCallback(MonoBtlsServerNameCallback callback)
	{
		CheckThrow();
		serverNameCallback = callback;
		mono_btls_ssl_ctx_set_server_name_callback(Handle.DangerousGetHandle(), serverNameFuncPtr);
	}

	[MonoPInvokeCallback(typeof(NativeServerNameFunc))]
	private static int NativeServerNameCallback(IntPtr instance)
	{
		MonoBtlsSslCtx monoBtlsSslCtx = (MonoBtlsSslCtx)GCHandle.FromIntPtr(instance).Target;
		try
		{
			return monoBtlsSslCtx.serverNameCallback();
		}
		catch (Exception exception)
		{
			monoBtlsSslCtx.SetException(exception);
			return 0;
		}
	}

	protected override void Close()
	{
		if (store != null)
		{
			store.Dispose();
			store = null;
		}
		if (instance.IsAllocated)
		{
			instance.Free();
		}
		base.Close();
	}
}
