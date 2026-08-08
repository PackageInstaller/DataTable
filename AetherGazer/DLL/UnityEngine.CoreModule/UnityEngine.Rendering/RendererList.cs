using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Rendering;

[MovedFrom("UnityEngine.Rendering.RendererUtils")]
[NativeHeader("Runtime/Graphics/ScriptableRenderLoop/RendererList.h")]
public struct RendererList
{
	internal UIntPtr context;

	internal uint index;

	internal uint frame;

	internal uint type;

	public static readonly RendererList nullRendererList = new RendererList(UIntPtr.Zero, uint.MaxValue);

	public bool isValid => get_isValid_Injected(ref this);

	internal RendererList(UIntPtr ctx, uint indx)
	{
		context = ctx;
		index = indx;
		frame = 0u;
		type = 0u;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern bool get_isValid_Injected(ref RendererList _unity_self);
}
