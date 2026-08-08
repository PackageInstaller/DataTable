using UnityEngine.Rendering;

namespace UnityEngine;

public struct RenderTargetSetup
{
	public RenderBuffer[] color;

	public RenderBuffer depth;

	public int mipLevel;

	public CubemapFace cubemapFace;

	public int depthSlice;

	public RenderBufferLoadAction[] colorLoad;

	public RenderBufferStoreAction[] colorStore;

	public RenderBufferLoadAction depthLoad;

	public RenderBufferStoreAction depthStore;
}
