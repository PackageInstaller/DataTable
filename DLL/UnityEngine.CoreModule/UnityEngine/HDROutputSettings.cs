using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/GfxDevice/HDROutputSettings.h")]
[UsedByNativeCode]
public class HDROutputSettings
{
	private int m_DisplayIndex;

	public static HDROutputSettings[] displays = new HDROutputSettings[1]
	{
		new HDROutputSettings()
	};

	private static HDROutputSettings _mainDisplay = displays[0];

	public bool active => GetActive(m_DisplayIndex);

	public bool available => GetAvailable(m_DisplayIndex);

	[VisibleToOtherModules(new string[] { "UnityEngine.XRModule" })]
	internal HDROutputSettings()
	{
		m_DisplayIndex = 0;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("HDROutputSettingsBindings::GetActive", HasExplicitThis = false, ThrowsException = true)]
	private static extern bool GetActive(int displayIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("HDROutputSettingsBindings::GetAvailable", HasExplicitThis = false, ThrowsException = true)]
	private static extern bool GetAvailable(int displayIndex);
}
