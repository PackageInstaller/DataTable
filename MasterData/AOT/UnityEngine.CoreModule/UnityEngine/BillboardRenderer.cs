using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/Billboard/BillboardRenderer.h")]
public sealed class BillboardRenderer : Renderer
{
	public extern BillboardAsset billboard
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}
}
