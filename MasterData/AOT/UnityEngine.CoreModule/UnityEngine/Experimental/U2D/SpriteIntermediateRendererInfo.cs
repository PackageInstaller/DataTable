using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Experimental.U2D;

[RequiredByNativeCode]
[NativeHeader("Runtime/2D/Renderer/SpriteRendererGroup.h")]
internal struct SpriteIntermediateRendererInfo
{
	public int SpriteID;

	public int TextureID;

	public int MaterialID;

	public Color Color;

	public Matrix4x4 Transform;

	public Bounds Bounds;

	public int Layer;

	public int SortingLayer;

	public int SortingOrder;

	public ulong SceneCullingMask;

	public IntPtr IndexData;

	public IntPtr VertexData;

	public int IndexCount;

	public int VertexCount;

	public int ShaderChannelMask;
}
