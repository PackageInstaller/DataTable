using System;

namespace UnityEngine.Experimental.Rendering;

[Flags]
public enum TextureCreationFlags
{
	None = 0,
	MipChain = 1,
	DontInitializePixels = 4,
	Crunch = 0x40,
	DontUploadUponCreate = 0x400,
	IgnoreMipmapLimit = 0x800
}
