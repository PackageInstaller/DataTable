using System;
using System.Runtime.InteropServices;
using System.Text;

namespace Mono.Btls;

internal class MonoBtlsX509Name : MonoBtlsObject
{
	internal class BoringX509NameHandle : MonoBtlsHandle
	{
		private bool dontFree;

		internal BoringX509NameHandle(IntPtr handle, bool ownsHandle)
			: base(handle, ownsHandle)
		{
			dontFree = !ownsHandle;
		}

		protected override bool ReleaseHandle()
		{
			if (!dontFree)
			{
				mono_btls_x509_name_free(handle);
			}
			return true;
		}
	}

	internal new BoringX509NameHandle Handle => (BoringX509NameHandle)base.Handle;

	[DllImport("libmono-btls-shared")]
	private static extern long mono_btls_x509_name_hash(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_name_get_entry_count(IntPtr handle);

	[DllImport("libmono-btls-shared")]
	private static extern MonoBtlsX509NameEntryType mono_btls_x509_name_get_entry_type(IntPtr name, int index);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_name_get_entry_oid(IntPtr name, int index, IntPtr buffer, int size);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_name_get_entry_oid_data(IntPtr name, int index, out IntPtr data);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_x509_name_get_entry_value(IntPtr name, int index, out int tag, out IntPtr str);

	[DllImport("libmono-btls-shared")]
	private unsafe static extern IntPtr mono_btls_x509_name_from_data(void* data, int len, int use_canon_enc);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_x509_name_free(IntPtr handle);

	internal MonoBtlsX509Name(BoringX509NameHandle handle)
		: base(handle)
	{
	}

	public long GetHash()
	{
		return mono_btls_x509_name_hash(Handle.DangerousGetHandle());
	}

	public int GetEntryCount()
	{
		return mono_btls_x509_name_get_entry_count(Handle.DangerousGetHandle());
	}

	public MonoBtlsX509NameEntryType GetEntryType(int index)
	{
		if (index >= GetEntryCount())
		{
			throw new ArgumentOutOfRangeException();
		}
		return mono_btls_x509_name_get_entry_type(Handle.DangerousGetHandle(), index);
	}

	public string GetEntryOid(int index)
	{
		if (index >= GetEntryCount())
		{
			throw new ArgumentOutOfRangeException();
		}
		IntPtr intPtr = Marshal.AllocHGlobal(4096);
		try
		{
			int num = mono_btls_x509_name_get_entry_oid(Handle.DangerousGetHandle(), index, intPtr, 4096);
			CheckError(num > 0, "GetEntryOid");
			return Marshal.PtrToStringAnsi(intPtr);
		}
		finally
		{
			Marshal.FreeHGlobal(intPtr);
		}
	}

	public byte[] GetEntryOidData(int index)
	{
		int num = mono_btls_x509_name_get_entry_oid_data(Handle.DangerousGetHandle(), index, out var data);
		CheckError(num > 0, "GetEntryOidData");
		byte[] array = new byte[num];
		Marshal.Copy(data, array, 0, num);
		return array;
	}

	public unsafe string GetEntryValue(int index, out int tag)
	{
		if (index >= GetEntryCount())
		{
			throw new ArgumentOutOfRangeException();
		}
		int num = mono_btls_x509_name_get_entry_value(Handle.DangerousGetHandle(), index, out tag, out var str);
		if (num <= 0)
		{
			return null;
		}
		try
		{
			return new UTF8Encoding().GetString((byte*)(void*)str, num);
		}
		finally
		{
			if (str != IntPtr.Zero)
			{
				FreeDataPtr(str);
			}
		}
	}

	public unsafe static MonoBtlsX509Name CreateFromData(byte[] data, bool use_canon_enc)
	{
		fixed (byte* ptr = data)
		{
			void* data2 = ptr;
			IntPtr intPtr = mono_btls_x509_name_from_data(data2, data.Length, use_canon_enc ? 1 : 0);
			if (intPtr == IntPtr.Zero)
			{
				throw new MonoBtlsException("mono_btls_x509_name_from_data() failed.");
			}
			return new MonoBtlsX509Name(new BoringX509NameHandle(intPtr, ownsHandle: false));
		}
	}
}
