using System.Runtime.InteropServices;

namespace System;

[Flags]
[ComVisible(true)]
public enum AppDomainManagerInitializationOptions
{
	None = 0,
	RegisterWithHost = 1
}
