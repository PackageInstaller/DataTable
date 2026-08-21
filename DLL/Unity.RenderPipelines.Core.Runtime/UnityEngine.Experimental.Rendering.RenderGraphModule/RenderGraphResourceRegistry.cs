using System;
using System.Collections.Generic;
using UnityEngine.Rendering;
using UnityEngine.Rendering.RendererUtils;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal class RenderGraphResourceRegistry
{
	private delegate void ResourceCallback(RenderGraphContext rgContext, IRenderGraphResource res);

	private class RenderGraphResourcesData
	{
		public DynamicArray<IRenderGraphResource> resourceArray = new DynamicArray<IRenderGraphResource>();

		public int sharedResourcesCount;

		public IRenderGraphResourcePool pool;

		public ResourceCallback createResourceCallback;

		public ResourceCallback releaseResourceCallback;

		public void Clear(bool onException, int frameIndex)
		{
			resourceArray.Resize(sharedResourcesCount);
			pool.CheckFrameAllocation(onException, frameIndex);
		}

		public void Cleanup()
		{
			for (int i = 0; i < sharedResourcesCount; i++)
			{
				resourceArray[i]?.ReleaseGraphicsResource();
			}
			pool.Cleanup();
		}

		public void PurgeUnusedGraphicsResources(int frameIndex)
		{
			pool.PurgeUnusedResources(frameIndex);
		}

		public int AddNewRenderGraphResource<ResType>(out ResType outRes, bool pooledResource = true) where ResType : IRenderGraphResource, new()
		{
			int size = resourceArray.size;
			resourceArray.Resize(resourceArray.size + 1, keepContent: true);
			if (resourceArray[size] == null)
			{
				resourceArray[size] = new ResType();
			}
			outRes = resourceArray[size] as ResType;
			IRenderGraphResourcePool obj = (pooledResource ? pool : null);
			outRes.Reset(obj);
			return size;
		}
	}

	private const int kSharedResourceLifetime = 30;

	private static RenderGraphResourceRegistry m_CurrentRegistry;

	private RenderGraphResourcesData[] m_RenderGraphResources = new RenderGraphResourcesData[2];

	private DynamicArray<RendererListResource> m_RendererListResources = new DynamicArray<RendererListResource>();

	private RenderGraphDebugParams m_RenderGraphDebug;

	private RenderGraphLogger m_ResourceLogger = new RenderGraphLogger();

	private RenderGraphLogger m_FrameInformationLogger;

	private int m_CurrentFrameIndex;

	private int m_ExecutionCount;

	private RTHandle m_CurrentBackbuffer;

	private const int kInitialRendererListCount = 256;

	private List<UnityEngine.Rendering.RendererUtils.RendererList> m_ActiveRendererLists = new List<UnityEngine.Rendering.RendererUtils.RendererList>(256);

	internal static RenderGraphResourceRegistry current
	{
		get
		{
			return m_CurrentRegistry;
		}
		set
		{
			m_CurrentRegistry = value;
		}
	}

	internal RTHandle GetTexture(in TextureHandle handle)
	{
		if (!handle.IsValid())
		{
			return null;
		}
		TextureResource textureResource = GetTextureResource(in handle.handle);
		RTHandle graphicsResource = textureResource.graphicsResource;
		if (graphicsResource == null)
		{
			if ((int)handle.fallBackResource != (int)TextureHandle.nullHandle.handle)
			{
				return GetTextureResource(in handle.fallBackResource).graphicsResource;
			}
			if (!textureResource.imported)
			{
				throw new InvalidOperationException("Trying to use a texture (" + textureResource.GetName() + ") that was already released or not yet created. Make sure you declare it for reading in your pass or you don't read it before it's been written to at least once.");
			}
		}
		return graphicsResource;
	}

	internal bool TextureNeedsFallback(in TextureHandle handle)
	{
		if (!handle.IsValid())
		{
			return false;
		}
		return GetTextureResource(in handle.handle).NeedsFallBack();
	}

	internal UnityEngine.Rendering.RendererUtils.RendererList GetRendererList(in RendererListHandle handle)
	{
		if (!handle.IsValid() || (int)handle >= m_RendererListResources.size)
		{
			return UnityEngine.Rendering.RendererUtils.RendererList.nullRendererList;
		}
		return m_RendererListResources[handle].rendererList;
	}

	internal ComputeBuffer GetComputeBuffer(in ComputeBufferHandle handle)
	{
		if (!handle.IsValid())
		{
			return null;
		}
		return GetComputeBufferResource(in handle.handle).graphicsResource ?? throw new InvalidOperationException("Trying to use a compute buffer ({bufferResource.GetName()}) that was already released or not yet created. Make sure you declare it for reading in your pass or you don't read it before it's been written to at least once.");
	}

	private RenderGraphResourceRegistry()
	{
	}

	internal RenderGraphResourceRegistry(RenderGraphDebugParams renderGraphDebug, RenderGraphLogger frameInformationLogger)
	{
		m_RenderGraphDebug = renderGraphDebug;
		m_FrameInformationLogger = frameInformationLogger;
		for (int i = 0; i < 2; i++)
		{
			m_RenderGraphResources[i] = new RenderGraphResourcesData();
		}
		m_RenderGraphResources[0].createResourceCallback = CreateTextureCallback;
		m_RenderGraphResources[0].releaseResourceCallback = ReleaseTextureCallback;
		m_RenderGraphResources[0].pool = new TexturePool();
		m_RenderGraphResources[1].pool = new ComputeBufferPool();
	}

	internal void BeginRenderGraph(int executionCount)
	{
		m_ExecutionCount = executionCount;
		ResourceHandle.NewFrame(executionCount);
		if (m_RenderGraphDebug.enableLogging)
		{
			m_ResourceLogger.Initialize("RenderGraph Resources");
		}
	}

	internal void BeginExecute(int currentFrameIndex)
	{
		m_CurrentFrameIndex = currentFrameIndex;
		ManageSharedRenderGraphResources();
		current = this;
	}

	internal void EndExecute()
	{
		current = null;
	}

	private void CheckHandleValidity(in ResourceHandle res)
	{
		CheckHandleValidity(res.type, res.index);
	}

	private void CheckHandleValidity(RenderGraphResourceType type, int index)
	{
		DynamicArray<IRenderGraphResource> resourceArray = m_RenderGraphResources[(int)type].resourceArray;
		if (index >= resourceArray.size)
		{
			throw new ArgumentException($"Trying to access resource of type {type} with an invalid resource index {index}");
		}
	}

	internal void IncrementWriteCount(in ResourceHandle res)
	{
		CheckHandleValidity(in res);
		m_RenderGraphResources[res.iType].resourceArray[res.index].IncrementWriteCount();
	}

	internal string GetRenderGraphResourceName(in ResourceHandle res)
	{
		CheckHandleValidity(in res);
		return m_RenderGraphResources[res.iType].resourceArray[res.index].GetName();
	}

	internal string GetRenderGraphResourceName(RenderGraphResourceType type, int index)
	{
		CheckHandleValidity(type, index);
		return m_RenderGraphResources[(int)type].resourceArray[index].GetName();
	}

	internal bool IsRenderGraphResourceImported(in ResourceHandle res)
	{
		CheckHandleValidity(in res);
		return m_RenderGraphResources[res.iType].resourceArray[res.index].imported;
	}

	internal bool IsRenderGraphResourceShared(RenderGraphResourceType type, int index)
	{
		CheckHandleValidity(type, index);
		return index < m_RenderGraphResources[(int)type].sharedResourcesCount;
	}

	internal bool IsGraphicsResourceCreated(in ResourceHandle res)
	{
		CheckHandleValidity(in res);
		return m_RenderGraphResources[res.iType].resourceArray[res.index].IsCreated();
	}

	internal bool IsRendererListCreated(in RendererListHandle res)
	{
		return m_RendererListResources[res].rendererList.isValid;
	}

	internal bool IsRenderGraphResourceImported(RenderGraphResourceType type, int index)
	{
		CheckHandleValidity(type, index);
		return m_RenderGraphResources[(int)type].resourceArray[index].imported;
	}

	internal int GetRenderGraphResourceTransientIndex(in ResourceHandle res)
	{
		CheckHandleValidity(in res);
		return m_RenderGraphResources[res.iType].resourceArray[res.index].transientPassIndex;
	}

	internal TextureHandle ImportTexture(RTHandle rt)
	{
		int handle = m_RenderGraphResources[0].AddNewRenderGraphResource<TextureResource>(out var outRes);
		outRes.graphicsResource = rt;
		outRes.imported = true;
		return new TextureHandle(handle);
	}

	internal TextureHandle CreateSharedTexture(in TextureDesc desc, bool explicitRelease)
	{
		RenderGraphResourcesData renderGraphResourcesData = m_RenderGraphResources[0];
		int sharedResourcesCount = renderGraphResourcesData.sharedResourcesCount;
		TextureResource outRes = null;
		int handle = -1;
		for (int i = 0; i < sharedResourcesCount; i++)
		{
			if (!renderGraphResourcesData.resourceArray[i].shared)
			{
				outRes = (TextureResource)renderGraphResourcesData.resourceArray[i];
				handle = i;
				break;
			}
		}
		if (outRes == null)
		{
			handle = m_RenderGraphResources[0].AddNewRenderGraphResource<TextureResource>(out outRes, pooledResource: false);
			renderGraphResourcesData.sharedResourcesCount++;
		}
		outRes.imported = true;
		outRes.shared = true;
		outRes.sharedExplicitRelease = explicitRelease;
		outRes.desc = desc;
		return new TextureHandle(handle, shared: true);
	}

	internal void ReleaseSharedTexture(TextureHandle texture)
	{
		RenderGraphResourcesData renderGraphResourcesData = m_RenderGraphResources[0];
		if ((int)texture.handle >= renderGraphResourcesData.sharedResourcesCount)
		{
			throw new InvalidOperationException("Tried to release a non shared texture.");
		}
		if ((int)texture.handle == renderGraphResourcesData.sharedResourcesCount - 1)
		{
			renderGraphResourcesData.sharedResourcesCount--;
		}
		TextureResource textureResource = GetTextureResource(in texture.handle);
		textureResource.ReleaseGraphicsResource();
		textureResource.Reset(null);
	}

	internal TextureHandle ImportBackbuffer(RenderTargetIdentifier rt)
	{
		if (m_CurrentBackbuffer != null)
		{
			m_CurrentBackbuffer.SetTexture(rt);
		}
		else
		{
			m_CurrentBackbuffer = RTHandles.Alloc(rt, "Backbuffer");
		}
		int handle = m_RenderGraphResources[0].AddNewRenderGraphResource<TextureResource>(out var outRes);
		outRes.graphicsResource = m_CurrentBackbuffer;
		outRes.imported = true;
		return new TextureHandle(handle);
	}

	internal TextureHandle CreateTexture(in TextureDesc desc, int transientPassIndex = -1)
	{
		ValidateTextureDesc(in desc);
		int handle = m_RenderGraphResources[0].AddNewRenderGraphResource<TextureResource>(out var outRes);
		outRes.desc = desc;
		outRes.transientPassIndex = transientPassIndex;
		outRes.requestFallBack = desc.fallBackToBlackTexture;
		return new TextureHandle(handle);
	}

	internal int GetTextureResourceCount()
	{
		return m_RenderGraphResources[0].resourceArray.size;
	}

	private TextureResource GetTextureResource(in ResourceHandle handle)
	{
		return m_RenderGraphResources[0].resourceArray[handle] as TextureResource;
	}

	internal TextureDesc GetTextureResourceDesc(in ResourceHandle handle)
	{
		return (m_RenderGraphResources[0].resourceArray[handle] as TextureResource).desc;
	}

	internal void ForceTextureClear(in ResourceHandle handle, Color clearColor)
	{
		GetTextureResource(in handle).desc.clearBuffer = true;
		GetTextureResource(in handle).desc.clearColor = clearColor;
	}

	internal RendererListHandle CreateRendererList(in UnityEngine.Rendering.RendererUtils.RendererListDesc desc)
	{
		ValidateRendererListDesc(in desc);
		return new RendererListHandle(m_RendererListResources.Add(new RendererListResource(in desc)));
	}

	internal ComputeBufferHandle ImportComputeBuffer(ComputeBuffer computeBuffer)
	{
		int handle = m_RenderGraphResources[1].AddNewRenderGraphResource<ComputeBufferResource>(out var outRes);
		outRes.graphicsResource = computeBuffer;
		outRes.imported = true;
		return new ComputeBufferHandle(handle);
	}

	internal ComputeBufferHandle CreateComputeBuffer(in ComputeBufferDesc desc, int transientPassIndex = -1)
	{
		ValidateComputeBufferDesc(in desc);
		int handle = m_RenderGraphResources[1].AddNewRenderGraphResource<ComputeBufferResource>(out var outRes);
		outRes.desc = desc;
		outRes.transientPassIndex = transientPassIndex;
		return new ComputeBufferHandle(handle);
	}

	internal ComputeBufferDesc GetComputeBufferResourceDesc(in ResourceHandle handle)
	{
		return (m_RenderGraphResources[1].resourceArray[handle] as ComputeBufferResource).desc;
	}

	internal int GetComputeBufferResourceCount()
	{
		return m_RenderGraphResources[1].resourceArray.size;
	}

	private ComputeBufferResource GetComputeBufferResource(in ResourceHandle handle)
	{
		return m_RenderGraphResources[1].resourceArray[handle] as ComputeBufferResource;
	}

	internal void UpdateSharedResourceLastFrameIndex(int type, int index)
	{
		m_RenderGraphResources[type].resourceArray[index].sharedResourceLastFrameUsed = m_ExecutionCount;
	}

	private void ManageSharedRenderGraphResources()
	{
		for (int i = 0; i < 2; i++)
		{
			RenderGraphResourcesData renderGraphResourcesData = m_RenderGraphResources[i];
			for (int j = 0; j < renderGraphResourcesData.sharedResourcesCount; j++)
			{
				IRenderGraphResource renderGraphResource = m_RenderGraphResources[i].resourceArray[j];
				bool flag = renderGraphResource.IsCreated();
				if (renderGraphResource.sharedResourceLastFrameUsed == m_ExecutionCount && !flag)
				{
					renderGraphResource.CreateGraphicsResource(renderGraphResource.GetName());
				}
				else if (flag && !renderGraphResource.sharedExplicitRelease && renderGraphResource.sharedResourceLastFrameUsed + 30 < m_ExecutionCount)
				{
					renderGraphResource.ReleaseGraphicsResource();
				}
			}
		}
	}

	internal void CreatePooledResource(RenderGraphContext rgContext, int type, int index)
	{
		IRenderGraphResource renderGraphResource = m_RenderGraphResources[type].resourceArray[index];
		if (!renderGraphResource.imported)
		{
			renderGraphResource.CreatePooledGraphicsResource();
			if (m_RenderGraphDebug.enableLogging)
			{
				renderGraphResource.LogCreation(m_FrameInformationLogger);
			}
			m_RenderGraphResources[type].createResourceCallback?.Invoke(rgContext, renderGraphResource);
		}
	}

	private void CreateTextureCallback(RenderGraphContext rgContext, IRenderGraphResource res)
	{
		TextureResource textureResource = res as TextureResource;
		FastMemoryDesc fastMemoryDesc = textureResource.desc.fastMemoryDesc;
		if (fastMemoryDesc.inFastMemory)
		{
			textureResource.graphicsResource.SwitchToFastMemory(rgContext.cmd, fastMemoryDesc.residencyFraction, fastMemoryDesc.flags);
		}
		if (textureResource.desc.clearBuffer || m_RenderGraphDebug.clearRenderTargetsAtCreation)
		{
			bool flag = m_RenderGraphDebug.clearRenderTargetsAtCreation && !textureResource.desc.clearBuffer;
			using (new ProfilingScope(rgContext.cmd, ProfilingSampler.Get(flag ? RenderGraphProfileId.RenderGraphClearDebug : RenderGraphProfileId.RenderGraphClear)))
			{
				ClearFlag clearFlag = ((textureResource.desc.depthBufferBits == DepthBits.None) ? ClearFlag.Color : ClearFlag.DepthStencil);
				Color clearColor = (flag ? Color.magenta : textureResource.desc.clearColor);
				CoreUtils.SetRenderTarget(rgContext.cmd, textureResource.graphicsResource, clearFlag, clearColor);
			}
		}
	}

	internal void ReleasePooledResource(RenderGraphContext rgContext, int type, int index)
	{
		IRenderGraphResource renderGraphResource = m_RenderGraphResources[type].resourceArray[index];
		if (!renderGraphResource.imported)
		{
			m_RenderGraphResources[type].releaseResourceCallback?.Invoke(rgContext, renderGraphResource);
			if (m_RenderGraphDebug.enableLogging)
			{
				renderGraphResource.LogRelease(m_FrameInformationLogger);
			}
			renderGraphResource.ReleasePooledGraphicsResource(m_CurrentFrameIndex);
		}
	}

	private void ReleaseTextureCallback(RenderGraphContext rgContext, IRenderGraphResource res)
	{
		TextureResource textureResource = res as TextureResource;
		if (m_RenderGraphDebug.clearRenderTargetsAtRelease)
		{
			using (new ProfilingScope(rgContext.cmd, ProfilingSampler.Get(RenderGraphProfileId.RenderGraphClearDebug)))
			{
				ClearFlag clearFlag = ((textureResource.desc.depthBufferBits == DepthBits.None) ? ClearFlag.Color : ClearFlag.DepthStencil);
				CoreUtils.SetRenderTarget(rgContext.cmd, textureResource.graphicsResource, clearFlag, Color.magenta);
			}
		}
	}

	private void ValidateTextureDesc(in TextureDesc desc)
	{
	}

	private void ValidateRendererListDesc(in UnityEngine.Rendering.RendererUtils.RendererListDesc desc)
	{
	}

	private void ValidateComputeBufferDesc(in ComputeBufferDesc desc)
	{
	}

	internal void CreateRendererLists(List<RendererListHandle> rendererLists, ScriptableRenderContext context, bool manualDispatch = false)
	{
		m_ActiveRendererLists.Clear();
		foreach (RendererListHandle rendererList in rendererLists)
		{
			ref RendererListResource reference = ref m_RendererListResources[rendererList];
			reference.rendererList = context.CreateRendererList(reference.desc);
			m_ActiveRendererLists.Add(reference.rendererList);
		}
		if (manualDispatch)
		{
			context.PrepareRendererListsAsync(m_ActiveRendererLists);
		}
	}

	internal void Clear(bool onException)
	{
		LogResources();
		for (int i = 0; i < 2; i++)
		{
			m_RenderGraphResources[i].Clear(onException, m_CurrentFrameIndex);
		}
		m_RendererListResources.Clear();
		m_ActiveRendererLists.Clear();
	}

	internal void PurgeUnusedGraphicsResources()
	{
		for (int i = 0; i < 2; i++)
		{
			m_RenderGraphResources[i].PurgeUnusedGraphicsResources(m_CurrentFrameIndex);
		}
	}

	internal void Cleanup()
	{
		for (int i = 0; i < 2; i++)
		{
			m_RenderGraphResources[i].Cleanup();
		}
		RTHandles.Release(m_CurrentBackbuffer);
	}

	internal void FlushLogs()
	{
		Debug.Log(m_ResourceLogger.GetAllLogs());
	}

	private void LogResources()
	{
		if (m_RenderGraphDebug.enableLogging)
		{
			m_ResourceLogger.LogLine("==== Allocated Resources ====\n");
			for (int i = 0; i < 2; i++)
			{
				m_RenderGraphResources[i].pool.LogResources(m_ResourceLogger);
				m_ResourceLogger.LogLine("");
			}
		}
	}
}
