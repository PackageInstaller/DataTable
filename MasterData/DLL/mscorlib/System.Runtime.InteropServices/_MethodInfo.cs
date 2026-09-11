namespace System.Runtime.InteropServices;

[Guid("FFCC1B5D-ECB8-38DD-9B01-3DC8ABC2AA5F")]
[ComVisible(true)]
[InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
[CLSCompliant(false)]
public interface _MethodInfo
{
	void GetTypeInfoCount(out uint pcTInfo);

	void GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo);

	void GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId);

	void Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr);

	new Type GetType();
}
