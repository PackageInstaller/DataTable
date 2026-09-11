using System;
using System.Runtime.InteropServices;

namespace Mono.Btls;

internal class MonoBtlsBio : MonoBtlsObject
{
	protected internal class BoringBioHandle : MonoBtlsHandle
	{
		public BoringBioHandle(IntPtr handle)
			: base(handle, ownsHandle: true)
		{
		}

		protected override bool ReleaseHandle()
		{
			if (handle != IntPtr.Zero)
			{
				mono_btls_bio_free(handle);
				handle = IntPtr.Zero;
			}
			return true;
		}
	}

	protected internal new BoringBioHandle Handle => (BoringBioHandle)base.Handle;

	internal MonoBtlsBio(BoringBioHandle handle)
		: base(handle)
	{
	}

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_bio_free(IntPtr handle);
}
