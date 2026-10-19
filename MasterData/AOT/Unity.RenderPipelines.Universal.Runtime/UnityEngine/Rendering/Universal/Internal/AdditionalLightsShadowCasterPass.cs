using System;
using System.Collections.Generic;
using Unity.Collections;

namespace UnityEngine.Rendering.Universal.Internal;

public sealed class AdditionalLightsShadowCasterPass : ScriptableRenderPass, IDisposable
{
	private static class AdditionalShadowsConstantBuffer
	{
		public static readonly int _AdditionalLightsWorldToShadow = Shader.PropertyToID("_AdditionalLightsWorldToShadow");

		public static readonly int _AdditionalShadowParams = Shader.PropertyToID("_AdditionalShadowParams");

		public static readonly int _ShadowParams = Shader.PropertyToID("_ShadowParams");

		public static readonly int _AdditionalShadowOffset0 = Shader.PropertyToID("_AdditionalShadowOffset0");

		public static readonly int _AdditionalShadowOffset1 = Shader.PropertyToID("_AdditionalShadowOffset1");

		public static readonly int _AdditionalShadowOffset2 = Shader.PropertyToID("_AdditionalShadowOffset2");

		public static readonly int _AdditionalShadowOffset3 = Shader.PropertyToID("_AdditionalShadowOffset3");

		public static readonly int _AdditionalShadowFadeParams = Shader.PropertyToID("_AdditionalShadowFadeParams");

		public static readonly int _AdditionalShadowmapSize = Shader.PropertyToID("_AdditionalShadowmapSize");

		public static readonly int _AdditionalLightsShadowmapTexture = Shader.PropertyToID("_AdditionalLightsShadowmapTexture");
	}

	private sealed class CachedShadow
	{
		public Light light;

		public UniversalAdditionalLightData additionalData;

		public int lightId;

		public LightType lightType;

		public int sliceCount;

		public readonly int[] tiles = new int[6];

		public readonly ShadowSliceData[] slices = new ShadowSliceData[6];

		public readonly Matrix4x4[] worldToShadow = new Matrix4x4[6];

		public byte pendingMask;

		public byte scheduledMask;

		public bool valid;

		public int visibleLightIndex = -1;

		public int lastScheduledFrame;

		public float cameraDistanceSq;

		public float range;

		public float rasterDepthBias;

		public void Reset()
		{
			light = null;
			additionalData = null;
			lightId = 0;
			lightType = LightType.Spot;
			sliceCount = 0;
			pendingMask = 0;
			scheduledMask = 0;
			valid = false;
			visibleLightIndex = -1;
			lastScheduledFrame = 0;
			cameraDistanceSq = 0f;
			range = 0f;
			rasterDepthBias = 0f;
		}
	}

	private struct UpdateRequest
	{
		public CachedShadow shadow;

		public int face;

		public int visibleLightIndex;
	}

	private struct ScheduleCandidate : IComparable<ScheduleCandidate>
	{
		public int cacheEntryIndex;

		public float urgency;

		public float cameraDistanceSq;

		public int lightId;

		public int CompareTo(ScheduleCandidate other)
		{
			int num = other.urgency.CompareTo(urgency);
			if (num != 0)
			{
				return num;
			}
			num = cameraDistanceSq.CompareTo(other.cameraDistanceSq);
			if (num != 0)
			{
				return num;
			}
			return lightId.CompareTo(other.lightId);
		}
	}

	private struct VisibleShadowRecord
	{
		public int visibleLightIndex;

		public int additionalLightIndex;

		public int lightId;

		public CachedShadow shadow;
	}

	private enum RenderPath : byte
	{
		None,
		GameCached,
		SceneRealtime
	}

	private const int k_ShadowmapBufferBits = 16;

	private const int k_ClearShadowTileDepthPass = 2;

	private const float k_SpotLightType = 0f;

	private const float k_PointLightType = 1f;

	private static readonly Vector4 k_DefaultShadowParams = new Vector4(0f, 0f, 0f, -1f);

	private readonly Dictionary<int, CachedShadow> m_Cache;

	private readonly List<CachedShadow> m_CacheEntries;

	private readonly CachedShadow[] m_CacheEntryPool;

	private readonly ProfilingSampler m_SetupSampler = new ProfilingSampler("Setup Cached Additional Shadows");

	private readonly Material m_DepthClearMaterial;

	private RTHandle m_ShadowAtlas;

	private RTHandle m_EmptyShadowmap;

	private int m_AtlasWidth;

	private int m_SliceResolution;

