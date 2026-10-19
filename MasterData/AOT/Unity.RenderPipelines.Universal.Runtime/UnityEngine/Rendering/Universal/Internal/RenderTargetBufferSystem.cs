using System;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class RenderTargetBufferSystem : IDisposable
{
	private enum ActiveSet
	{
		Render,
		UpscaleScreen,
		DisplayScreen
	}

	private sealed class PersistentBuffer
	{
		public readonly string name;

		public RenderTexture texture;

		public RTHandle rt;

		public RenderTextureDescriptor descriptor;

		public bool hasDescriptor;

		public PersistentBuffer(string name)
		{
			this.name = name;
			CreateManagedResources();
		}

		public void CreateManagedResources()
		{
			if (!(texture != null))
			{
				texture = new RenderTexture(1, 1, 0)
				{
					hideFlags = HideFlags.HideAndDontSave,
					name = name,
					filterMode = FilterMode.Bilinear,
					wrapMode = TextureWrapMode.Clamp
				};
				rt = RTHandles.Alloc(texture);
			}
		}
	}

	private sealed class PersistentBufferSet
	{
		public readonly PersistentBuffer A;

		public readonly PersistentBuffer B;

		public PersistentBufferSet(string nameA, string nameB)
		{
			A = new PersistentBuffer(nameA);
			B = new PersistentBuffer(nameB);
		}
	}

	private sealed class TemporaryBuffer
	{
		public RenderTargetHandle handle;

		public bool allocated;

		public TemporaryBuffer(string name)
		{
			handle.Init(name);
		}
	}

	private sealed class TemporaryBufferSet
	{
		public readonly TemporaryBuffer A;

		public readonly TemporaryBuffer B;

		public TemporaryBufferSet(string nameA, string nameB)
		{
			A = new TemporaryBuffer(nameA);
			B = new TemporaryBuffer(nameB);
		}
	}

	private readonly PersistentBufferSet m_RenderSet;

	private readonly PersistentBuffer m_TemporalOutput;

	private readonly TemporaryBufferSet m_UpscaleScreenSet;

	private readonly TemporaryBufferSet m_DisplayScreenSet;

	private ActiveSet m_ActiveSet;

	private bool m_AisBackBuffer = true;

	private RenderTextureDescriptor m_Desc;

	private bool m_RTisAllocated;

	private PersistentBuffer renderBackBuffer
	{
		get
		{
			if (!m_AisBackBuffer)
			{
				return m_RenderSet.B;
			}
			return m_RenderSet.A;
		}
	}

	private PersistentBuffer renderFrontBuffer
	{
		get
		{
			if (!m_AisBackBuffer)
			{
				return m_RenderSet.A;
			}
			return m_RenderSet.B;
		}
	}

	private TemporaryBufferSet activeTemporarySet
	{
		get
		{
			if (m_ActiveSet != ActiveSet.UpscaleScreen)
			{
				return m_DisplayScreenSet;
			}
			return m_UpscaleScreenSet;
		}
	}

	private TemporaryBuffer temporaryBackBuffer
	{
		get
		{
			if (!m_AisBackBuffer)
			{
				return activeTemporarySet.B;
			}
			return activeTemporarySet.A;
		}
	}

	private TemporaryBuffer temporaryFrontBuffer
	{
		get
		{
			if (!m_AisBackBuffer)
			{
				return activeTemporarySet.A;
			}
			return activeTemporarySet.B;
		}
	}

	public RenderTargetBufferSystem(string name)
	{
		m_RenderSet = new PersistentBufferSet(name + "A", name + "B");
		m_TemporalOutput = new PersistentBuffer(name + "TemporalOutput");
		m_UpscaleScreenSet = new TemporaryBufferSet(name + "UpscaleScreenA", name + "UpscaleScreenB");
		m_DisplayScreenSet = new TemporaryBufferSet(name + "DisplayScreenA", name + "DisplayScreenB");
	}

	public RenderTargetIdentifier GetBackBuffer()
	{
		if (m_ActiveSet == ActiveSet.Render)
		{
			if (!IsPersistentBufferCreated(renderBackBuffer))
			{
				return default;
			}
			return renderBackBuffer.rt.nameID;
		}
		if (!temporaryBackBuffer.allocated)
		{
			return default;
		}
		return temporaryBackBuffer.handle.Identifier();
	}

	public RTHandle GetRenderBackBufferHandle()
	{
		if (m_ActiveSet != ActiveSet.Render || !IsPersistentBufferCreated(renderBackBuffer))
		{
			return null;
		}
		return renderBackBuffer.rt;
	}

	public RenderTargetIdentifier GetFrontBuffer(CommandBuffer cmd)
	{
		if (m_ActiveSet == ActiveSet.Render)
		{
			if (!IsPersistentBufferCreated(renderFrontBuffer))
			{
				return default;
			}
			return renderFrontBuffer.rt.nameID;
		}
		EnsureTemporaryBuffer(cmd, temporaryFrontBuffer, m_Desc);
		return temporaryFrontBuffer.handle.Identifier();
	}

	public bool IsCurrentResolution(int width, int height)
	{
		if (m_Desc.width == width)
		{
			return m_Desc.height == height;
		}
		return false;
	}

	public RenderTextureDescriptor GetCurrentDescriptor()
	{
		return m_Desc;
	}

	public bool IsDisplayScreenActive()
	{
		return m_ActiveSet == ActiveSet.DisplayScreen;
	}

	public void Swap()
	{
		m_AisBackBuffer = !m_AisBackBuffer;
	}

	public void Clear()
	{
		m_ActiveSet = ActiveSet.Render;
		m_AisBackBuffer = true;
		m_RTisAllocated = false;
	}

	public void Create2RT(RenderTextureDescriptor desc)
	{
		m_Desc = desc;
		m_ActiveSet = ActiveSet.Render;
		m_AisBackBuffer = true;
		EnsurePersistentBuffer(m_RenderSet.A, desc);
		EnsurePersistentBuffer(m_RenderSet.B, desc);
		m_RTisAllocated = true;
	}

	public RenderTargetIdentifier Create1RT(CommandBuffer cmd, RenderTextureDescriptor desc)
	{
		m_Desc = desc;
		m_ActiveSet = ActiveSet.DisplayScreen;
		m_AisBackBuffer = true;
		EnsureTemporaryBuffer(cmd, m_DisplayScreenSet.A, desc);
		m_RTisAllocated = true;
		return m_DisplayScreenSet.A.handle.Identifier();
	}

	public void BeginUpscaleScreen(int width, int height, GraphicsFormat graphicsFormat)
	{
		BeginTemporaryScreen(ActiveSet.UpscaleScreen, width, height, graphicsFormat);
	}

	public void BeginDisplayScreen(int width, int height, GraphicsFormat graphicsFormat = GraphicsFormat.None)
	{
		BeginTemporaryScreen(ActiveSet.DisplayScreen, width, height, graphicsFormat);
	}

	private void BeginTemporaryScreen(ActiveSet activeSet, int width, int height, GraphicsFormat graphicsFormat)
	{
		RenderTextureDescriptor desc = m_Desc;
		desc.width = width;
		desc.height = height;
		if (graphicsFormat != GraphicsFormat.None)
		{
			desc.graphicsFormat = graphicsFormat;
		}
		desc.enableRandomWrite = false;
		if (m_ActiveSet != activeSet)
		{
			m_Desc = desc;
			m_ActiveSet = activeSet;
			m_AisBackBuffer = false;
			m_RTisAllocated = true;
		}
	}

	public RTHandle PrepareTemporalOutput(int width, int height, GraphicsFormat graphicsFormat)
	{
		RenderTextureDescriptor desc = m_Desc;
		desc.width = width;
		desc.height = height;
		desc.graphicsFormat = graphicsFormat;
		desc.depthBufferBits = 0;
		desc.depthStencilFormat = GraphicsFormat.None;
		desc.enableRandomWrite = true;
		EnsurePersistentBuffer(m_TemporalOutput, desc);
		return m_TemporalOutput.rt;
	}

	public void ReleaseTemporalOutput()
	{
		ReleasePersistentBuffer(m_TemporalOutput);
	}

	public void ReleaseRenderBuffers()
	{
		ReleasePersistentBuffer(m_RenderSet.A);
		ReleasePersistentBuffer(m_RenderSet.B);
		m_RTisAllocated = false;
	}

	public bool IsRTAllocated()
	{
		return m_RTisAllocated;
	}

	public void ReleaseTemporaryBuffers(CommandBuffer cmd)
	{
		ReleaseTemporaryBuffer(cmd, m_UpscaleScreenSet.A);
		ReleaseTemporaryBuffer(cmd, m_UpscaleScreenSet.B);
		ReleaseTemporaryBuffer(cmd, m_DisplayScreenSet.A);
		ReleaseTemporaryBuffer(cmd, m_DisplayScreenSet.B);
	}

	public void Dispose()
	{
		DestroyPersistentBuffer(m_RenderSet.A);
		DestroyPersistentBuffer(m_RenderSet.B);
		DestroyPersistentBuffer(m_TemporalOutput);
		Clear();
	}

	private static void EnsurePersistentBuffer(PersistentBuffer buffer, RenderTextureDescriptor descriptor)
	{
		buffer.CreateManagedResources();
		if (!buffer.hasDescriptor || !buffer.texture.IsCreated() || buffer.descriptor.width != descriptor.width || buffer.descriptor.height != descriptor.height)
		{
			ReleasePersistentBuffer(buffer);
			buffer.texture.descriptor = descriptor;
			buffer.texture.name = buffer.name;
			buffer.texture.filterMode = FilterMode.Bilinear;
			buffer.texture.wrapMode = TextureWrapMode.Clamp;
			buffer.texture.Create();
			buffer.descriptor = descriptor;
			buffer.hasDescriptor = true;
		}
	}

	private static bool IsPersistentBufferCreated(PersistentBuffer buffer)
	{
		if (buffer.texture != null)
		{
			return buffer.texture.IsCreated();
		}
		return false;
	}

	private static void ReleasePersistentBuffer(PersistentBuffer buffer)
	{
		if (buffer.texture != null && buffer.texture.IsCreated())
		{
			buffer.texture.Release();
		}
		buffer.hasDescriptor = false;
	}

	private static void DestroyPersistentBuffer(PersistentBuffer buffer)
	{
		if (buffer.rt != null)
		{
			RTHandles.Release(buffer.rt);
		}
		buffer.rt = null;
		buffer.texture = null;
		buffer.hasDescriptor = false;
	}

	private static void EnsureTemporaryBuffer(CommandBuffer cmd, TemporaryBuffer buffer, RenderTextureDescriptor descriptor)
	{
		if (!buffer.allocated)
		{
			cmd.GetTemporaryRT(buffer.handle.id, descriptor, FilterMode.Bilinear);
			buffer.allocated = true;
		}
	}

	private static void ReleaseTemporaryBuffer(CommandBuffer cmd, TemporaryBuffer buffer)
	{
		if (buffer.allocated)
		{
			cmd.ReleaseTemporaryRT(buffer.handle.id);
			buffer.allocated = false;
		}
	}
}
