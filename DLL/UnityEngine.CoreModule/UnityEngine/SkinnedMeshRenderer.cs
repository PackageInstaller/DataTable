using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/Mesh/SkinnedMeshRenderer.h")]
[RequiredByNativeCode]
public class SkinnedMeshRenderer : Renderer
{
	public extern SkinQuality quality
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool updateWhenOffscreen
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool forceMatrixRecalculationPerRender
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Transform rootBone
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Transform[] bones
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("Mesh")]
	public extern Mesh sharedMesh
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("SkinnedMeshMotionVectors")]
	public extern bool skinnedMotionVectors
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern GraphicsBuffer.Target vertexBufferTarget
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern float GetBlendShapeWeight(int index);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetBlendShapeWeight(int index, float value);

	public void BakeMesh(Mesh mesh)
	{
		BakeMesh(mesh, useScale: false);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void BakeMesh([NotNull("NullExceptionObject")] Mesh mesh, bool useScale);

	public GraphicsBuffer GetVertexBuffer()
	{
		if (this == null)
		{
			throw new NullReferenceException();
		}
		return GetVertexBufferImpl();
	}

	public GraphicsBuffer GetPreviousVertexBuffer()
	{
		if (this == null)
		{
			throw new NullReferenceException();
		}
		return GetPreviousVertexBufferImpl();
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "SkinnedMeshRendererScripting::GetVertexBufferPtr", HasExplicitThis = true)]
	private extern GraphicsBuffer GetVertexBufferImpl();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "SkinnedMeshRendererScripting::GetPreviousVertexBufferPtr", HasExplicitThis = true)]
	private extern GraphicsBuffer GetPreviousVertexBufferImpl();
}
