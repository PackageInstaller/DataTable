using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[NativeHeader("Runtime/Graphics/LightmapData.h")]
[UsedByNativeCode]
public sealed class LightmapData
{
	internal Texture2D m_Light;

	internal Texture2D m_Dir;

	internal Texture2D m_ShadowMask;
}
