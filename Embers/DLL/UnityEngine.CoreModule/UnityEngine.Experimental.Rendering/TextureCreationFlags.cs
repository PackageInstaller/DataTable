using System;

namespace UnityEngine.Experimental.Rendering;

[Flags]
public enum TextureCreationFlags
{
	None = 0,
	MipChain = 1,
	Crunch = 0x40
}
