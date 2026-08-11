using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/LineRenderer.h")]
[NativeHeader("Runtime/Graphics/GraphicsScriptBindings.h")]
public sealed class LineRenderer : Renderer
{
	public Color startColor
	{
		set
		{
			set_startColor_Injected(ref value);
		}
	}

	public Color endColor
	{
		set
		{
			set_endColor_Injected(ref value);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_startColor_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_endColor_Injected(ref Color value);
}
