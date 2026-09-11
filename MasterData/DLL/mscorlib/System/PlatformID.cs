using System.Runtime.InteropServices;

namespace System;

[Serializable]
[ComVisible(true)]
public enum PlatformID
{
	Win32S,
	Win32Windows,
	Win32NT,
	WinCE,
	Unix,
	Xbox,
	MacOSX
}
