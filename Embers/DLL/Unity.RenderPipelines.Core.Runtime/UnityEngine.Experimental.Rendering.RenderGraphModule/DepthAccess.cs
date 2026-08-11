using System;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

[Flags]
public enum DepthAccess
{
	Read = 1,
	Write = 2,
	ReadWrite = Read | Write
}