	private int m_TilesPerRow;

	private readonly int[] m_FreeTiles;

	private int m_FreeCacheEntryCount;

	private int m_FreeTileCount;

	private bool m_AtlasCapacityWarningIssued;

	private bool m_EnabledForCamera;

	private readonly Vector4[] m_ShadowParams;

	private readonly Vector4[] m_AdditionalShadowParams;

	private readonly Matrix4x4[] m_WorldToShadow;

	private readonly UpdateRequest[] m_UpdateRequests;

	private readonly ScheduleCandidate[] m_ScheduleCandidates;

	private readonly VisibleShadowRecord[] m_VisibleShadowRecords;

	private int[] m_VisibleLightIndexToShadowLightIndex;

	private int m_CurrentVisibleLightCount;

	private int m_UpdateRequestCount;

	private int m_VisibleValidSliceCount;

	private int m_VisibleShadowRecordCount;

	private int m_CacheFrame;

	private int m_LastDriverUnityFrame = -1;

	private float m_MaxShadowDistanceSq;

	private float m_CascadeBorder;

	private RenderPath m_RenderPath;

	private RenderTargetIdentifier m_CurrentShadowmap;

	private int m_CurrentAtlasWidth;

	private int m_CurrentSliceResolution;

	public static RenderTargetIdentifier s_ShadowMapID;

	public int shadowSliceCount => m_VisibleValidSliceCount;

	public int shadowTotalCount => m_UpdateRequestCount;

	public int lightArea => m_CurrentSliceResolution * m_CurrentSliceResolution / 100;

	public AdditionalLightsShadowCasterPass(RenderPassEvent evt, Material depthClearMaterial)
	{
		profilingSampler = new ProfilingSampler("AdditionalLightsShadowCasterPass");
		renderPassEvent = evt;
		m_DepthClearMaterial = depthClearMaterial;
		int maxVisibleAdditionalLights = UniversalRenderPipeline.maxVisibleAdditionalLights;
		int num = 64;
		m_Cache = new Dictionary<int, CachedShadow>(num);
		m_CacheEntries = new List<CachedShadow>(num);
		m_CacheEntryPool = new CachedShadow[num];
		for (int i = 0; i < num; i++)
		{
			m_CacheEntryPool[i] = new CachedShadow();
		}
		m_FreeCacheEntryCount = num;
		m_FreeTiles = new int[num];
		m_ShadowParams = new Vector4[maxVisibleAdditionalLights];
		m_AdditionalShadowParams = new Vector4[maxVisibleAdditionalLights];
		m_WorldToShadow = new Matrix4x4[num];
		m_UpdateRequests = new UpdateRequest[num];
		m_ScheduleCandidates = new ScheduleCandidate[num];
		m_VisibleShadowRecords = new VisibleShadowRecord[maxVisibleAdditionalLights];
		m_VisibleLightIndexToShadowLightIndex = new int[Mathf.Max(maxVisibleAdditionalLights + 1, num)];
	}

	public bool Setup(CommandBuffer cmd, ref RenderingData renderingData)
	{
		using (new ProfilingScope(null, m_SetupSampler))
		{
			m_UpdateRequestCount = 0;
			m_VisibleValidSliceCount = 0;
			m_VisibleShadowRecordCount = 0;
			m_EnabledForCamera = false;
			m_RenderPath = RenderPath.None;
			m_CurrentAtlasWidth = 0;
			m_CurrentSliceResolution = 0;
			EnsureVisibleLightArray(renderingData.lightData.visibleLights.Length);
			ResetPerCameraState();
			EnsureEmptyShadowmap();
			if (!renderingData.shadowData.supportsAdditionalLightShadows || renderingData.cameraData.renderType != CameraRenderType.Base)
			{
				targetCount = 0u;
				return false;
			}
			m_MaxShadowDistanceSq = renderingData.cameraData.maxShadowDistance * renderingData.cameraData.maxShadowDistance;
			m_CascadeBorder = renderingData.shadowData.mainLightShadowCascadeBorder;
			if (renderingData.cameraData.cameraType == CameraType.Game)
			{
				return SetupGameCached(ref renderingData);
			}
			targetCount = 0u;
			renderingData.shadowData.supportsAdditionalLightShadows = false;
			return false;
		}
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		if (!m_EnabledForCamera)
		{
			SetupEmptyReceiverConstants(cmd);
			renderingData.shadowData.supportsAdditionalLightShadows = false;
			return;
		}
		if (targetCount != 0)
		{
			RenderScheduledTiles(ref context, ref renderingData);
		}
		BuildReceiverData(ref renderingData.lightData, ref renderingData.shadowData);
		bool supportsAdditionalLightShadows = m_VisibleValidSliceCount > 0;
		renderingData.shadowData.supportsAdditionalLightShadows = supportsAdditionalLightShadows;
		SetupReceiverConstants(cmd);
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
	}

