using System;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine.Rendering;
using UnityEngine.Rendering.RendererUtils;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public class RenderGraph
{
	internal struct CompiledResourceInfo
	{
		public List<int> producers;

		public List<int> consumers;

		public int refCount;

		public bool imported;

		public void Reset()
		{
			if (producers == null)
			{
				producers = new List<int>();
			}
			if (consumers == null)
			{
				consumers = new List<int>();
			}
			producers.Clear();
			consumers.Clear();
			refCount = 0;
			imported = false;
		}
	}

	[DebuggerDisplay("RenderPass: {pass.name} (Index:{pass.index} Async:{enableAsyncCompute})")]
	internal struct CompiledPassInfo
	{
		public RenderGraphPass pass;

		public List<int>[] resourceCreateList;

		public List<int>[] resourceReleaseList;

		public int refCount;

		public bool culled;

		public bool hasSideEffect;

		public int syncToPassIndex;

		public int syncFromPassIndex;

		public bool needGraphicsFence;

		public GraphicsFence fence;

		public bool enableAsyncCompute;

		public bool allowPassCulling => pass.allowPassCulling;

		public void Reset(RenderGraphPass pass)
		{
			this.pass = pass;
			enableAsyncCompute = pass.enableAsyncCompute;
			if (resourceCreateList == null)
			{
				resourceCreateList = new List<int>[2];
				resourceReleaseList = new List<int>[2];
				for (int i = 0; i < 2; i++)
				{
					resourceCreateList[i] = new List<int>();
					resourceReleaseList[i] = new List<int>();
				}
			}
			for (int j = 0; j < 2; j++)
			{
				resourceCreateList[j].Clear();
				resourceReleaseList[j].Clear();
			}
			refCount = 0;
			culled = false;
			hasSideEffect = false;
			syncToPassIndex = -1;
			syncFromPassIndex = -1;
			needGraphicsFence = false;
		}
	}

	private class ProfilingScopePassData
	{
		public ProfilingSampler sampler;
	}

	internal delegate void OnGraphRegisteredDelegate(RenderGraph graph);

	internal delegate void OnExecutionRegisteredDelegate(RenderGraph graph, string executionName);

	public static readonly int kMaxMRTCount = 8;

	private RenderGraphResourceRegistry m_Resources;

	private RenderGraphObjectPool m_RenderGraphPool = new RenderGraphObjectPool();

	private List<RenderGraphPass> m_RenderPasses = new List<RenderGraphPass>(64);

	private List<RendererListHandle> m_RendererLists = new List<RendererListHandle>(32);

	private RenderGraphDebugParams m_DebugParameters = new RenderGraphDebugParams();

	private RenderGraphLogger m_FrameInformationLogger = new RenderGraphLogger();

	private RenderGraphDefaultResources m_DefaultResources = new RenderGraphDefaultResources();

	private Dictionary<int, ProfilingSampler> m_DefaultProfilingSamplers = new Dictionary<int, ProfilingSampler>();

	private bool m_ExecutionExceptionWasRaised;

	private RenderGraphContext m_RenderGraphContext = new RenderGraphContext();

	private CommandBuffer m_PreviousCommandBuffer;

	private int m_CurrentImmediatePassIndex;

	private List<int>[] m_ImmediateModeResourceList = new List<int>[2];

	private DynamicArray<CompiledResourceInfo>[] m_CompiledResourcesInfos = new DynamicArray<CompiledResourceInfo>[2];

	private DynamicArray<CompiledPassInfo> m_CompiledPassInfos = new DynamicArray<CompiledPassInfo>();

	private Stack<int> m_CullingStack = new Stack<int>();

	private int m_ExecutionCount;

	private int m_CurrentFrameIndex;

	private bool m_HasRenderGraphBegun;

	private string m_CurrentExecutionName;

	private bool m_RendererListCulling;

	private Dictionary<string, RenderGraphDebugData> m_DebugData = new Dictionary<string, RenderGraphDebugData>();

	private static List<RenderGraph> s_RegisteredGraphs = new List<RenderGraph>();

	public string name { get; private set; } = "RenderGraph";

	internal static bool requireDebugData { get; set; } = false;

	public RenderGraphDefaultResources defaultResources => m_DefaultResources;

	internal static event OnGraphRegisteredDelegate onGraphRegistered;

	internal static event OnGraphRegisteredDelegate onGraphUnregistered;

	internal static event OnExecutionRegisteredDelegate onExecutionRegistered;

	internal static event OnExecutionRegisteredDelegate onExecutionUnregistered;

	public RenderGraph(string name = "RenderGraph")
	{
		this.name = name;
		m_Resources = new RenderGraphResourceRegistry(m_DebugParameters, m_FrameInformationLogger);
		for (int i = 0; i < 2; i++)
		{
			m_CompiledResourcesInfos[i] = new DynamicArray<CompiledResourceInfo>();
		}
		s_RegisteredGraphs.Add(this);
		onGraphRegistered?.Invoke(this);
	}

	public void Cleanup()
	{
		m_Resources.Cleanup();
		m_DefaultResources.Cleanup();
		m_RenderGraphPool.Cleanup();
		s_RegisteredGraphs.Remove(this);
		onGraphUnregistered?.Invoke(this);
	}

	public void RegisterDebug(DebugUI.Panel panel = null)
	{
		m_DebugParameters.RegisterDebug(name, panel);
	}

	public void UnRegisterDebug()
	{
		m_DebugParameters.UnRegisterDebug(name);
	}

	public static List<RenderGraph> GetRegisteredRenderGraphs()
	{
		return s_RegisteredGraphs;
	}

	internal RenderGraphDebugData GetDebugData(string executionName)
	{
		if (m_DebugData.TryGetValue(executionName, out var value))
		{
			return value;
		}
		return null;
	}

	public void EndFrame()
	{
		m_Resources.PurgeUnusedGraphicsResources();
		if (m_DebugParameters.logFrameInformation)
		{
			Debug.Log(m_FrameInformationLogger.GetAllLogs());
			m_DebugParameters.logFrameInformation = false;
		}
		if (m_DebugParameters.logResources)
		{
			m_Resources.FlushLogs();
			m_DebugParameters.logResources = false;
		}
	}

	public TextureHandle ImportTexture(RTHandle rt)
	{
		return m_Resources.ImportTexture(rt);
	}

	public TextureHandle ImportBackbuffer(RenderTargetIdentifier rt)
	{
		return m_Resources.ImportBackbuffer(rt);
	}

	public TextureHandle CreateTexture(in TextureDesc desc)
	{
		return m_Resources.CreateTexture(in desc);
	}

	public TextureHandle CreateSharedTexture(in TextureDesc desc, bool explicitRelease = false)
	{
		if (m_HasRenderGraphBegun)
		{
			throw new InvalidOperationException("A shared texture can only be created outside of render graph execution.");
		}
		return m_Resources.CreateSharedTexture(in desc, explicitRelease);
	}

	public void ReleaseSharedTexture(TextureHandle texture)
	{
		if (m_HasRenderGraphBegun)
		{
			throw new InvalidOperationException("A shared texture can only be release outside of render graph execution.");
		}
		m_Resources.ReleaseSharedTexture(texture);
	}

	public TextureHandle CreateTexture(TextureHandle texture)
	{
		return m_Resources.CreateTexture(m_Resources.GetTextureResourceDesc(in texture.handle));
	}

	public void CreateTextureIfInvalid(in TextureDesc desc, ref TextureHandle texture)
	{
		if (!texture.IsValid())
		{
			texture = m_Resources.CreateTexture(in desc);
		}
	}

	public TextureDesc GetTextureDesc(TextureHandle texture)
	{
		return m_Resources.GetTextureResourceDesc(in texture.handle);
	}

	public RendererListHandle CreateRendererList(in UnityEngine.Rendering.RendererUtils.RendererListDesc desc)
	{
		return m_Resources.CreateRendererList(in desc);
	}

	public ComputeBufferHandle ImportComputeBuffer(ComputeBuffer computeBuffer)
	{
		return m_Resources.ImportComputeBuffer(computeBuffer);
	}

	public ComputeBufferHandle CreateComputeBuffer(in ComputeBufferDesc desc)
	{
		return m_Resources.CreateComputeBuffer(in desc);
	}

	public ComputeBufferHandle CreateComputeBuffer(in ComputeBufferHandle computeBuffer)
	{
		return m_Resources.CreateComputeBuffer(m_Resources.GetComputeBufferResourceDesc(in computeBuffer.handle));
	}

	public ComputeBufferDesc GetComputeBufferDesc(in ComputeBufferHandle computeBuffer)
	{
		return m_Resources.GetComputeBufferResourceDesc(in computeBuffer.handle);
	}

	public RenderGraphBuilder AddRenderPass<PassData>(string passName, out PassData passData, ProfilingSampler sampler) where PassData : class, new()
	{
		RenderGraphPass<PassData> renderGraphPass = m_RenderGraphPool.Get<RenderGraphPass<PassData>>();
		renderGraphPass.Initialize(m_RenderPasses.Count, m_RenderGraphPool.Get<PassData>(), passName, sampler);
		passData = renderGraphPass.data;
		m_RenderPasses.Add(renderGraphPass);
		return new RenderGraphBuilder(renderGraphPass, m_Resources, this);
	}

	public RenderGraphBuilder AddRenderPass<PassData>(string passName, out PassData passData) where PassData : class, new()
	{
		return AddRenderPass<PassData>(passName, out passData, GetDefaultProfilingSampler(passName));
	}

	public RenderGraphExecution RecordAndExecute(in RenderGraphParameters parameters)
	{
		m_CurrentFrameIndex = parameters.currentFrameIndex;
		m_CurrentExecutionName = ((parameters.executionName != null) ? parameters.executionName : "RenderGraphExecution");
		m_HasRenderGraphBegun = true;
		m_Resources.BeginRenderGraph(m_ExecutionCount++);
		if (m_DebugParameters.enableLogging)
		{
			m_FrameInformationLogger.Initialize(m_CurrentExecutionName);
		}
		m_DefaultResources.InitializeForRendering(this);
		m_RenderGraphContext.cmd = parameters.commandBuffer;
		m_RenderGraphContext.renderContext = parameters.scriptableRenderContext;
		m_RenderGraphContext.renderGraphPool = m_RenderGraphPool;
		m_RenderGraphContext.defaultResources = m_DefaultResources;
		if (m_DebugParameters.immediateMode)
		{
			LogFrameInformation();
			m_CompiledPassInfos.Resize(m_CompiledPassInfos.capacity);
			m_CurrentImmediatePassIndex = 0;
			for (int i = 0; i < 2; i++)
			{
				if (m_ImmediateModeResourceList[i] == null)
				{
					m_ImmediateModeResourceList[i] = new List<int>();
				}
				m_ImmediateModeResourceList[i].Clear();
			}
			m_Resources.BeginExecute(m_CurrentFrameIndex);
		}
		return new RenderGraphExecution(this);
	}

	internal void Execute()
	{
		m_ExecutionExceptionWasRaised = false;
		try
		{
			if (m_RenderGraphContext.cmd == null)
			{
				throw new InvalidOperationException("RenderGraph.RecordAndExecute was not called before executing the render graph.");
			}
			if (!m_DebugParameters.immediateMode)
			{
				LogFrameInformation();
				CompileRenderGraph();
				m_Resources.BeginExecute(m_CurrentFrameIndex);
				ExecuteRenderGraph();
			}
		}
		catch (Exception exception)
		{
			Debug.LogError("Render Graph Execution error");
			if (!m_ExecutionExceptionWasRaised)
			{
				Debug.LogException(exception);
			}
			m_ExecutionExceptionWasRaised = true;
		}
		finally
		{
			GenerateDebugData();
			if (m_DebugParameters.immediateMode)
			{
				ReleaseImmediateModeResources();
			}
			ClearCompiledGraph();
			m_Resources.EndExecute();
			InvalidateContext();
			m_HasRenderGraphBegun = false;
		}
	}

	public void BeginProfilingSampler(ProfilingSampler sampler)
	{
		ProfilingScopePassData passData;
		using RenderGraphBuilder renderGraphBuilder = AddRenderPass<ProfilingScopePassData>("BeginProfile", out passData, null);
		passData.sampler = sampler;
		renderGraphBuilder.AllowPassCulling(value: false);
		renderGraphBuilder.GenerateDebugData(value: false);
		renderGraphBuilder.SetRenderFunc(delegate(ProfilingScopePassData data, RenderGraphContext ctx)
		{
			data.sampler.Begin(ctx.cmd);
		});
	}

	public void EndProfilingSampler(ProfilingSampler sampler)
	{
		ProfilingScopePassData passData;
		using RenderGraphBuilder renderGraphBuilder = AddRenderPass<ProfilingScopePassData>("EndProfile", out passData, null);
		passData.sampler = sampler;
		renderGraphBuilder.AllowPassCulling(value: false);
		renderGraphBuilder.GenerateDebugData(value: false);
		renderGraphBuilder.SetRenderFunc(delegate(ProfilingScopePassData data, RenderGraphContext ctx)
		{
			data.sampler.End(ctx.cmd);
		});
	}

	internal DynamicArray<CompiledPassInfo> GetCompiledPassInfos()
	{
		return m_CompiledPassInfos;
	}

	internal void ClearCompiledGraph()
	{
		ClearRenderPasses();
		m_Resources.Clear(m_ExecutionExceptionWasRaised);
		m_RendererLists.Clear();
		for (int i = 0; i < 2; i++)
		{
			m_CompiledResourcesInfos[i].Clear();
		}
		m_CompiledPassInfos.Clear();
	}

	private void InvalidateContext()
	{
		m_RenderGraphContext.cmd = null;
		m_RenderGraphContext.renderGraphPool = null;
		m_RenderGraphContext.defaultResources = null;
	}

	internal void OnPassAdded(RenderGraphPass pass)
	{
		if (m_DebugParameters.immediateMode)
		{
			ExecutePassImmediatly(pass);
		}
	}

	private void InitResourceInfosData(DynamicArray<CompiledResourceInfo> resourceInfos, int count)
	{
		resourceInfos.Resize(count);
		for (int i = 0; i < resourceInfos.size; i++)
		{
			resourceInfos[i].Reset();
		}
	}

	private void InitializeCompilationData()
	{
		InitResourceInfosData(m_CompiledResourcesInfos[0], m_Resources.GetTextureResourceCount());
		InitResourceInfosData(m_CompiledResourcesInfos[1], m_Resources.GetComputeBufferResourceCount());
		m_CompiledPassInfos.Resize(m_RenderPasses.Count);
		for (int i = 0; i < m_CompiledPassInfos.size; i++)
		{
			m_CompiledPassInfos[i].Reset(m_RenderPasses[i]);
		}
	}

	private void CountReferences()
	{
		for (int i = 0; i < m_CompiledPassInfos.size; i++)
		{
			ref CompiledPassInfo reference = ref m_CompiledPassInfos[i];
			for (int j = 0; j < 2; j++)
			{
				foreach (ResourceHandle item in reference.pass.resourceReadLists[j])
				{
					ResourceHandle res = item;
					ref CompiledResourceInfo reference2 = ref m_CompiledResourcesInfos[j][res];
					reference2.imported = m_Resources.IsRenderGraphResourceImported(in res);
					reference2.consumers.Add(i);
					reference2.refCount++;
				}
				foreach (ResourceHandle item2 in reference.pass.resourceWriteLists[j])
				{
					ResourceHandle res2 = item2;
					ref CompiledResourceInfo reference3 = ref m_CompiledResourcesInfos[j][res2];
					reference3.imported = m_Resources.IsRenderGraphResourceImported(in res2);
					reference3.producers.Add(i);
					reference.hasSideEffect = reference3.imported;
					reference.refCount++;
				}
				foreach (ResourceHandle item3 in reference.pass.transientResourceList[j])
				{
					int index = item3;
					ref CompiledResourceInfo reference4 = ref m_CompiledResourcesInfos[j][index];
					reference4.refCount++;
					reference4.consumers.Add(i);
					reference4.producers.Add(i);
				}
			}
		}
	}

	private void CullUnusedPasses()
	{
		if (m_DebugParameters.disablePassCulling)
		{
			if (m_DebugParameters.enableLogging)
			{
				m_FrameInformationLogger.LogLine("- Pass Culling Disabled -\n");
			}
			return;
		}
		for (int i = 0; i < 2; i++)
		{
			DynamicArray<CompiledResourceInfo> dynamicArray = m_CompiledResourcesInfos[i];
			m_CullingStack.Clear();
			for (int j = 0; j < dynamicArray.size; j++)
			{
				if (dynamicArray[j].refCount == 0)
				{
					m_CullingStack.Push(j);
				}
			}
			while (m_CullingStack.Count != 0)
			{
				foreach (int producer in dynamicArray[m_CullingStack.Pop()].producers)
				{
					ref CompiledPassInfo reference = ref m_CompiledPassInfos[producer];
					reference.refCount--;
					if (reference.refCount != 0 || reference.hasSideEffect || !reference.allowPassCulling)
					{
						continue;
					}
					reference.culled = true;
					foreach (ResourceHandle item in reference.pass.resourceReadLists[i])
					{
						ref CompiledResourceInfo reference2 = ref dynamicArray[item];
						reference2.refCount--;
						if (reference2.refCount == 0)
						{
							m_CullingStack.Push(item);
						}
					}
				}
			}
		}
		LogCulledPasses();
	}

	private void UpdatePassSynchronization(ref CompiledPassInfo currentPassInfo, ref CompiledPassInfo producerPassInfo, int currentPassIndex, int lastProducer, ref int intLastSyncIndex)
	{
		currentPassInfo.syncToPassIndex = lastProducer;
		intLastSyncIndex = lastProducer;
		producerPassInfo.needGraphicsFence = true;
		if (producerPassInfo.syncFromPassIndex == -1)
		{
			producerPassInfo.syncFromPassIndex = currentPassIndex;
		}
	}

	private void UpdateResourceSynchronization(ref int lastGraphicsPipeSync, ref int lastComputePipeSync, int currentPassIndex, in CompiledResourceInfo resource)
	{
		int latestProducerIndex = GetLatestProducerIndex(currentPassIndex, in resource);
		if (latestProducerIndex == -1)
		{
			return;
		}
		ref CompiledPassInfo reference = ref m_CompiledPassInfos[currentPassIndex];
		if (m_CompiledPassInfos[latestProducerIndex].enableAsyncCompute == reference.enableAsyncCompute)
		{
			return;
		}
		if (reference.enableAsyncCompute)
		{
			if (latestProducerIndex > lastGraphicsPipeSync)
			{
				UpdatePassSynchronization(ref reference, ref m_CompiledPassInfos[latestProducerIndex], currentPassIndex, latestProducerIndex, ref lastGraphicsPipeSync);
			}
		}
		else if (latestProducerIndex > lastComputePipeSync)
		{
			UpdatePassSynchronization(ref reference, ref m_CompiledPassInfos[latestProducerIndex], currentPassIndex, latestProducerIndex, ref lastComputePipeSync);
		}
	}

	private int GetLatestProducerIndex(int passIndex, in CompiledResourceInfo info)
	{
		int result = -1;
		foreach (int producer in info.producers)
		{
			if (producer < passIndex)
			{
				result = producer;
				continue;
			}
			return result;
		}
		return result;
	}

	private int GetLatestValidReadIndex(in CompiledResourceInfo info)
	{
		if (info.consumers.Count == 0)
		{
			return -1;
		}
		List<int> consumers = info.consumers;
		for (int num = consumers.Count - 1; num >= 0; num--)
		{
			if (!m_CompiledPassInfos[consumers[num]].culled)
			{
				return consumers[num];
			}
		}
		return -1;
	}

	private int GetFirstValidWriteIndex(in CompiledResourceInfo info)
	{
		if (info.producers.Count == 0)
		{
			return -1;
		}
		List<int> producers = info.producers;
		for (int i = 0; i < producers.Count; i++)
		{
			if (!m_CompiledPassInfos[producers[i]].culled)
			{
				return producers[i];
			}
		}
		return -1;
	}

	private int GetLatestValidWriteIndex(in CompiledResourceInfo info)
	{
		if (info.producers.Count == 0)
		{
			return -1;
		}
		List<int> producers = info.producers;
		for (int num = producers.Count - 1; num >= 0; num--)
		{
			if (!m_CompiledPassInfos[producers[num]].culled)
			{
				return producers[num];
			}
		}
		return -1;
	}

	private void CreateRendererLists()
	{
		for (int i = 0; i < m_CompiledPassInfos.size; i++)
		{
			ref CompiledPassInfo reference = ref m_CompiledPassInfos[i];
			if (!reference.culled)
			{
				m_RendererLists.AddRange(reference.pass.usedRendererListList);
			}
		}
		m_Resources.CreateRendererLists(m_RendererLists, m_RenderGraphContext.renderContext, m_RendererListCulling);
	}

	private void UpdateResourceAllocationAndSynchronization()
	{
		int lastGraphicsPipeSync = -1;
		int lastComputePipeSync = -1;
		for (int i = 0; i < m_CompiledPassInfos.size; i++)
		{
			ref CompiledPassInfo reference = ref m_CompiledPassInfos[i];
			if (reference.culled)
			{
				continue;
			}
			for (int j = 0; j < 2; j++)
			{
				DynamicArray<CompiledResourceInfo> dynamicArray = m_CompiledResourcesInfos[j];
				foreach (ResourceHandle item in reference.pass.resourceReadLists[j])
				{
					int index = item;
					UpdateResourceSynchronization(ref lastGraphicsPipeSync, ref lastComputePipeSync, i, in dynamicArray[index]);
				}
				foreach (ResourceHandle item2 in reference.pass.resourceWriteLists[j])
				{
					int index2 = item2;
					UpdateResourceSynchronization(ref lastGraphicsPipeSync, ref lastComputePipeSync, i, in dynamicArray[index2]);
				}
			}
		}
		for (int k = 0; k < 2; k++)
		{
			DynamicArray<CompiledResourceInfo> dynamicArray2 = m_CompiledResourcesInfos[k];
			for (int l = 0; l < dynamicArray2.size; l++)
			{
				CompiledResourceInfo info = dynamicArray2[l];
				bool flag = m_Resources.IsRenderGraphResourceShared((RenderGraphResourceType)k, l);
				if (info.imported && !flag)
				{
					continue;
				}
				int firstValidWriteIndex = GetFirstValidWriteIndex(in info);
				if (firstValidWriteIndex != -1)
				{
					m_CompiledPassInfos[firstValidWriteIndex].resourceCreateList[k].Add(l);
				}
				int latestValidReadIndex = GetLatestValidReadIndex(in info);
				int latestValidWriteIndex = GetLatestValidWriteIndex(in info);
				int num = ((firstValidWriteIndex != -1 || info.imported) ? Math.Max(latestValidWriteIndex, latestValidReadIndex) : (-1));
				if (num != -1)
				{
					if (m_CompiledPassInfos[num].enableAsyncCompute)
					{
						int num2 = num;
						int num3 = m_CompiledPassInfos[num2].syncFromPassIndex;
						while (num3 == -1 && num2++ < m_CompiledPassInfos.size - 1)
						{
							if (m_CompiledPassInfos[num2].enableAsyncCompute)
							{
								num3 = m_CompiledPassInfos[num2].syncFromPassIndex;
							}
						}
						if (num2 == m_CompiledPassInfos.size)
						{
							if (!m_CompiledPassInfos[num].hasSideEffect)
							{
								RenderGraphPass renderGraphPass = m_RenderPasses[num];
								string arg = "<unknown>";
								throw new InvalidOperationException($"{(RenderGraphResourceType)k} resource '{arg}' in asynchronous pass '{renderGraphPass.name}' is missing synchronization on the graphics pipeline.");
							}
							num3 = num2;
						}
						int num4 = Math.Max(0, num3 - 1);
						while (m_CompiledPassInfos[num4].culled)
						{
							num4 = Math.Max(0, num4 - 1);
						}
						m_CompiledPassInfos[num4].resourceReleaseList[k].Add(l);
					}
					else
					{
						m_CompiledPassInfos[num].resourceReleaseList[k].Add(l);
					}
				}
				if (flag && (firstValidWriteIndex != -1 || num != -1))
				{
					m_Resources.UpdateSharedResourceLastFrameIndex(k, l);
				}
			}
		}
	}

	private bool AreRendererListsEmpty(List<RendererListHandle> rendererLists)
	{
		foreach (RendererListHandle rendererList2 in rendererLists)
		{
			RendererListHandle handle = rendererList2;
			UnityEngine.Rendering.RendererUtils.RendererList rendererList = m_Resources.GetRendererList(in handle);
			if (m_RenderGraphContext.renderContext.QueryRendererListStatus(rendererList) == RendererListStatus.kRendererListPopulated)
			{
				return false;
			}
		}
		if (rendererLists.Count <= 0)
		{
			return false;
		}
		return true;
	}

	private void TryCullPassAtIndex(int passIndex)
	{
		RenderGraphPass pass = m_CompiledPassInfos[passIndex].pass;
		if (!m_CompiledPassInfos[passIndex].culled && pass.allowPassCulling && pass.allowRendererListCulling && !m_CompiledPassInfos[passIndex].hasSideEffect && (AreRendererListsEmpty(pass.usedRendererListList) || AreRendererListsEmpty(pass.dependsOnRendererListList)))
		{
			m_CompiledPassInfos[passIndex].culled = true;
		}
	}

	private void CullRendererLists()
	{
		for (int i = 0; i < m_CompiledPassInfos.size; i++)
		{
			if (!m_CompiledPassInfos[i].culled && !m_CompiledPassInfos[i].hasSideEffect)
			{
				RenderGraphPass pass = m_CompiledPassInfos[i].pass;
				if (pass.usedRendererListList.Count > 0 || pass.dependsOnRendererListList.Count > 0)
				{
					TryCullPassAtIndex(i);
				}
			}
		}
	}

	internal void CompileRenderGraph()
	{
		using (new ProfilingScope(m_RenderGraphContext.cmd, ProfilingSampler.Get(RenderGraphProfileId.CompileRenderGraph)))
		{
			InitializeCompilationData();
			CountReferences();
			CullUnusedPasses();
			CreateRendererLists();
			if (m_RendererListCulling)
			{
				CullRendererLists();
			}
			UpdateResourceAllocationAndSynchronization();
			LogRendererListsCreation();
		}
	}

	private ref CompiledPassInfo CompilePassImmediatly(RenderGraphPass pass)
	{
		if (m_CurrentImmediatePassIndex >= m_CompiledPassInfos.size)
		{
			m_CompiledPassInfos.Resize(m_CompiledPassInfos.size * 2);
		}
		ref CompiledPassInfo reference = ref m_CompiledPassInfos[m_CurrentImmediatePassIndex++];
		reference.Reset(pass);
		reference.enableAsyncCompute = false;
		for (int i = 0; i < 2; i++)
		{
			foreach (ResourceHandle item in pass.resourceWriteLists[i])
			{
				ResourceHandle res = item;
				if (!m_Resources.IsGraphicsResourceCreated(in res))
				{
					reference.resourceCreateList[i].Add(res);
					m_ImmediateModeResourceList[i].Add(res);
				}
			}
			foreach (ResourceHandle item2 in pass.transientResourceList[i])
			{
				reference.resourceCreateList[i].Add(item2);
				reference.resourceReleaseList[i].Add(item2);
			}
			foreach (ResourceHandle item3 in pass.resourceReadLists[i])
			{
				_ = item3;
			}
		}
		foreach (RendererListHandle usedRendererList in pass.usedRendererListList)
		{
			RendererListHandle res2 = usedRendererList;
			if (!m_Resources.IsRendererListCreated(in res2))
			{
				m_RendererLists.Add(res2);
			}
		}
		m_Resources.CreateRendererLists(m_RendererLists, m_RenderGraphContext.renderContext);
		m_RendererLists.Clear();
		return ref reference;
	}

	private void ExecutePassImmediatly(RenderGraphPass pass)
	{
		ExecuteCompiledPass(ref CompilePassImmediatly(pass), m_CurrentImmediatePassIndex - 1);
	}

	private void ExecuteCompiledPass(ref CompiledPassInfo passInfo, int passIndex)
	{
		if (passInfo.culled)
		{
			return;
		}
		if (!passInfo.pass.HasRenderFunc())
		{
			throw new InvalidOperationException($"RenderPass {passInfo.pass.name} was not provided with an execute function.");
		}
		try
		{
			using (new ProfilingScope(m_RenderGraphContext.cmd, passInfo.pass.customSampler))
			{
				LogRenderPassBegin(in passInfo);
				using (new RenderGraphLogIndent(m_FrameInformationLogger))
				{
					PreRenderPassExecute(in passInfo, m_RenderGraphContext);
					passInfo.pass.Execute(m_RenderGraphContext);
					PostRenderPassExecute(ref passInfo, m_RenderGraphContext);
				}
			}
		}
		catch (Exception exception)
		{
			m_ExecutionExceptionWasRaised = true;
			Debug.LogError($"Render Graph Execution error at pass {passInfo.pass.name} ({passIndex})");
			Debug.LogException(exception);
			throw;
		}
	}

	private void ExecuteRenderGraph()
	{
		using (new ProfilingScope(m_RenderGraphContext.cmd, ProfilingSampler.Get(RenderGraphProfileId.ExecuteRenderGraph)))
		{
			for (int i = 0; i < m_CompiledPassInfos.size; i++)
			{
				ExecuteCompiledPass(ref m_CompiledPassInfos[i], i);
			}
		}
	}

	private void PreRenderPassSetRenderTargets(in CompiledPassInfo passInfo, RenderGraphContext rgContext)
	{
		RenderGraphPass pass = passInfo.pass;
		if (!pass.depthBuffer.IsValid() && pass.colorBufferMaxIndex == -1)
		{
			return;
		}
		RenderTargetIdentifier[] tempArray = rgContext.renderGraphPool.GetTempArray<RenderTargetIdentifier>(pass.colorBufferMaxIndex + 1);
		TextureHandle[] colorBuffers = pass.colorBuffers;
		if (pass.colorBufferMaxIndex > 0)
		{
			for (int i = 0; i <= pass.colorBufferMaxIndex; i++)
			{
				if (!colorBuffers[i].IsValid())
				{
					throw new InvalidOperationException("MRT setup is invalid. Some indices are not used.");
				}
				tempArray[i] = m_Resources.GetTexture(in colorBuffers[i]);
			}
			if (!pass.depthBuffer.IsValid())
			{
				throw new InvalidOperationException("Setting MRTs without a depth buffer is not supported.");
			}
			CoreUtils.SetRenderTarget(rgContext.cmd, tempArray, m_Resources.GetTexture(pass.depthBuffer));
		}
		else if (pass.depthBuffer.IsValid())
		{
			if (pass.colorBufferMaxIndex > -1)
			{
				CoreUtils.SetRenderTarget(rgContext.cmd, m_Resources.GetTexture(in pass.colorBuffers[0]), m_Resources.GetTexture(pass.depthBuffer));
			}
			else
			{
				CoreUtils.SetRenderTarget(rgContext.cmd, m_Resources.GetTexture(pass.depthBuffer));
			}
		}
		else
		{
			CoreUtils.SetRenderTarget(rgContext.cmd, m_Resources.GetTexture(in pass.colorBuffers[0]));
		}
	}

	private void PreRenderPassExecute(in CompiledPassInfo passInfo, RenderGraphContext rgContext)
	{
		RenderGraphPass pass = passInfo.pass;
		m_PreviousCommandBuffer = rgContext.cmd;
		for (int i = 0; i < 2; i++)
		{
			foreach (int item in passInfo.resourceCreateList[i])
			{
				m_Resources.CreatePooledResource(rgContext, i, item);
			}
		}
		PreRenderPassSetRenderTargets(in passInfo, rgContext);
		if (passInfo.enableAsyncCompute)
		{
			rgContext.renderContext.ExecuteCommandBuffer(rgContext.cmd);
			rgContext.cmd.Clear();
			CommandBuffer commandBuffer = CommandBufferPool.Get(pass.name);
			commandBuffer.SetExecutionFlags(CommandBufferExecutionFlags.AsyncCompute);
			rgContext.cmd = commandBuffer;
		}
		if (passInfo.syncToPassIndex != -1)
		{
			rgContext.cmd.WaitOnAsyncGraphicsFence(m_CompiledPassInfos[passInfo.syncToPassIndex].fence);
		}
	}

	private void PostRenderPassExecute(ref CompiledPassInfo passInfo, RenderGraphContext rgContext)
	{
		if (passInfo.needGraphicsFence)
		{
			passInfo.fence = rgContext.cmd.CreateAsyncGraphicsFence();
		}
		if (passInfo.enableAsyncCompute)
		{
			rgContext.renderContext.ExecuteCommandBufferAsync(rgContext.cmd, ComputeQueueType.Background);
			CommandBufferPool.Release(rgContext.cmd);
			rgContext.cmd = m_PreviousCommandBuffer;
		}
		m_RenderGraphPool.ReleaseAllTempAlloc();
		for (int i = 0; i < 2; i++)
		{
			foreach (int item in passInfo.resourceReleaseList[i])
			{
				m_Resources.ReleasePooledResource(rgContext, i, item);
			}
		}
	}

	private void ClearRenderPasses()
	{
		foreach (RenderGraphPass renderPass in m_RenderPasses)
		{
			renderPass.Release(m_RenderGraphPool);
		}
		m_RenderPasses.Clear();
	}

	private void ReleaseImmediateModeResources()
	{
		for (int i = 0; i < 2; i++)
		{
			foreach (int item in m_ImmediateModeResourceList[i])
			{
				m_Resources.ReleasePooledResource(m_RenderGraphContext, i, item);
			}
		}
	}

	private void LogFrameInformation()
	{
		if (m_DebugParameters.enableLogging)
		{
			m_FrameInformationLogger.LogLine("==== Staring render graph frame for: " + m_CurrentExecutionName + " ====");
			if (!m_DebugParameters.immediateMode)
			{
				m_FrameInformationLogger.LogLine("Number of passes declared: {0}\n", m_RenderPasses.Count);
			}
		}
	}

	private void LogRendererListsCreation()
	{
		if (m_DebugParameters.enableLogging)
		{
			m_FrameInformationLogger.LogLine("Number of renderer lists created: {0}\n", m_RendererLists.Count);
		}
	}

	private void LogRenderPassBegin(in CompiledPassInfo passInfo)
	{
		if (!m_DebugParameters.enableLogging)
		{
			return;
		}
		RenderGraphPass pass = passInfo.pass;
		m_FrameInformationLogger.LogLine("[{0}][{1}] \"{2}\"", pass.index, pass.enableAsyncCompute ? "Compute" : "Graphics", pass.name);
		using (new RenderGraphLogIndent(m_FrameInformationLogger))
		{
			if (passInfo.syncToPassIndex != -1)
			{
				m_FrameInformationLogger.LogLine("Synchronize with [{0}]", passInfo.syncToPassIndex);
			}
		}
	}

	private void LogCulledPasses()
	{
		if (!m_DebugParameters.enableLogging)
		{
			return;
		}
		m_FrameInformationLogger.LogLine("Pass Culling Report:");
		using (new RenderGraphLogIndent(m_FrameInformationLogger))
		{
			for (int i = 0; i < m_CompiledPassInfos.size; i++)
			{
				if (m_CompiledPassInfos[i].culled)
				{
					RenderGraphPass renderGraphPass = m_RenderPasses[i];
					m_FrameInformationLogger.LogLine("[{0}] {1}", renderGraphPass.index, renderGraphPass.name);
				}
			}
			m_FrameInformationLogger.LogLine("\n");
		}
	}

	private ProfilingSampler GetDefaultProfilingSampler(string name)
	{
		int hashCode = name.GetHashCode();
		if (!m_DefaultProfilingSamplers.TryGetValue(hashCode, out var value))
		{
			value = new ProfilingSampler(name);
			m_DefaultProfilingSamplers.Add(hashCode, value);
		}
		return value;
	}

	private void UpdateImportedResourceLifeTime(ref RenderGraphDebugData.ResourceDebugData data, List<int> passList)
	{
		foreach (int pass in passList)
		{
			if (data.creationPassIndex == -1)
			{
				data.creationPassIndex = pass;
			}
			else
			{
				data.creationPassIndex = Math.Min(data.creationPassIndex, pass);
			}
			if (data.releasePassIndex == -1)
			{
				data.releasePassIndex = pass;
			}
			else
			{
				data.releasePassIndex = Math.Max(data.releasePassIndex, pass);
			}
		}
	}

	private void GenerateDebugData()
	{
		if (m_ExecutionExceptionWasRaised)
		{
			return;
		}
		if (!requireDebugData)
		{
			CleanupDebugData();
			return;
		}
		if (!m_DebugData.TryGetValue(m_CurrentExecutionName, out var value))
		{
			onExecutionRegistered?.Invoke(this, m_CurrentExecutionName);
			value = new RenderGraphDebugData();
			m_DebugData.Add(m_CurrentExecutionName, value);
		}
		value.Clear();
		for (int i = 0; i < 2; i++)
		{
			for (int j = 0; j < m_CompiledResourcesInfos[i].size; j++)
			{
				ref CompiledResourceInfo reference = ref m_CompiledResourcesInfos[i][j];
				RenderGraphDebugData.ResourceDebugData data = new RenderGraphDebugData.ResourceDebugData
				{
					name = m_Resources.GetRenderGraphResourceName((RenderGraphResourceType)i, j),
					imported = m_Resources.IsRenderGraphResourceImported((RenderGraphResourceType)i, j),
					creationPassIndex = -1,
					releasePassIndex = -1,
					consumerList = new List<int>(reference.consumers),
					producerList = new List<int>(reference.producers)
				};
				if (data.imported)
				{
					UpdateImportedResourceLifeTime(ref data, data.consumerList);
					UpdateImportedResourceLifeTime(ref data, data.producerList);
				}
				value.resourceLists[i].Add(data);
			}
		}
		for (int k = 0; k < m_CompiledPassInfos.size; k++)
		{
			ref CompiledPassInfo reference2 = ref m_CompiledPassInfos[k];
			RenderGraphDebugData.PassDebugData item = new RenderGraphDebugData.PassDebugData
			{
				name = reference2.pass.name,
				culled = reference2.culled,
				generateDebugData = reference2.pass.generateDebugData,
				resourceReadLists = new List<int>[2],
				resourceWriteLists = new List<int>[2]
			};
			for (int l = 0; l < 2; l++)
			{
				item.resourceReadLists[l] = new List<int>();
				item.resourceWriteLists[l] = new List<int>();
				foreach (ResourceHandle item2 in reference2.pass.resourceReadLists[l])
				{
					item.resourceReadLists[l].Add(item2);
				}
				foreach (ResourceHandle item3 in reference2.pass.resourceWriteLists[l])
				{
					item.resourceWriteLists[l].Add(item3);
				}
				foreach (int item4 in reference2.resourceCreateList[l])
				{
					RenderGraphDebugData.ResourceDebugData value2 = value.resourceLists[l][item4];
					if (!value2.imported)
					{
						value2.creationPassIndex = k;
						value.resourceLists[l][item4] = value2;
					}
				}
				foreach (int item5 in reference2.resourceReleaseList[l])
				{
					RenderGraphDebugData.ResourceDebugData value3 = value.resourceLists[l][item5];
					if (!value3.imported)
					{
						value3.releasePassIndex = k;
						value.resourceLists[l][item5] = value3;
					}
				}
			}
			value.passList.Add(item);
		}
	}

	private void CleanupDebugData()
	{
		foreach (KeyValuePair<string, RenderGraphDebugData> debugDatum in m_DebugData)
		{
			onExecutionUnregistered?.Invoke(this, debugDatum.Key);
		}
		m_DebugData.Clear();
	}
}
