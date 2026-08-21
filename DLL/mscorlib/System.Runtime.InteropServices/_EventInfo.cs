namespace System.Runtime.InteropServices;

[ComVisible(true)]
[CLSCompliant(false)]
[Guid("9DE59C64-D889-35A1-B897-587D74469E5B")]
[InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
public interface _EventInfo
{
	void GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId);

	void GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo);

	void GetTypeInfoCount(out uint pcTInfo);

	void Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr);

	new Type GetType();
}
