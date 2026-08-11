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

	public RenderBufferLoadAction loadAction
	{
		set
		{
			m_LoadAction = value;
		}
	}

	public RenderBufferStoreAction storeAction
	{
		set
		{
			m_StoreAction = value;
		}
	}

	public GraphicsFormat graphicsFormat => m_Format;

	public RenderTargetIdentifier loadStoreTarget
	{
		get
		{
			return m_LoadStoreTarget;
		}
		set
		{
			m_LoadStoreTarget = value;
		}
	}

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

	public void ConfigureResolveTarget(RenderTargetIdentifier target)
	{
		m_ResolveTarget = target;
		if (m_StoreAction == RenderBufferStoreAction.StoreAndResolve || m_StoreAction == RenderBufferStoreAction.Store)
		{
			m_StoreAction = RenderBufferStoreAction.StoreAndResolve;
		}
		else
		{
			m_StoreAction = RenderBufferStoreAction.Resolve;
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
		this = default(AttachmentDescriptor);
		m_LoadAction = RenderBufferLoadAction.DontCare;
		m_StoreAction = RenderBufferStoreAction.DontCare;
		m_Format = format;
		m_LoadStoreTarget = new RenderTargetIdentifier(BuiltinRenderTextureType.None);
		m_ResolveTarget = new RenderTargetIdentifier(BuiltinRenderTextureType.None);
		m_ClearColor = new Color(0f, 0f, 0f, 0f);
		m_ClearDepth = 1f;
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
		int num = (int)m_LoadAction;
		num = (num * 397) ^ (int)m_StoreAction;
		num = (num * 397) ^ (int)m_Format;
		num = (num * 397) ^ m_LoadStoreTarget.GetHashCode();
		num = (num * 397) ^ m_ResolveTarget.GetHashCode();
		num = (num * 397) ^ m_ClearColor.GetHashCode();
		num = (num * 397) ^ m_ClearDepth.GetHashCode();
		return (num * 397) ^ (int)m_ClearStencil;
	}

	public static bool operator !=(AttachmentDescriptor left, AttachmentDescriptor right)
	{
		return !left.Equals(right);
	}
}
