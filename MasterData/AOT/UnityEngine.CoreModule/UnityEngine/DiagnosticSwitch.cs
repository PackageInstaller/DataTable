using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[NativeHeader("Runtime/Utilities/DiagnosticSwitch.h")]
[NativeClass("DiagnosticSwitch", "struct DiagnosticSwitch;")]
[NativeAsStruct]
internal class DiagnosticSwitch
{
	private IntPtr m_Ptr;

	public extern string name
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	private DiagnosticSwitch()
	{
	}
}