	public void Dispose()
	{
		ReleaseCachedShadowAtlas();
		if (m_EmptyShadowmap != null)
		{
			RTHandles.Release(m_EmptyShadowmap);
			m_EmptyShadowmap = null;
		}
	}

	internal void ReleaseCachedShadowAtlas()
	{
		if (m_ShadowAtlas != null)
		{
			RTHandles.Release(m_ShadowAtlas);
			m_ShadowAtlas = null;
		}
		for (int i = 0; i < m_CacheEntries.Count; i++)
		{
			ReturnCacheEntry(m_CacheEntries[i]);
		}
		m_Cache.Clear();
		m_CacheEntries.Clear();
		m_FreeTileCount = 0;
		m_AtlasWidth = 0;
		m_SliceResolution = 0;
		m_TilesPerRow = 0;
		m_UpdateRequestCount = 0;
		m_VisibleValidSliceCount = 0;
		m_VisibleShadowRecordCount = 0;
		m_EnabledForCamera = false;
		m_RenderPath = RenderPath.None;
		m_CurrentShadowmap = default;
		m_CurrentAtlasWidth = 0;
		m_CurrentSliceResolution = 0;
		m_LastDriverUnityFrame = -1;
		m_AtlasCapacityWarningIssued = false;
		targetCount = 0u;
		s_ShadowMapID = default;
	}

	public int GetShadowLightIndexFromLightIndex(int visibleLightIndex)
	{
		if (visibleLightIndex < 0 || visibleLightIndex >= m_CurrentVisibleLightCount)
		{
			return -1;
		}
		return m_VisibleLightIndexToShadowLightIndex[visibleLightIndex];
	}

	private void EnsureVisibleLightArray(int visibleCount)
	{
		m_CurrentVisibleLightCount = visibleCount;
		if (m_VisibleLightIndexToShadowLightIndex.Length < visibleCount)
		{
			m_VisibleLightIndexToShadowLightIndex = new int[visibleCount];
		}
	}

	private void ResetPerCameraState()
	{
		for (int i = 0; i < m_CurrentVisibleLightCount; i++)
		{
			m_VisibleLightIndexToShadowLightIndex[i] = -1;
		}
		for (int j = 0; j < m_ShadowParams.Length; j++)
		{
			m_ShadowParams[j] = k_DefaultShadowParams;
			m_AdditionalShadowParams[j] = k_DefaultShadowParams;
		}
		for (int k = 0; k < m_WorldToShadow.Length; k++)
		{
			m_WorldToShadow[k] = Matrix4x4.identity;
		}
	}

	private void ResetCacheVisibility()
	{
		for (int i = 0; i < m_CacheEntries.Count; i++)
		{
			m_CacheEntries[i].visibleLightIndex = -1;
			m_CacheEntries[i].scheduledMask = 0;
		}
	}

	private bool SetupGameCached(ref RenderingData renderingData)
	{
		EnsureAtlas(ref renderingData.shadowData);
		if (m_ShadowAtlas == null || m_DepthClearMaterial == null)
		{
			targetCount = 0u;
			renderingData.shadowData.supportsAdditionalLightShadows = false;
			return false;
		}
		m_RenderPath = RenderPath.GameCached;
		m_CurrentShadowmap = m_ShadowAtlas.nameID;
		s_ShadowMapID = m_CurrentShadowmap;
		m_CurrentAtlasWidth = m_AtlasWidth;
		m_CurrentSliceResolution = m_SliceResolution;
		m_EnabledForCamera = true;
		int num = (renderTargetHeight = m_AtlasWidth);
		renderTargetWidth = num;
		ResetCacheVisibility();
		bool flag = IsCacheDriver(ref renderingData.cameraData);
		if (flag)
		{
			m_CacheFrame++;
		}
		CollectVisibleLights(ref renderingData, flag);
		if (flag)
		{
			ScheduleUpdates(ref renderingData.shadowData);
		}
		bool flag2 = m_UpdateRequestCount > 0;
		targetCount = (flag2 ? 1u : 0u);
		ConfigureTarget(m_CurrentShadowmap, ShadowUtils.shadowTexDes.depthStencilFormat, depth: true);
		ConfigureDepthAttachment(RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, ClearFlag.None, Color.black);
		bool flag3 = flag2 || m_VisibleValidSliceCount > 0;
		renderingData.shadowData.supportsAdditionalLightShadows = flag3;
		return flag3;
	}

