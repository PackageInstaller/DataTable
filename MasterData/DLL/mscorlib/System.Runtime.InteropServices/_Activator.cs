namespace System.Runtime.InteropServices;

[InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
[CLSCompliant(false)]
[ComVisible(true)]
[Guid("03973551-57A1-3900-A2B5-9083E3FF2943")]
public interface _Activator
{
	void GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId);

	void GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo);

	void GetTypeInfoCount(out uint pcTInfo);

	void Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr);
}
