using System.Reflection.Emit;

namespace System.Runtime.InteropServices;

[InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
[TypeLibImportClass(typeof(TypeBuilder))]
[ComVisible(true)]
[Guid("7E5678EE-48B3-3F83-B076-C58543498A58")]
[CLSCompliant(false)]
public interface _TypeBuilder
{
	void GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId);

	void GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo);

	void GetTypeInfoCount(out uint pcTInfo);

	void Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr);
}
