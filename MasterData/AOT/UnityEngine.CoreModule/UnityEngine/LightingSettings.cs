using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[PreventReadOnlyInstanceModification]
[NativeHeader("Runtime/Graphics/LightingSettings.h")]
public sealed class LightingSettings : Object
{
	[RequiredByNativeCode]
	internal void LightingSettingsDontStripMe()
	{
	}
}