	private void EnsureAtlas(ref ShadowData shadowData)
	{
		int num = Mathf.Max(128, Mathf.NextPowerOfTwo(shadowData.additionalLightsShadowmapWidth));
		int num2 = Mathf.Clamp(Mathf.NextPowerOfTwo(shadowData.additionalLightsShadowSliceResolution), 128, num);
		if (m_ShadowAtlas == null || m_AtlasWidth != num || m_SliceResolution != num2)
		{
			if (m_ShadowAtlas != null)
			{
				RTHandles.Release(m_ShadowAtlas);
			}
			RenderTextureDescriptor descriptor = ShadowUtils.shadowTexDes;
			descriptor.width = num;
			descriptor.height = num;
			descriptor.depthBufferBits = 16;
			m_ShadowAtlas = RTHandles.Alloc(in descriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: true, 1, 0f, "_AdditionalLightsShadowmapTexture");
			s_ShadowMapID = m_ShadowAtlas.nameID;
			m_AtlasWidth = num;
			m_SliceResolution = num2;
			m_TilesPerRow = num / num2;
			int num3 = (m_FreeTileCount = Mathf.Min(m_TilesPerRow * m_TilesPerRow, 64));
			for (int i = 0; i < num3; i++)
			{
				m_FreeTiles[i] = num3 - 1 - i;
			}
			for (int j = 0; j < m_CacheEntries.Count; j++)
			{
				ReturnCacheEntry(m_CacheEntries[j]);
			}
			m_Cache.Clear();
			m_CacheEntries.Clear();
			m_AtlasCapacityWarningIssued = false;
		}
	}

	private void EnsureEmptyShadowmap()
	{
		if (m_EmptyShadowmap == null)
		{
			RenderTextureDescriptor descriptor = ShadowUtils.shadowTexDes;
			descriptor.width = 1;
			descriptor.height = 1;
			descriptor.depthBufferBits = 16;
			m_EmptyShadowmap = RTHandles.Alloc(in descriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: true, 1, 0f, "_AdditionalLightsEmptyShadowmapTexture");
		}
	}

	private bool IsCacheDriver(ref CameraData cameraData)
	{
		if (cameraData.cameraType != CameraType.Game || m_LastDriverUnityFrame == Time.frameCount)
		{
			return false;
		}
		m_LastDriverUnityFrame = Time.frameCount;
		return true;
	}

	private void CollectVisibleLights(ref RenderingData renderingData, bool cacheDriver)
	{
		NativeArray<VisibleLight> visibleLights = renderingData.lightData.visibleLights;
		int mainLightIndex = renderingData.lightData.mainLightIndex;
		Vector3 position = renderingData.cameraData.camera.transform.position;
		PreparedLightFrameData preparedLights = renderingData.lightData.preparedLights;
		if (preparedLights == null)
		{
			return;
		}
		int[] shadowCandidateVisibleLightIndices = preparedLights.shadowCandidateVisibleLightIndices;
		for (int i = 0; i < preparedLights.shadowCandidateCount; i++)
		{
			int num = shadowCandidateVisibleLightIndices[i];
			if (num == mainLightIndex || !renderingData.cullResults.GetShadowCasterBounds(num, out var _))
			{
				continue;
			}
			VisibleLight visibleLight = visibleLights[num];
			Light light = visibleLight.light;
			int instanceID = light.GetInstanceID();
			bool flag = m_Cache.TryGetValue(instanceID, out var value);
			if (flag && ((object)value.light != light || value.lightType != visibleLight.lightType))
			{
				if (!cacheDriver)
				{
					continue;
				}
				RemoveCacheEntry(value);
				flag = false;
				value = null;
			}
			if (!flag && !cacheDriver)
			{
				continue;
			}
			int num2 = num;
			if (mainLightIndex >= 0 && num > mainLightIndex)
			{
				num2--;
			}
			if ((uint)num2 < (uint)m_AdditionalShadowParams.Length)
			{
				if (value != null)
				{
					value.visibleLightIndex = num;
				}
				m_VisibleShadowRecords[m_VisibleShadowRecordCount++] = new VisibleShadowRecord
				{
					visibleLightIndex = num,
					additionalLightIndex = num2,
					lightId = instanceID,
					shadow = value
				};
			}
		}
		m_VisibleValidSliceCount = 0;
		for (int j = 0; j < m_VisibleShadowRecordCount; j++)
		{
			ref VisibleShadowRecord reference = ref m_VisibleShadowRecords[j];
			int visibleLightIndex = reference.visibleLightIndex;
			VisibleLight visibleLight2 = visibleLights[visibleLightIndex];
			Light light2 = visibleLight2.light;
			CachedShadow value2 = reference.shadow;
			if (value2 == null)
			{
				if (!m_Cache.TryGetValue(reference.lightId, out value2) && !TryCreateCacheEntry(light2, reference.lightId, visibleLight2.lightType, preparedLights.visibleLights[visibleLightIndex].additionalData, renderingData.shadowData.additionalLightShadowDepthBias, out value2))
				{
					continue;
				}
				reference.shadow = value2;
			}
			value2.visibleLightIndex = visibleLightIndex;
			value2.cameraDistanceSq = (position - light2.transform.position).sqrMagnitude;
			value2.range = light2.range;
			if (value2.valid)
			{
				m_VisibleValidSliceCount += value2.sliceCount;
			}
			if (cacheDriver)
			{
				UpdateBudgetedPendingState(value2);
			}
		}
	}

