using System;
using UnityEngine.Serialization;

namespace UnityEngine.Rendering.Universal;

public class TAAFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		public bool enabled = true;

		[Obsolete("Use UniversalRenderPipelineAsset.temporalJitterScale instead.")]
		[HideInInspector]
		public float jitterSize = 1f;

		[FormerlySerializedAs("mobileStaticHistoryWeight")]
		[Range(0f, 1f)]
		[Header("History Feedback")]
		[FormerlySerializedAs("characterStaticHistoryWeight")]
		public float staticHistoryWeight = 0.9f;

		[Range(0f, 1f)]
		[FormerlySerializedAs("characterMovingHistoryWeight")]
		[FormerlySerializedAs("mobileMovingHistoryWeight")]
		public float movingHistoryWeight = 0.75f;

		[FormerlySerializedAs("characterMotionThreshold")]
		[FormerlySerializedAs("mobileMotionThreshold")]
		[Range(0.001f, 1f)]
		public float motionThreshold = 0.1f;

		[HideInInspector]
		[Obsolete("Use UniversalRenderPipelineAsset.uberPostSharpening instead.")]
		public float uberPostSharpening = 0.5f;

		[Header("History Lifetime")]
		[Range(0.01f, 1f)]
		public float historyResetDeltaTime = 0.1f;

		public Settings Clone()
		{
			return (Settings)MemberwiseClone();
		}
	}

	[SerializeField]
	public Shader taaShader;

	[SerializeField]
	public Settings settings = new Settings();

	private TAAPass _taaPass;

	[NonSerialized]
	private Material m_BlitMaterial;

	[NonSerialized]
	private Settings m_RuntimeSettings;

	public Settings runtimeSettings
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
			m_RuntimeSettings = ((settings != null) ? settings.Clone() : new Settings());
		}
	}

	public override void Create()
	{
		EnsureRuntimeSettings();
		if (m_BlitMaterial != null && m_BlitMaterial.shader != taaShader)
		{
			CoreUtils.Destroy(m_BlitMaterial);
			m_BlitMaterial = null;
			_taaPass = null;
		}
		if (m_BlitMaterial == null && taaShader != null)
		{
			m_BlitMaterial = CoreUtils.CreateEngineMaterial(taaShader);
			_taaPass = null;
		}
		if (_taaPass == null)
		{
			_taaPass = new TAAPass(m_BlitMaterial, runtimeSettings);
		}
		else
		{
			_taaPass.Setup(runtimeSettings);
		}
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (runtimeSettings.enabled && renderingData.cameraData.isGameCamera)
		{
			SetupLegacyTAA(renderer, ref renderingData);
		}
	}

	private void SetupLegacyTAA(ScriptableRenderer renderer, ref RenderingData renderingData)
	{
		renderingData.cameraData.camera.depthTextureMode |= DepthTextureMode.Depth | DepthTextureMode.MotionVectors;
		renderingData.postProcessingData.motionVector = true;
		if (renderer is UniversalRenderer universalRenderer)
		{
			universalRenderer.CurrentFrameNeedTAA = true;
			universalRenderer.RequestTemporalJitter(runtimeSettings.historyResetDeltaTime);
			universalRenderer.CurrentFrameNeedTemporalDepth = true;
		}
		_taaPass.Setup(runtimeSettings);
		renderingData.postProcessingData.RegisterTemporalResolver(_taaPass, fallback: true);
	}

	internal void SetupFallback(UniversalRenderer renderer, ref RenderingData renderingData)
	{
		SetupLegacyTAA(renderer, ref renderingData);
	}

	protected override void Dispose(bool disposing)
	{
		CoreUtils.Destroy(m_BlitMaterial);
		m_BlitMaterial = null;
		_taaPass = null;
	}
}
