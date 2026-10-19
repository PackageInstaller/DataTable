using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/Mesh/MeshRenderer.h")]
public class MeshRenderer : Renderer
{
	public extern Mesh additionalVertexStreams
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Mesh enlightenVertexStream
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int subMeshStartIndex
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetSubMeshStartIndex")]
		get;
	}

	[RequiredByNativeCode]
	private void DontStripMeshRenderer()
	{
	}
}