	private static float GetRasterDepthBias(Light light, UniversalAdditionalLightData additionalData, float pipelineDepthBias)
	{
		float b = ((additionalData == null || additionalData.usePipelineSettings) ? pipelineDepthBias : light.shadowBias);
		return Mathf.Max(0f, b);
	}

	private static float GetReceiverNormalBias(Light light, UniversalAdditionalLightData additionalData, float pipelineNormalBias)
	{
		float b = ((additionalData == null || additionalData.usePipelineSettings) ? pipelineNormalBias : light.shadowNormalBias);
		return Mathf.Max(0f, b);
	}

	private bool TryCreateCacheEntry(Light light, int lightId, LightType lightType, UniversalAdditionalLightData additionalData, float pipelineDepthBias, out CachedShadow shadow)
	{
		int num = ((lightType != LightType.Point) ? 1 : 6);
		if (m_FreeTileCount < num)
		{
			EvictInvisibleEntries(num);
			if (m_FreeTileCount < num)
			{
				shadow = null;
				return false;
			}
		}
		if (m_FreeCacheEntryCount == 0)
		{
			shadow = null;
			return false;
		}
		shadow = m_CacheEntryPool[--m_FreeCacheEntryCount];
		shadow.light = light;
		shadow.lightId = lightId;
		shadow.lightType = lightType;
		shadow.sliceCount = num;
		shadow.lastScheduledFrame = m_CacheFrame - 1;
		shadow.additionalData = additionalData;
		shadow.rasterDepthBias = GetRasterDepthBias(light, shadow.additionalData, pipelineDepthBias);
		for (int i = 0; i < num; i++)
		{
			shadow.tiles[i] = m_FreeTiles[--m_FreeTileCount];
		}
		InvalidateAllSlices(shadow);
		m_Cache.Add(shadow.lightId, shadow);
		m_CacheEntries.Add(shadow);
		return true;
	}

	private void EvictInvisibleEntries(int requiredTiles)
	{
		int num = m_CacheEntries.Count - 1;
		while (num >= 0 && m_FreeTileCount < requiredTiles)
		{
			CachedShadow cachedShadow = m_CacheEntries[num];
			if (cachedShadow.visibleLightIndex < 0)
			{
				ReleaseTiles(cachedShadow);
				m_Cache.Remove(cachedShadow.lightId);
				m_CacheEntries.RemoveAt(num);
				ReturnCacheEntry(cachedShadow);
			}
			num--;
		}
	}

	private void ReleaseTiles(CachedShadow shadow)
	{
		for (int i = 0; i < shadow.sliceCount; i++)
		{
			m_FreeTiles[m_FreeTileCount++] = shadow.tiles[i];
		}
	}

	private void RemoveCacheEntry(CachedShadow shadow)
	{
		ReleaseTiles(shadow);
		m_Cache.Remove(shadow.lightId);
		m_CacheEntries.Remove(shadow);
		ReturnCacheEntry(shadow);
	}

	private void ReturnCacheEntry(CachedShadow shadow)
	{
		shadow.Reset();
		m_CacheEntryPool[m_FreeCacheEntryCount++] = shadow;
	}

