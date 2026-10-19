using System;
using System.Diagnostics;
using UnityEngine.Rendering.Universal.Internal;

namespace UnityEngine.Rendering.Universal;

[Tooltip("With this Renderer Feature, Unity can project specific Materials (decals) onto other objects in the Scene.")]
[DisallowMultipleRendererFeature("Decal")]
public class DecalRendererFeature : ScriptableRendererFeature
{
	[SerializeField]
	public DecalSettings m_Settings = new DecalSettings();

	[NonSerialized]
	private DecalSettings m_RuntimeSettings;

	private DecalTechnique m_Technique;

	private bool m_RecreateSystems;

	private DecalEntityManager m_DecalEntityManager;

	private DecalUpdateCachedSystem m_DecalUpdateCachedSystem;

	private DecalCreateDrawCallSystem m_DecalCreateDrawCallSystem;

	private DecalDrawErrorSystem m_DrawErrorSystem;

	private bool m_HasDrawsForCamera;

	private DecalSkipCulledSystem m_DecalSkipCulledSystem;

	private DecalGBufferRenderPass m_GBufferRenderPass;

	private DecalDrawGBufferSystem m_DrawGBufferSystem;

	private DeferredLights m_DeferredLights;

	private static SharedDecalEntityManager sharedDecalEntityManager { get; } = new SharedDecalEntityManager();

	public DecalSettings runtimeSettings
	{
		get
		{
			EnsureRuntimeSettings();
			return m_RuntimeSettings;
		}
	}

	private void EnsureRuntimeSettings()
	{
		if (m_RuntimeSettings == null)
		{
			m_RuntimeSettings = ((m_Settings != null) ? m_Settings.Clone() : new DecalSettings());
		}
	}

	public override void ApplyRuntimeSettings()
	{
		m_RecreateSystems = true;
	}

	public override void Create()
	{
		EnsureRuntimeSettings();
		m_RecreateSystems = true;
	}

	internal DecalTechnique GetTechnique(ScriptableRendererData renderer)
	{
		UniversalRendererData universalRendererData = renderer as UniversalRendererData;
		if (universalRendererData == null)
		{
			Debug.LogError("Only universal renderer supports Decal renderer feature.");
			return DecalTechnique.Invalid;
		}
		bool isDeferred = universalRendererData.renderingMode == RenderingMode.Deferred;
		return GetTechnique(isDeferred);
	}

	internal DecalTechnique GetTechnique(ScriptableRenderer renderer)
	{
		if (!(renderer is UniversalRenderer universalRenderer))
		{
			Debug.LogError("Only universal renderer supports Decal renderer feature.");
			return DecalTechnique.Invalid;
		}
		bool isDeferred = universalRenderer.renderingMode == RenderingMode.Deferred;
		return GetTechnique(isDeferred);
	}

	private DecalTechnique GetTechnique(bool isDeferred)
	{
		if (SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES2)
		{
			Debug.LogError("Decals are not supported with OpenGLES2.");
			return DecalTechnique.Invalid;
		}
		if (!isDeferred)
		{
			return DecalTechnique.Invalid;
		}
		return DecalTechnique.GBuffer;
	}

	private void RecreateSystemsIfNeeded(ScriptableRenderer renderer, in CameraData cameraData)
	{
		if (m_RecreateSystems)
		{
			m_GBufferRenderPass = null;
			m_DrawGBufferSystem = null;
			m_DeferredLights = null;
			m_Technique = GetTechnique(renderer);
			if (m_DecalEntityManager == null)
			{
				m_DecalEntityManager = sharedDecalEntityManager.Get();
			}
			m_DecalUpdateCachedSystem = new DecalUpdateCachedSystem(m_DecalEntityManager);
			m_DecalCreateDrawCallSystem = new DecalCreateDrawCallSystem(m_DecalEntityManager, runtimeSettings.maxDrawDistance);
			m_DecalSkipCulledSystem = new DecalSkipCulledSystem(m_DecalEntityManager);
			m_DrawErrorSystem = new DecalDrawErrorSystem(m_DecalEntityManager, m_Technique);
			UniversalRenderer universalRenderer = renderer as UniversalRenderer;
			if (m_Technique == DecalTechnique.GBuffer)
			{
				m_DeferredLights = universalRenderer.deferredLights;
				m_DrawGBufferSystem = new DecalDrawGBufferSystem(m_DecalEntityManager);
				m_GBufferRenderPass = new DecalGBufferRenderPass(null);
			}
			m_RecreateSystems = false;
		}
	}

	public override void OnCameraPreCull(ScriptableRenderer renderer, in CameraData cameraData)
	{
		if (!runtimeSettings.enabled)
		{
			m_HasDrawsForCamera = false;
		}
		else if (cameraData.cameraType != CameraType.Preview)
		{
			RecreateSystemsIfNeeded(renderer, in cameraData);
			m_DecalEntityManager.Update();
			m_DecalUpdateCachedSystem.Execute();
			m_DecalSkipCulledSystem.Execute(cameraData.camera);
			m_DecalCreateDrawCallSystem.Execute();
			m_HasDrawsForCamera = false;
			if (m_Technique == DecalTechnique.GBuffer)
			{
				m_HasDrawsForCamera = m_DrawGBufferSystem.Execute(in cameraData);
			}
			m_DrawErrorSystem.Execute(in cameraData);
		}
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		bool hasDrawsForCamera = m_HasDrawsForCamera;
		m_HasDrawsForCamera = false;
		if (runtimeSettings.enabled && renderingData.cameraData.cameraType != CameraType.Preview)
		{
			RecreateSystemsIfNeeded(renderer, in renderingData.cameraData);
			if (m_Technique == DecalTechnique.GBuffer && hasDrawsForCamera)
			{
				m_GBufferRenderPass.Setup(m_DeferredLights);
				renderer.EnqueuePass(m_GBufferRenderPass);
			}
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (m_DecalEntityManager != null)
		{
			m_DecalEntityManager = null;
			sharedDecalEntityManager.Release(m_DecalEntityManager);
		}
	}

	[Conditional("ADAPTIVE_PERFORMANCE_4_0_0_OR_NEWER")]
	private void ChangeAdaptivePerformanceDrawDistances()
	{
	}
}
