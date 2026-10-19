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

	public RenderTargetIdentifier[] colorRenderTargets
	{
		get
		{
			return m_ColorRenderTargets;
		}
		set
		{
			m_ColorRenderTargets = value;
		}
	}

	public RenderTargetIdentifier depthRenderTarget
	{
		get
		{
			return m_DepthRenderTarget;
		}
		set
		{
			m_DepthRenderTarget = value;
		}
	}

	public RenderBufferLoadAction[] colorLoadActions
	{
		get
		{
			return m_ColorLoadActions;
		}
		set
		{
			m_ColorLoadActions = value;
		}
	}

	public RenderBufferStoreAction[] colorStoreActions
	{
		get
		{
			return m_ColorStoreActions;
		}
		set
		{
			m_ColorStoreActions = value;
		}
	}

	public RenderBufferLoadAction depthLoadAction
	{
		get
		{
			return m_DepthLoadAction;
		}
		set
		{
			m_DepthLoadAction = value;
		}
	}

	public RenderBufferStoreAction depthStoreAction
	{
		get
		{
			return m_DepthStoreAction;
		}
		set
		{
			m_DepthStoreAction = value;
		}
	}

	public RenderTargetFlags flags => m_Flags;
}
