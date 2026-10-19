using System;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

public struct AttachmentDescriptor : IEquatable<AttachmentDescriptor>
{
	private RenderBufferLoadAction m_LoadAction;

	private RenderBufferStoreAction m_StoreAction;

	private GraphicsFormat m_Format;

	private RenderTargetIdentifier m_LoadStoreTarget;

	private RenderTargetIdentifier m_ResolveTarget;

	private Color m_ClearColor;

	private float m_ClearDepth;

	private uint m_ClearStencil;

	public void ConfigureTarget(RenderTargetIdentifier target, bool loadExistingContents, bool storeResults)
	{
		m_LoadStoreTarget = target;
		if (loadExistingContents && m_LoadAction != RenderBufferLoadAction.Clear)
		{
			m_LoadAction = RenderBufferLoadAction.Load;
		}
		if (storeResults)
		{
			if (m_StoreAction == RenderBufferStoreAction.StoreAndResolve || m_StoreAction == RenderBufferStoreAction.Resolve)
			{
				m_StoreAction = RenderBufferStoreAction.StoreAndResolve;
			}
			else
			{
				m_StoreAction = RenderBufferStoreAction.Store;
			}
		}
	}

	public void ConfigureClear(Color clearColor, float clearDepth = 1f, uint clearStencil = 0u)
	{
		m_ClearColor = clearColor;
		m_ClearDepth = clearDepth;
		m_ClearStencil = clearStencil;
		m_LoadAction = RenderBufferLoadAction.Clear;
	}

	public AttachmentDescriptor(GraphicsFormat format)
	{
		this = default;
		m_LoadAction = RenderBufferLoadAction.DontCare;
		m_StoreAction = RenderBufferStoreAction.DontCare;
		m_Format = format;
		m_LoadStoreTarget = new RenderTargetIdentifier(BuiltinRenderTextureType.None);
		m_ResolveTarget = new RenderTargetIdentifier(BuiltinRenderTextureType.None);
		m_ClearColor = new Color(0f, 0f, 0f, 0f);
		m_ClearDepth = 1f;
	}

	public AttachmentDescriptor(RenderTextureFormat format)
		: this(GraphicsFormatUtility.GetGraphicsFormat(format, RenderTextureReadWrite.Default))
	{
	}

	public bool Equals(AttachmentDescriptor other)
	{
		return m_LoadAction == other.m_LoadAction && m_StoreAction == other.m_StoreAction && m_Format == other.m_Format && m_LoadStoreTarget.Equals(other.m_LoadStoreTarget) && m_ResolveTarget.Equals(other.m_ResolveTarget) && m_ClearColor.Equals(other.m_ClearColor) && m_ClearDepth.Equals(other.m_ClearDepth) && m_ClearStencil == other.m_ClearStencil;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is AttachmentDescriptor && Equals((AttachmentDescriptor)obj);
	}

	public override int GetHashCode()
	{
		int loadAction = (int)m_LoadAction;
		loadAction = (loadAction * 397) ^ (int)m_StoreAction;
		loadAction = (loadAction * 397) ^ (int)m_Format;
		loadAction = (loadAction * 397) ^ m_LoadStoreTarget.GetHashCode();
		loadAction = (loadAction * 397) ^ m_ResolveTarget.GetHashCode();
		loadAction = (loadAction * 397) ^ m_ClearColor.GetHashCode();
		loadAction = (loadAction * 397) ^ m_ClearDepth.GetHashCode();
		return (loadAction * 397) ^ (int)m_ClearStencil;
	}
}
