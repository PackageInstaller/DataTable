using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;

namespace Mono.Btls;

internal class MonoBtlsX509Store : MonoBtlsObject
{
	internal class BoringX509StoreHandle : MonoBtlsHandle
	{
		public BoringX509StoreHandle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			mono_btls_x509_store_free(handle);
			return true;
		}
	}

	private Dictionary<IntPtr, MonoBtlsX509Lookup> lookupHash;

	internal new BoringX509StoreHandle Handle => (BoringX509StoreHandle)base.Handle;

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_store_new();

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_store_from_ssl_ctx(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_store_add_cert(IntPtr handle, IntPtr x509);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_x509_store_free(IntPtr handle);

	private static BoringX509StoreHandle Create_internal()
	{
		IntPtr intPtr = mono_btls_x509_store_new();
		if (intPtr == IntPtr.Zero)
		{
			throw new MonoBtlsException();
		}
		return new BoringX509StoreHandle(intPtr);
	}

	private static BoringX509StoreHandle Create_internal(MonoBtlsSslCtx.BoringSslCtxHandle ctx)
	{
		IntPtr intPtr = mono_btls_x509_store_from_ssl_ctx(ctx.DangerousGetHandle());
		if (intPtr == IntPtr.Zero)
		{
			throw new MonoBtlsException();
		}
		return new BoringX509StoreHandle(intPtr);
	}

	internal MonoBtlsX509Store()
		: base(Create_internal())
	{
	}

	internal MonoBtlsX509Store(MonoBtlsSslCtx.BoringSslCtxHandle ctx)
		: base(Create_internal(ctx))
	{
	}

	public void AddCertificate(MonoBtlsX509 x509)
	{
		int ret = mono_btls_x509_store_add_cert(Handle.DangerousGetHandle(), x509.Handle.DangerousGetHandle());
		CheckError(ret, "AddCertificate");
	}

	public MonoBtlsX509Lookup AddLookup(MonoBtlsX509LookupType type)
	{
		if (lookupHash == null)
		{
			lookupHash = new Dictionary<IntPtr, MonoBtlsX509Lookup>();
		}
		MonoBtlsX509Lookup monoBtlsX509Lookup = new MonoBtlsX509Lookup(this, type);
		IntPtr nativeLookup = monoBtlsX509Lookup.GetNativeLookup();
		if (lookupHash.ContainsKey(nativeLookup))
		{
			monoBtlsX509Lookup.Dispose();
			monoBtlsX509Lookup = lookupHash[nativeLookup];
		}
		else
		{
			lookupHash.Add(nativeLookup, monoBtlsX509Lookup);
		}
		return monoBtlsX509Lookup;
	}

	public void AddDirectoryLookup(string dir, MonoBtlsX509FileType type)
	{
		AddLookup(MonoBtlsX509LookupType.HASH_DIR).AddDirectory(dir, type);
	}

	public void AddCollection(X509CertificateCollection collection, MonoBtlsX509TrustKind trust)
	{
		MonoBtlsX509LookupMonoCollection monoLookup = new MonoBtlsX509LookupMonoCollection(collection, trust);
		new MonoBtlsX509Lookup(this, MonoBtlsX509LookupType.MONO).AddMono(monoLookup);
	}

	protected override void Close()
	{
		try
		{
			if (lookupHash == null)
			{
				return;
			}
			foreach (MonoBtlsX509Lookup value in lookupHash.Values)
			{
				value.Dispose();
			}
			lookupHash = null;
		}
		finally
		{
			base.Close();
		}
	}
}
