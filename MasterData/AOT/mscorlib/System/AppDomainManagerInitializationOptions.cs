using System.Runtime.InteropServices;

namespace System;

[ComVisible(true)]
[Flags]
public enum AppDomainManagerInitializationOptions
{
	None = 0,
	RegisterWithHost = 1
}
