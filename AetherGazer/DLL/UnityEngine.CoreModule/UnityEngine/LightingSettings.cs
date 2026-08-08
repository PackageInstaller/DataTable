using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/LightingSettings.h")]
[PreventReadOnlyInstanceModification]
public sealed class LightingSettings : Object
{
	[RequiredByNativeCode]
	internal void LightingSettingsDontStripMe()
	{
	}
}