	private void UpdateBudgetedPendingState(CachedShadow shadow)
	{
		if (GetEffectiveUpdateMode(shadow) == AdditionalShadowUpdateMode.Budgeted && shadow.pendingMask == 0)
		{
			if (shadow.lightType == LightType.Point)
			{
				QueueAllSlices(shadow);
			}
			else
			{
				shadow.pendingMask = 1;
			}
		}
	}

	private AdditionalShadowUpdateMode GetEffectiveUpdateMode(CachedShadow shadow)
	{
		if (shadow.additionalData == null)
		{
			return AdditionalShadowUpdateMode.CachedStatic;
		}
		return shadow.additionalData.additionalShadowUpdateMode;
	}

	private void InvalidateAllSlices(CachedShadow shadow)
	{
		shadow.valid = false;
		QueueAllSlices(shadow);
	}

	private static void QueueAllSlices(CachedShadow shadow)
	{
		shadow.pendingMask = (byte)((1 << shadow.sliceCount) - 1);
	}

	private unsafe void ScheduleUpdates(ref ShadowData shadowData)
	{
		int num = (shadowData.additionalShadowTimeSlicingEnabled ? Mathf.Clamp(shadowData.maxAdditionalShadowTilesPerFrame, 0, m_UpdateRequests.Length) : m_UpdateRequests.Length);
		if (num == 0)
		{
			return;
		}
		int num2 = 0;
		for (int i = 0; i < m_CacheEntries.Count; i++)
		{
			CachedShadow cachedShadow = m_CacheEntries[i];
			if (cachedShadow.visibleLightIndex >= 0 && cachedShadow.pendingMask != 0)
			{
				m_ScheduleCandidates[num2++] = new ScheduleCandidate
				{
					cacheEntryIndex = i,
					urgency = GetRuntimeUpdateUrgency(cachedShadow),
					cameraDistanceSq = cachedShadow.cameraDistanceSq,
					lightId = cachedShadow.lightId
				};
			}
		}
		if (num2 > 1)
		{
			fixed (ScheduleCandidate* scheduleCandidates = m_ScheduleCandidates)
			{
				CoreUnsafeUtils.QuickSort<ScheduleCandidate>(num2, scheduleCandidates);
			}
		}
		for (int j = 0; j < 6; j++)
		{
			if (m_UpdateRequestCount >= num)
			{
				break;
			}
			for (int k = 0; k < num2; k++)
			{
				if (m_UpdateRequestCount >= num)
				{
					break;
				}
				CachedShadow cachedShadow2 = m_CacheEntries[m_ScheduleCandidates[k].cacheEntryIndex];
				if ((byte)(cachedShadow2.pendingMask & ~cachedShadow2.scheduledMask) != 0)
				{
					int firstAvailableFace = GetFirstAvailableFace(cachedShadow2);
					cachedShadow2.scheduledMask |= (byte)(1 << firstAvailableFace);
					m_UpdateRequests[m_UpdateRequestCount++] = new UpdateRequest
					{
						shadow = cachedShadow2,
						face = firstAvailableFace,
						visibleLightIndex = cachedShadow2.visibleLightIndex
					};
				}
			}
		}
	}

	private static int GetFirstAvailableFace(CachedShadow shadow)
	{
		byte b = (byte)(shadow.pendingMask & ~shadow.scheduledMask);
		for (int i = 0; i < shadow.sliceCount; i++)
		{
			if ((b & (1 << i)) != 0)
			{
				return i;
			}
		}
		return 0;
	}

	private float GetRuntimeUpdateUrgency(CachedShadow shadow)
	{
		float num = Mathf.Max(shadow.range * shadow.range, 0.0001f);
		float num2 = Mathf.Clamp01(shadow.cameraDistanceSq / num);
		float num3 = (1f - num2) * 8f;
		float num4 = (shadow.valid ? 0f : 8f);
		return (float)(m_CacheFrame - shadow.lastScheduledFrame) + num4 + num3;
	}

