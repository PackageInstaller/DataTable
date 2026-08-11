using System;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/GraphicsScriptBindings.h")]
public struct RenderBuffer
{
	internal int m_RenderTextureInstanceID;

	internal IntPtr m_BufferPtr;
}
