using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Bootstrap/BootConfig.bindings.h")]
internal class BootConfigData
{
	private IntPtr m_Ptr;

	[RequiredByNativeCode]
	private static BootConfigData WrapBootConfigData(IntPtr nativeHandle)
	{
		return new BootConfigData(nativeHandle);
	}

	private BootConfigData(IntPtr nativeHandle)
	{
		if (nativeHandle == IntPtr.Zero)
		{
			throw new ArgumentException("native handle can not be null");
		}
		m_Ptr = nativeHandle;
	}
}
