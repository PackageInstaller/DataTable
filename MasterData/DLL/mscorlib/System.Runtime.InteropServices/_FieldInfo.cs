namespace System.Runtime.InteropServices;

[CLSCompliant(false)]
[InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
[ComVisible(true)]
[Guid("8A7C1442-A9FB-366B-80D8-4939FFA6DBE0")]
public interface _FieldInfo
{
	new Type GetType();

	void GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId);

	void GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo);

	void GetTypeInfoCount(out uint pcTInfo);

	void Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr);
}
