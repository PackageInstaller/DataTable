using System;
using System.Runtime.InteropServices;
using Mono.Util;

namespace Mono.Btls;

internal abstract class MonoBtlsX509LookupMono : MonoBtlsObject
{
	internal class BoringX509LookupMonoHandle : MonoBtlsHandle
	{
		public BoringX509LookupMonoHandle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			mono_btls_x509_lookup_mono_free(handle);
			return true;
		}
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate int BySubjectFunc(IntPtr instance, IntPtr name, out IntPtr x509_ptr);

	private GCHandle gch;

	private IntPtr instance;

	private BySubjectFunc bySubjectFunc;

	private IntPtr bySubjectFuncPtr;

	private MonoBtlsX509Lookup lookup;

	internal new BoringX509LookupMonoHandle Handle => (BoringX509LookupMonoHandle)base.Handle;

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_x509_lookup_mono_new();

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_x509_lookup_mono_init(IntPtr handle, IntPtr instance, IntPtr by_subject_func);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_lookup_mono_free(IntPtr handle);

	internal MonoBtlsX509LookupMono()
		: base(new BoringX509LookupMonoHandle(mono_btls_x509_lookup_mono_new()))
	{
		gch = GCHandle.Alloc(this);
		instance = GCHandle.ToIntPtr(gch);
		bySubjectFunc = OnGetBySubject;
		bySubjectFuncPtr = Marshal.GetFunctionPointerForDelegate(bySubjectFunc);
		mono_btls_x509_lookup_mono_init(Handle.DangerousGetHandle(), instance, bySubjectFuncPtr);
	}

	internal void Install(MonoBtlsX509Lookup lookup)
	{
		if (this.lookup != null)
		{
			throw new InvalidOperationException();
		}
		this.lookup = lookup;
	}

	protected void AddCertificate(MonoBtlsX509 certificate)
	{
		lookup.AddCertificate(certificate);
	}

	protected abstract MonoBtlsX509 OnGetBySubject(MonoBtlsX509Name name);

	[MonoPInvokeCallback(typeof(BySubjectFunc))]
	private static int OnGetBySubject(IntPtr instance, IntPtr name_ptr, out IntPtr x509_ptr)
	{
		try
		{
			MonoBtlsX509Name.BoringX509NameHandle boringX509NameHandle = null;
			try
			{
				MonoBtlsX509LookupMono obj = (MonoBtlsX509LookupMono)GCHandle.FromIntPtr(instance).Target;
				boringX509NameHandle = new MonoBtlsX509Name.BoringX509NameHandle(name_ptr, ownsHandle: false);
				MonoBtlsX509Name name = new MonoBtlsX509Name(boringX509NameHandle);
				MonoBtlsX509 monoBtlsX = obj.OnGetBySubject(name);
				if (monoBtlsX != null)
				{
					x509_ptr = monoBtlsX.Handle.StealHandle();
					return 1;
				}
				x509_ptr = IntPtr.Zero;
				return 0;
			}
			finally
			{
				boringX509NameHandle?.Dispose();
			}
		}
		catch (Exception arg)
		{
			Console.WriteLine("LOOKUP METHOD - GET BY SUBJECT EX: {0}", arg);
			x509_ptr = IntPtr.Zero;
			return 0;
		}
	}

	protected override void Close()
	{
		try
		{
			if (gch.IsAllocated)
			{
				gch.Free();
			}
		}
		finally
		{
			instance = IntPtr.Zero;
			bySubjectFunc = null;
			bySubjectFuncPtr = IntPtr.Zero;
			base.Close();
		}
	}
}
