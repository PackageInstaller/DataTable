using System;

namespace UnityEngine.Rendering;

[Flags]
public enum ShaderPropertyFlags
{
	None = 0,
	HideInInspector = 1,
	PerRendererData = 2,
	NoScaleOffset = 4,
	Normal = 8,
	HDR = 0x10,
	Gamma = 0x20,
	NonModifiableTextureData = 0x40,
	MainTexture = 0x80,
	MainColor = 0x100
}
