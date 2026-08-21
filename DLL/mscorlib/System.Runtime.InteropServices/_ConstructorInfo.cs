using System.Globalization;
using System.Reflection;

namespace System.Runtime.InteropServices;

[ComVisible(true)]
[Guid("E9A19478-9646-3679-9B10-8411AE1FD57D")]
[CLSCompliant(false)]
[InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
public interface _ConstructorInfo
{
	void GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId);

	void GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo);

	void GetTypeInfoCount(out uint pcTInfo);

	void Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr);

	new Type GetType();

	object Invoke_5(object[] parameters);

	object Invoke_3(object obj, object[] parameters);

	object Invoke_4(BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture);

	object Invoke_2(object obj, BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture);
}
