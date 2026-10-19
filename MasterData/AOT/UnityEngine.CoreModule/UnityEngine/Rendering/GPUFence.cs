using System;
using System.Runtime.InteropServices;

namespace UnityEngine.Rendering;

[StructLayout(LayoutKind.Sequential, Size = 1)]
[Obsolete("GPUFence has been deprecated. Use GraphicsFence instead (UnityUpgradable) -> GraphicsFence", false)]
public struct GPUFence
{
}
