namespace UnityEngine.Rendering;

public struct RenderTargetBinding
{
	private RenderTargetIdentifier[] m_ColorRenderTargets;

	private RenderTargetIdentifier m_DepthRenderTarget;

	private RenderBufferLoadAction[] m_ColorLoadActions;

	private RenderBufferStoreAction[] m_ColorStoreActions;

	private RenderBufferLoadAction m_DepthLoadAction;

	private RenderBufferStoreAction m_DepthStoreAction;

	private RenderTargetFlags m_Flags;

	public RenderTargetIdentifier[] colorRenderTargets => m_ColorRenderTargets;

	public RenderTargetIdentifier depthRenderTarget => m_DepthRenderTarget;

	public RenderBufferLoadAction[] colorLoadActions => m_ColorLoadActions;

	public RenderBufferStoreAction[] colorStoreActions => m_ColorStoreActions;

	public RenderBufferLoadAction depthLoadAction => m_DepthLoadAction;

	public RenderBufferStoreAction depthStoreAction => m_DepthStoreAction;

	public RenderTargetFlags flags => m_Flags;
}
