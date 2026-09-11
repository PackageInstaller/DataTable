namespace System.Runtime.InteropServices;

[Serializable]
[ComVisible(true)]
public enum ComInterfaceType
{
	InterfaceIsDual,
	InterfaceIsIUnknown,
	InterfaceIsIDispatch,
	[ComVisible(false)]
	InterfaceIsIInspectable
}
