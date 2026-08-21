using System;

namespace UnityEngine.Rendering;

[Flags]
public enum CopyTextureSupport
{
	None = 0,
	Basic = 1,
	Copy3D = 2,
	DifferentTypes = 4,
	TextureToRT = 8,
	RTToTexture = 0x10
}