	private void RenderScheduledTiles(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		NativeArray<VisibleLight> visibleLights = renderingData.lightData.visibleLights;
		using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.AdditionalLightsShadow)))
		{
			for (int i = 0; i < m_UpdateRequestCount; i++)
			{
				UpdateRequest updateRequest = m_UpdateRequests[i];
				CachedShadow shadow = updateRequest.shadow;
				int visibleLightIndex = updateRequest.visibleLightIndex;
				if (visibleLightIndex >= 0 && visibleLightIndex < visibleLights.Length && !(visibleLights[visibleLightIndex].light != shadow.light) && ExtractSlice(ref renderingData, shadow, visibleLightIndex, updateRequest.face))
				{
					ShadowSliceData slice = shadow.slices[updateRequest.face];
					ClearShadowTile(cmd, ref slice);
					VisibleLight shadowLight = visibleLights[visibleLightIndex];
					ShadowDrawingSettings shadowDrawingSettings = new ShadowDrawingSettings(renderingData.cullResults, visibleLightIndex, BatchCullingProjectionType.Perspective);
					shadowDrawingSettings.useRenderingLayerMaskTest = renderingData.lightData.supportsLightLayers;
					shadowDrawingSettings.splitData = slice.splitData;
					ShadowDrawingSettings settings = shadowDrawingSettings;
					ShadowUtils.SetupShadowCasterConstantBuffer(cmd, ref shadowLight, Vector4.zero);
					ShadowUtils.RenderShadowSlice(cmd, ref context, ref slice, ref settings, shadow.rasterDepthBias, renderingData.shadowData.additionalLightShadowSlopeBias);
					shadow.slices[updateRequest.face] = slice;
					shadow.lastScheduledFrame = m_CacheFrame;
					shadow.pendingMask &= (byte)(~(1 << updateRequest.face));
					if (shadow.pendingMask == 0)
					{
						shadow.valid = true;
					}
				}
			}
		}
	}

	private void ClearShadowTile(CommandBuffer cmd, ref ShadowSliceData slice)
	{
		cmd.SetViewport(new Rect(slice.offsetX, slice.offsetY, slice.resolution, slice.resolution));
		cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, m_DepthClearMaterial, 0, 2);
	}

	private bool ExtractSlice(ref RenderingData renderingData, CachedShadow cached, int visibleIndex, int face)
	{
		ShadowSliceData shadowSliceData = cached.slices[face];
		bool flag;
		Matrix4x4 shadowMatrix;
		if (cached.lightType == LightType.Point)
		{
			float pointLightShadowFrustumFovBiasInDegrees = GetPointLightShadowFrustumFovBiasInDegrees(m_SliceResolution);
			flag = ShadowUtils.ExtractPointLightMatrix(ref renderingData.cullResults, ref renderingData.shadowData, visibleIndex, (CubemapFace)face, pointLightShadowFrustumFovBiasInDegrees, out shadowMatrix, out shadowSliceData.viewMatrix, out shadowSliceData.projectionMatrix, out shadowSliceData.splitData);
		}
		else
		{
			flag = ShadowUtils.ExtractSpotLightMatrix(ref renderingData.cullResults, ref renderingData.shadowData, visibleIndex, out shadowMatrix, out shadowSliceData.viewMatrix, out shadowSliceData.projectionMatrix, out shadowSliceData.splitData);
		}
		if (!flag)
		{
			return false;
		}
		int num = cached.tiles[face];
		shadowSliceData.offsetX = num % m_TilesPerRow * m_SliceResolution;
		shadowSliceData.offsetY = num / m_TilesPerRow * m_SliceResolution;
		shadowSliceData.resolution = m_SliceResolution;
		shadowSliceData.shadowTransform = shadowMatrix;
		ShadowUtils.ApplySliceTransform(ref shadowSliceData, m_AtlasWidth, m_AtlasWidth);
		cached.slices[face] = shadowSliceData;
		cached.worldToShadow[face] = shadowSliceData.shadowTransform;
		return true;
	}

	private void BuildReceiverData(ref LightData lightData, ref ShadowData shadowData)
	{
		int num = 0;
		m_VisibleValidSliceCount = 0;
		for (int i = 0; i < m_VisibleShadowRecordCount; i++)
		{
			VisibleShadowRecord visibleShadowRecord = m_VisibleShadowRecords[i];
			CachedShadow shadow = visibleShadowRecord.shadow;
			if (shadow == null || !shadow.valid || num + shadow.sliceCount > m_WorldToShadow.Length)
			{
				continue;
			}
			int visibleLightIndex = visibleShadowRecord.visibleLightIndex;
			VisibleLight shadowLight = lightData.visibleLights[visibleLightIndex];
			Light light = shadowLight.light;
			if ((object)shadow.light == light)
			{
				for (int j = 0; j < shadow.sliceCount; j++)
				{
					m_WorldToShadow[num + j] = shadow.worldToShadow[j];
				}
				float receiverNormalBias = GetReceiverNormalBias(light, shadow.additionalData, shadowData.additionalLightShadowNormalBias);
				float punctualReceiverNormalBias = ShadowUtils.GetPunctualReceiverNormalBias(ref shadowLight, m_CurrentSliceResolution, receiverNormalBias);
				Vector4 vector = new Vector4(light.shadowStrength, punctualReceiverNormalBias, (shadow.lightType == LightType.Point) ? 1f : 0f, num);
				int additionalLightIndex = visibleShadowRecord.additionalLightIndex;
				m_ShadowParams[additionalLightIndex] = vector;
				m_AdditionalShadowParams[additionalLightIndex] = vector;
				m_VisibleLightIndexToShadowLightIndex[visibleLightIndex] = additionalLightIndex;
				num += shadow.sliceCount;
				m_VisibleValidSliceCount += shadow.sliceCount;
			}
		}
	}

	private void SetupReceiverConstants(CommandBuffer cmd)
	{
		float num = 1f / (float)m_CurrentAtlasWidth;
		float num2 = 0.5f * num;
		cmd.SetGlobalTexture(AdditionalShadowsConstantBuffer._AdditionalLightsShadowmapTexture, m_CurrentShadowmap);
		cmd.SetGlobalVectorArray(AdditionalShadowsConstantBuffer._ShadowParams, m_ShadowParams);
		cmd.SetGlobalVectorArray(AdditionalShadowsConstantBuffer._AdditionalShadowParams, m_AdditionalShadowParams);
		cmd.SetGlobalMatrixArray(AdditionalShadowsConstantBuffer._AdditionalLightsWorldToShadow, m_WorldToShadow);
		ShadowUtils.GetScaleAndBiasForLinearDistanceFade(m_MaxShadowDistanceSq, m_CascadeBorder, out var scale, out var bias);
		cmd.SetGlobalVector(AdditionalShadowsConstantBuffer._AdditionalShadowFadeParams, new Vector4(scale, bias, 0f, 0f));
		cmd.SetGlobalVector(AdditionalShadowsConstantBuffer._AdditionalShadowOffset0, new Vector4(0f - num2, 0f - num2, 0f, 0f));
		cmd.SetGlobalVector(AdditionalShadowsConstantBuffer._AdditionalShadowOffset1, new Vector4(num2, 0f - num2, 0f, 0f));
		cmd.SetGlobalVector(AdditionalShadowsConstantBuffer._AdditionalShadowOffset2, new Vector4(0f - num2, num2, 0f, 0f));
		cmd.SetGlobalVector(AdditionalShadowsConstantBuffer._AdditionalShadowOffset3, new Vector4(num2, num2, 0f, 0f));
		cmd.SetGlobalVector(AdditionalShadowsConstantBuffer._AdditionalShadowmapSize, new Vector4(num, num, m_CurrentAtlasWidth, m_CurrentAtlasWidth));
	}

	private void SetupEmptyReceiverConstants(CommandBuffer cmd)
	{
		cmd.SetGlobalTexture(AdditionalShadowsConstantBuffer._AdditionalLightsShadowmapTexture, m_EmptyShadowmap.nameID);
		cmd.SetGlobalVectorArray(AdditionalShadowsConstantBuffer._ShadowParams, m_ShadowParams);
		cmd.SetGlobalVectorArray(AdditionalShadowsConstantBuffer._AdditionalShadowParams, m_AdditionalShadowParams);
	}

	internal static float GetPointLightShadowFrustumFovBiasInDegrees(int shadowSliceResolution)
	{
		float num = 4f;
		if (shadowSliceResolution <= 16)
		{
			num = 43f;
		}
		else if (shadowSliceResolution <= 32)
		{
			num = 18.55f;
		}
		else if (shadowSliceResolution <= 64)
		{
			num = 8.63f;
		}
		else if (shadowSliceResolution <= 128)
		{
			num = 4.13f;
		}
		else if (shadowSliceResolution <= 256)
		{
			num = 2.03f;
		}
		else if (shadowSliceResolution <= 512)
		{
			num = 1f;
		}
		else if (shadowSliceResolution <= 1024)
		{
			num = 0.5f;
		}
		if (shadowSliceResolution <= 32)
		{
			num += 9.35f;
		}
		else if (shadowSliceResolution <= 64)
		{
			num += 4.07f;
		}
		else if (shadowSliceResolution <= 128)
		{
			num += 1.77f;
		}
		else if (shadowSliceResolution <= 256)
		{
			num += 0.85f;
		}
		else if (shadowSliceResolution <= 512)
		{
			num += 0.39f;
		}
		else if (shadowSliceResolution <= 1024)
		{
			num += 0.17f;
		}
		return num;
	}
}
