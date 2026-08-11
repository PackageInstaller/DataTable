using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Camera/Skybox.h")]
public sealed class Skybox : Behaviour
{
	public extern Material material
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}
}
