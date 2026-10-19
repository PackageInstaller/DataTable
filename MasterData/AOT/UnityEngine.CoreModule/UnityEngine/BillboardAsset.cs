using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/Billboard/BillboardAsset.h")]
[NativeHeader("Runtime/Export/Graphics/BillboardRenderer.bindings.h")]
public sealed class BillboardAsset : Object
{
	public BillboardAsset()
	{
		Internal_Create(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "BillboardRenderer_Bindings::Internal_Create")]
	private static extern void Internal_Create([Writable] BillboardAsset obj);
}
