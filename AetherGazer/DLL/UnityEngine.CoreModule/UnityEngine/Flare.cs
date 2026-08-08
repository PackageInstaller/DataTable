using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Camera/Flare.h")]
public sealed class Flare : Object
{
	public Flare()
	{
		Internal_Create(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Internal_Create([Writable] Flare self);
}
