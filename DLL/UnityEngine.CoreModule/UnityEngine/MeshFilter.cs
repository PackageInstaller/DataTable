using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequireComponent(typeof(Transform))]
[NativeHeader("Runtime/Graphics/Mesh/MeshFilter.h")]
public sealed class MeshFilter : Component
{
	public extern Mesh sharedMesh
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Mesh mesh
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetInstantiatedMeshFromScript")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("SetInstantiatedMesh")]
		set;
	}

	[RequiredByNativeCode]
	private void DontStripMeshFilter()
	{
	}
}
